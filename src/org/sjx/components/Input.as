package org.sjx.components {
	import flash.display.Sprite;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	import org.osmf.net.StreamingURLResource;
	
	public class Input extends Sprite {
		
		private var _label: TextField;
		private var _format: TextFormat;
		
		private var _isBorder: Boolean;
		
		private var _isFocus: Boolean;
		private var _ipt: Boolean;
		private var _w: int;
		private var _h: int;
		private var _th: int;
		private var _c: uint;
		private var _f: uint;
		private var _bc: uint;
		private var _bf: uint;
		
		public function Input(w: int, h: int, isIpt: Boolean = false, 
				  backgroundColor: uint = 0xffffff, backgroundFocus: uint = 0xffffff, 
				  borderColor: uint = 0x333333, borderFocus: uint = 0xcccccc, th: int = 22){
			_w = w;
			_h = h;
			_th = th;
			_c = backgroundColor;
			_f = backgroundFocus;
			_bc = borderColor;
			_bf = borderFocus;
			_ipt = isIpt;
			
			_label = new TextField();
			_label.type = _ipt ? TextFieldType.INPUT : TextFieldType.DYNAMIC;
			_label.y = _h - _th >> 1;
			_label.x = _label.y;
			_label.width = _w - _label.x * 2;
			_label.height = _th;
			addChild(_label);
			_label.addEventListener(FocusEvent.FOCUS_IN, doFocus);
			_label.addEventListener(FocusEvent.FOCUS_OUT, doBlur);
			
			addEventListener(MouseEvent.MOUSE_OVER, doOver);
			addEventListener(MouseEvent.MOUSE_OUT, doOut);
		}
		
		public function set type(t: Boolean): void {
			_ipt = t;
			_label.type = _ipt ? TextFieldType.INPUT : TextFieldType.DYNAMIC;
		}
		
		public function set maxChars(max: int): void {
			_label.maxChars = max;
		}
		
		public function setSelection(s: int, e: int): void {
			_label.setSelection(s, e);
		}
		
		public function set restrict(str: String): void {
			_label.restrict = str;
		}
			
		private function doOver(evt: MouseEvent): void {
			if (!_isFocus)
				draw(1);
		}
		private function doOut(evt: MouseEvent): void {
			if (!_isFocus)
				draw(0);
		}
		private function doFocus(evt: FocusEvent): void {
			_isFocus = true;
			draw(1);
			dispatchEvent(evt);
		}
		private function doBlur(evt: FocusEvent): void {
			_isFocus = false;
			draw(0);
			dispatchEvent(evt);
		}
		
		public function set text(txt: String): void {
			_label.text = txt;
			_format && _label.setTextFormat(_format);
		}
		public function get text(): String {
			return _label.text;
		}
		
		public function set border(b: Boolean): void {
			_isBorder = b;
			draw(0);
		}
		
		public function set mouseEnable(b: Boolean): void {
			_label.mouseEnabled = b;
		}
		
		public function setFormat(format: TextFormat): void {
			_label.setTextFormat(_format = format);
		}
		
		public function draw(type: int): void {
			graphics.clear();
			var borderColor: uint = type == 0 ? _bc : _bf,
				backgroundColor: uint = type == 0 ? _c : _f;
			if (_isBorder)
				graphics.lineStyle(1, borderColor);
			graphics.beginFill(backgroundColor);
			graphics.drawRect(0.5, 0.5, _w - 1, _h - 1);
			graphics.endFill();
		}
	}
}