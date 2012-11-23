package org.sjx.components {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	
	public class ScrollBar extends Sprite {
		
		public static const CURRENT_POINT_COLOR: uint = 0xAAAAAA;
		public static const BG_COLOR: uint = 0xDADADA;
		
		public static const DRAG_EVENT: String = 'ScrollDrag';
		public static const DRAG_MOVE_EVENT: String = 'ScrollMoveDrag';
		public static const CLICK_EVENT: String = 'ScrollClick';
		
		private var _viewWidth: int;
		private var _viewHeight: int;
		private var _viewRound: int;
		private var _scrollHeight: int;
		private var _scrollTop: int;
		private var _sorHeight: Number;
		private var _height: int;
		
		private var _cur: Sprite;
		
		public var curMouseY: int;
		public var curMoveY: int;
		
		public function ScrollBar(w: int, h: int, sh: int = 0, st: int = 0, r: int = 4) {
			_viewWidth = w;
			_viewHeight = h;
			_viewRound = r;
			_scrollHeight = sh;
			_scrollTop = st;
			
			_cur = new Sprite();
			_cur.addEventListener(MouseEvent.MOUSE_DOWN, doMouseDown);
			addChild(_cur);
			draw();
			
			addEventListener(MouseEvent.CLICK, doMouseClick);
			
			this.addEventListener(Event.ADDED_TO_STAGE, function (evt: Event): void {
				stage.addEventListener(MouseEvent.MOUSE_WHEEL, doMouseWheel);
			});
			this.addEventListener(Event.REMOVED_FROM_STAGE, function (evt: Event): void {
				stage.removeEventListener(MouseEvent.MOUSE_WHEEL, doMouseWheel);
			});
		}
		
		/** 鼠标在滚动条之外的地方点击处理. */
		private function doMouseClick(evt: MouseEvent): void {
			if (mouseY < _cur.y) {
				scrollTop -= _sorHeight;
				dispatchEvent(new Event(DRAG_MOVE_EVENT));
			} else {
				if (mouseY > _cur.y + _sorHeight) {
					scrollTop += _sorHeight;
					dispatchEvent(new Event(DRAG_MOVE_EVENT));
				}
			}
		}
		
		/** 滚轮监听. */
		private function doMouseWheel(evt: MouseEvent): void {
			scrollTop -= evt.delta;
			dispatchEvent(new Event(DRAG_MOVE_EVENT));
		}
		
		/** 鼠标拖拽. */
		private function doMouseDown(evt: MouseEvent): void {
			stage.addEventListener(MouseEvent.MOUSE_MOVE, doMouseMove);
			stage.addEventListener(MouseEvent.MOUSE_UP, doMouseUp);
			curMouseY = stage.mouseY;
			curMoveY = 0;
			this.dispatchEvent(new Event(DRAG_EVENT));
		}
		private function doMouseUp(evt: MouseEvent = null): void {
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, doMouseMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, doMouseUp);
		}
		private function doMouseMove(evt: MouseEvent): void {
			if (evt.buttonDown) {
				curMoveY = stage.mouseY - curMouseY;
				curMouseY = stage.mouseY;
				scrollTop += curMoveY;
				dispatchEvent(new Event(DRAG_MOVE_EVENT));
			} else {
				doMouseUp();
			}
		}
		
		/** 绘制界面. */
		private function draw(): void {
			graphics.clear();
			_cur.graphics.clear();
			graphics.beginFill(BG_COLOR);
			graphics.drawRoundRect(_viewWidth * .25, 0, _viewWidth * .5, _viewHeight, _viewRound);
			graphics.endFill();
	
			if (_scrollHeight > _viewHeight) {
				_cur.graphics.beginFill(CURRENT_POINT_COLOR);
				_cur.graphics.drawRoundRect(0, 0, 
					_viewWidth, _sorHeight = _viewHeight / _scrollHeight  * _viewHeight, _viewRound);
				_cur.graphics.endFill();
			}
		}
		
		/** vh是显示区域高度. */
		public function resize(vh: int): void {
			update(vh, _scrollHeight);
		}
		
		/** 更新显示区域高度和内容高度. */
		public function update(vh: int, h: int): void {
			_scrollHeight = h;
			draw();
		}
		
		public function get zoom(): Number {
			return _scrollHeight / _viewHeight;
		}
		
		public function set scrollTop(t: Number): void {
			_cur.y = t;
			if (_cur.y < 0)
				_cur.y = 0;
			if (_cur.y > _viewHeight - _sorHeight) {
				_cur.y = _viewHeight - _sorHeight;
			}
		}
		public function get scrollTop(): Number {
			return _cur.y;
		}
	}
}