package org.sjx.components {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import org.sjx.utils.TextFormats;
	
	public class Confirm extends Sprite {
		
		private var _okBtn: ViewButton;
		private var _cancelBtn: ViewButton;
		private var _label: TextField;
		
		public function Confirm(t: String, ok: Function, cancel: Function, w: int = 400, h: int = 240) {
			graphics.lineStyle(2, 0x777777);
			graphics.beginFill(0xFAFAFA, 0.8);
			graphics.drawRoundRect(0, 0, w, h, 8);
			graphics.endFill();
			
			_label = new TextField();
			_label.text = t;
			_label.setTextFormat(TextFormats.ALERT_FORMAT);
			_label.x = 20;
			_label.y = 64;
			_label.width = w - 40;
			_label.height = 20;
			_label.mouseEnabled = false;
			addChild(_label);
			
			_okBtn = new ViewButton('确定');
			_okBtn.x = w - 36 - ViewButton.WIDTH * 2 >> 1;
			_okBtn.y = h - ViewButton.HEIGHT - 28;
			addChild(_okBtn);
			_okBtn.addEventListener(MouseEvent.CLICK, function(evt: MouseEvent): void {
				ok && ok();
			});
			
			_cancelBtn = new ViewButton('取消');
			_cancelBtn.x = w - _okBtn.x - ViewButton.WIDTH;
			_cancelBtn.y = _okBtn.y;
			addChild(_cancelBtn);
			_cancelBtn.addEventListener(MouseEvent.CLICK, function(evt: MouseEvent): void {
				cancel && cancel();
			});
		}
	}
}