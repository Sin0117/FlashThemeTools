package org.sjx.components {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.text.TextField;
	
	import org.sjx.utils.TextFormats;
	
	/** 下拉列表. */
	public class Select extends Sprite {
		
		[Embed(source="images/select-btn.png")]
		public static var BG: Class;
		
		public static const EVENT_CLICK: String = 'OptionClickEvent';
		
		private var _bg: BitmapData;
		
		private var _data: Array;
		private var _w: int;
		private var _h: int;
		
		private var _iptLabel: TextField;
		private var _border: Shape;
		private var _icon: Sprite;
		private var _list: Sprite;
		private var _items: Array;
		
		private var _color: uint;
		private var _focusColor: uint;
		
		private var _isOpen: Boolean;
		
		/** 下拉列表组件, 注： border为1，中线是0.5所以高度和宽度要额外加1。 */
		public function Select(width: int, height: int, d: Array, 
							   color: uint = 0xcccccc, focusColor: uint = 0x333333, 
							   disable: Boolean = false, defVal: String = null) {
			_data = d;
			_w = width;
			_h = height;
			_color = color;
			_focusColor = focusColor;
			
			_bg = Bitmap(new BG()).bitmapData;
			
			graphics.beginFill(0xFFFFFF, 0.05);
			graphics.drawRect(0, 0, _w, _h);
			graphics.endFill();
			
			_border = new Shape();
			_border.x = 0;
			_border.y = 0;
			addChild(_border);
			
			_icon = new Sprite();
			_icon.x = _w - 15;
			_icon.y = _h - 5 >> 1;
			addChild(_icon);
			if (!disable) {
				addEventListener(MouseEvent.CLICK, function (evt: MouseEvent): void {
					if (_isOpen) {
						_list.visible = false;
						draw(1);
					} else {
						_list.visible = true;
						_isOpen = true;
						draw(2);
					}
				});
				addEventListener(MouseEvent.MOUSE_OVER, function (evt: MouseEvent): void {
					if (!_isOpen) draw(1);
				});
				addEventListener(MouseEvent.MOUSE_OUT, function (evt: MouseEvent): void {
					if (!_isOpen) draw(0);
				});
			}
			
			_iptLabel = new TextField();
			if (_data.length)
				_iptLabel.text = _data[0];
			if (defVal)
				_iptLabel.text = defVal;
			_iptLabel.setTextFormat(TextFormats.TEXT_FORMAT);
			_iptLabel.x = 7;
			_iptLabel.y = _h - 20 >> 1;
			_iptLabel.width = _w - 24;
			_iptLabel.height = 18;
			_iptLabel.mouseEnabled = false;
			addChild(_iptLabel);
			
			_list = new Sprite();
			_list.x = 0;
			_list.y = _h - 1;
			addChild(_list);
			_list.visible = false;
			
			update();
			draw(0);
		}
		
		public function get value(): String {
			return _iptLabel.text;
		}
		public function set value(t: String): void {
			_iptLabel.text = t;
		}

		private function update(): void {
			_list.graphics.clear();
			_list.graphics.lineStyle(1, _color);
			_list.graphics.beginFill(0xEEEEEE, .9);
			_list.graphics.drawRect(0, 0, _w, _h * _data.length);
			_list.graphics.endFill();
			for (var i: int = 0, val: String; val = _data[i]; i ++) {
				var item: Input = new Input(_w - 2, _h + 2, false, 0xFFFFFF, 0xCCCCCC, _color, _focusColor);
				item.mouseEnable = false;
				item.buttonMode = true;
				item.text = val;
				item.x = 1;
				item.y = -1 + _h * i;
				item.addEventListener(MouseEvent.CLICK, doItemClick);
				_list.addChild(item);
			}
		}
		
		public function set data(d: Array): void {
			_data = d;
		}
		
		private function doItemOver(evt: MouseEvent): void {
			var item: Input = evt.currentTarget as Input;
			item.border = true;
		}
		private function doItemOut(evt: MouseEvent): void {
			var item: Input = evt.currentTarget as Input;
			item.border = false;
		}
		private function doItemClick(evt: MouseEvent): void {
			var item: Input = evt.currentTarget as Input;
			value = item.text;
			item.border = false;
			dispatchEvent(new Event(EVENT_CLICK));
		}
		
		private function draw(type: int): void {
			_icon.graphics.clear();
			_border.graphics.clear();
			var matr: Matrix = new Matrix(1, 0, 0, 1, 0, 0);
			if (type == 0) {
				_icon.graphics.beginBitmapFill(_bg, matr, false, true);
				_border.graphics.lineStyle(1, _color);
				_isOpen = false;
			}
			if (type == 1) {
				matr.createBox(1, 1, 0, 0, -5);
				_icon.graphics.beginBitmapFill(_bg, matr, false, true);
				_border.graphics.lineStyle(1, _focusColor);
				_isOpen = false;
			}
			if (type == 2) {
				matr.createBox(1, 1, 0, 0, -10);
				_icon.graphics.beginBitmapFill(_bg, matr, false, true);
				_border.graphics.lineStyle(1, _focusColor);
			}
			_icon.graphics.drawRect(0, 0, 10, 5);
			_icon.graphics.endFill();
			
			_border.graphics.drawRect(0, 0, _w, _h);
			_border.graphics.endFill();
		}
	}
}