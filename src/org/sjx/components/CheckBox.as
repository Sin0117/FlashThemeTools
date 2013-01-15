package org.sjx.components {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.text.TextField;
	
	import org.sjx.utils.TextFormats;
	
	/** 复选框组件. */
	public class CheckBox extends Sprite {
		
		[Embed(source="images/checkbox-icon.png")]
		public static var BG: Class;
		
		private var _bg: BitmapData;
		
		private var _iptLabel: TextField;
		private var _icon: Sprite;
		private var _selected: Boolean;
		
		private var _w: int;
		private var _h: int;
		
		private var _val: String;
		
		public function CheckBox(w: int, h: int, lab: String = "", val: String = "") {
			_w = w;
			_h = h;
			_val = val;
			
			_bg = Bitmap(new BG()).bitmapData;
			
			_iptLabel = new TextField();
			_iptLabel.text = lab;
			_iptLabel.setTextFormat(TextFormats.TEXT_FORMAT);
			_iptLabel.x = 22;
			_iptLabel.y = -2;
			_iptLabel.width = _w - 17;
			_iptLabel.height = 20;
			_iptLabel.mouseEnabled = false;
			addChild(_iptLabel);
			
			_icon = new Sprite();
			_icon.x = 0;
			_icon.y = _h - 19 >> 1;
			addChild(_icon);
			
			addEventListener(MouseEvent.CLICK, function (evt: MouseEvent): void {
				_selected = !_selected;
				draw(_selected ? 2 : 0);
			});
			addEventListener(MouseEvent.MOUSE_OVER, function (evt: MouseEvent): void {
				if (_selected) {
					draw(3);
				} else {
					draw(1);
				}
			});
			addEventListener(MouseEvent.MOUSE_OUT, function (evt: MouseEvent): void {
				if (_selected) {
					draw(2);
				} else {
					draw(0);
				}
			});
			
			graphics.beginFill(0xFFFFFF, 0.05);
			graphics.drawRect(0, 0, _w, _h);
			graphics.endFill();
			draw(0);
		}
		
		private function draw(type: int): void {
			_icon.graphics.clear();
			var matr: Matrix = new Matrix(1, 0, 0, 1, 0, 0);
			if (type == 0) {
				_icon.graphics.beginBitmapFill(_bg, matr, false, true);
			}
			if (type == 1) {
				matr.createBox(1, 1, 0, 0, 0);
				_icon.graphics.beginBitmapFill(_bg, matr, false, true);
			}
			if (type == 2) {
				matr.createBox(1, 1, 0, 0, -19);
				_icon.graphics.beginBitmapFill(_bg, matr, false, true);
			}
			if (type == 3) {
				matr.createBox(1, 1, 0, 0, -19);
				_icon.graphics.beginBitmapFill(_bg, matr, false, true);
			}
			_icon.graphics.drawRect(0, 0, 19, 19);
			_icon.graphics.endFill();
		}
		
		public function get value(): String {
			return _val;
		}
		
		public function set selected(s: Boolean): void {
			_selected = s;
			if (_selected) {
				draw(2);
			} else {
				draw(0);
			}
		}
		public function get selected(): Boolean {
			return _selected;
		}
	}
}