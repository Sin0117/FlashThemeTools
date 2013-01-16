package org.sjx.components {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import org.sjx.utils.TextFormats;
	
	public class ViewButton extends Sprite {
		
		[Embed(source="images/opt-btns.png")]
		public static var BG: Class;
		
		public static const WIDTH: int = 98;
		public static const HEIGHT: int = 33;
		
		public static const OFFSET: int = 126;
		
		private var data: BitmapData;
		private var martDef: Matrix;
		private var martFocus: Matrix;
		private var martDown: Matrix;
		
		private var _txt: String;
		private var _btn: SimpleButton;
		
		public function ViewButton(txt: String) {
			this.buttonMode = true;
			data = Bitmap(new BG()).bitmapData;
			martDef = new Matrix(1, 0, 0, 1, 0, -OFFSET);
			martFocus = new Matrix(1, 0, 0, 1, 0, -(OFFSET + HEIGHT));
			martDown = new Matrix(1, 0, 0, 1, 0, -(OFFSET + 2 * HEIGHT));
			
			text = txt;
		}
		
		public function set text(txt: String): void {
			_txt = txt;
			if (_btn && _btn.parent)
				removeChild(_btn);
			_btn = new SimpleButton(draw(martDef), draw(martFocus), draw(martDown), draw(martDef));
			addChild(_btn);
		}
		
		public function draw(type: Matrix): Sprite {
			var button: Sprite = new Sprite();
			button.graphics.lineStyle(1, 0, .005);
			button.graphics.beginBitmapFill(data, type);
			button.graphics.drawRect(0, 0, WIDTH, HEIGHT);
			button.graphics.endFill();
			
			var label: TextField = new TextField();
			label.x = 0;
			label.y = 8;
			label.width = WIDTH;
			label.height = 20;
			label.text = _txt;
			
			label.setTextFormat(TextFormats.BUTTON_FORMAT);
			button.addChild(label);
			return button;
		}
	}
}