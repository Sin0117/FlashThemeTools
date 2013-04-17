package org.sjx.components {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import org.sjx.utils.TextFormats;
	
	public class TabButton extends Sprite {
		
		[Embed(source="images/tab-btns.png")]
		public static var BG: Class;
		
		public static const WIDTH: int = 98;
		public static const HEIGHT: int = 24;
		
		private var data: BitmapData;
		
		private var _isDown: Boolean;
		
		private var _txt: String;
		private var _overBtn: Sprite;
		private var _overLab: TextField;
		private var _outBtn: Sprite;
		private var _outLab: TextField;
		private var _downBtn: Sprite;
		private var _downLab: TextField;
		
		public function TabButton(txt: String = null) {
			this.buttonMode = true;
			data = Bitmap(new BG()).bitmapData;
			
			_overLab = new TextField();
			_outLab = new TextField();
			_downLab = new TextField();
			
			_overBtn = draw(new Matrix(1, 0, 0, 1, 0, 0), _overLab, TextFormats.TAB_BUTTON_HOVER_FORMAT);
			_outBtn = draw(new Matrix(1, 0, 0, 1, 0, -HEIGHT), _outLab, TextFormats.TAB_BUTTON_FORMAT);
			_downBtn = draw(new Matrix(1, 0, 0, 1, 0, -2 * HEIGHT), _downLab, TextFormats.TAB_BUTTON_DOWN_FORMAT);
			
			this.addEventListener(MouseEvent.MOUSE_OVER, function (evt: MouseEvent): void {
				if (_isDown) {
					doDown();
				} else {
					doOver();
				}
			});
			this.addEventListener(MouseEvent.MOUSE_OUT, function (evt: MouseEvent): void {
				if (_isDown) {
					doDown();
				} else {
					doOut();
				}
			});
			this.addEventListener(MouseEvent.CLICK, function (evt: MouseEvent): void {
				doDown();
			});
			doOut();
			text = txt;
		}
		
		public function doOver(): void {
			_overBtn.visible = true;
			_outBtn.visible = false;
			_downBtn.visible = false;
		}
		public function doDown(): void {
			_overBtn.visible = false;
			_outBtn.visible = false;
			_downBtn.visible = true;
			_isDown = true;
		}
		public function doUp(): void {
			_overBtn.visible = false;
			_outBtn.visible = true;
			_downBtn.visible = false;
			_isDown = false;
		}
		public function doOut(): void {
			_overBtn.visible = false;
			_outBtn.visible = true;
			_downBtn.visible = false;
		}
		
		public function set text(txt: String): void {
			_txt = txt;
			_overLab.text = _txt;
			_overLab.setTextFormat(TextFormats.TAB_BUTTON_HOVER_FORMAT);
			_outLab.text = _txt;
			_outLab.setTextFormat(TextFormats.TAB_BUTTON_FORMAT);
			_downLab.text = _txt;
			_downLab.setTextFormat(TextFormats.TAB_BUTTON_DOWN_FORMAT);
		}
		
		private function draw(type: Matrix, lab: TextField, tf: TextFormat): Sprite {
			var button: Sprite = new Sprite();
			button.graphics.lineStyle(1, 0, .005);
			button.graphics.beginBitmapFill(data, type);
			button.graphics.drawRect(0, 0, WIDTH, HEIGHT);
			button.graphics.endFill();
			button.buttonMode = true;
			addChild(button);
			
			lab.x = 0;
			lab.y = 2;
			lab.mouseEnabled = false;
			lab.width = WIDTH;
			lab.height = HEIGHT - 4;
			button.addChild(lab);
			return button;
		}
	}
}