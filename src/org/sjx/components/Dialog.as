package org.sjx.components {
	
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	public class Dialog extends Sprite {
		
		private var _rect: Rectangle;
		private var _view: DisplayObject;
		
		/** 提示框， view是将要显示的内容， rect是显示的位置和宽高. */
		public function Dialog(rect: Rectangle, view: DisplayObject = null) {
			var g: Graphics = this.graphics;
			g.lineStyle(1, 0, 0);
			g.beginFill(0x333333, .4);
			g.drawRect(0, 0, rect.width, rect.height);
			g.endFill();
			_rect = rect;
			view && update(view);
		}
		
		public function update(view: DisplayObject): void {
			if (_view && _view.parent)
				removeChild(_view);
			_view = view;
			_view.x = _rect.width - _view.width >> 1;
			_view.y = _rect.height - _view.height >> 1;
			addChild(_view);
			show();
		}
		
		public function show(): void {
			this.parent.setChildIndex(this, this.parent.numChildren - 1);
			this.visible = true;
		}
		
		public function hide(): void {
			this.visible = false;
		}
	}
}