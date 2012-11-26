package org.sjx.components {
	import com.qihoo.themefactory.sjx.components.LoaderSprite;
	
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import org.sjx.data.Terminal;

	public class Preview extends Sprite{
		
		// 预览的整体界面
		private var _space: Sprite;
		
		private var _prev: Editer;
		private var _lock: LoaderSprite;
		private var _main: Button;
		private var _drawer: Button;
		
		// 当前显示的视图.
		public var view: String = 'main';
		// 图片缩放比例
		public var zoom: Number = 1;
		
		// 预览区坐标
		public var previewX: int;
		public var previewY: int;
		
		private var _root: SchoolCompete;
		
		public function Preview(r: SchoolCompete) {
			_root = r;
			_space = new Sprite();
			_space.graphics.lineStyle(2, 0x777777, .4);
			_space.graphics.beginFill(0xFAFAFA, 1);
			_space.graphics.drawRoundRect(0, 0, SchoolCompete.PEWVIEW_WIDTH, SchoolCompete.PEWVIEW_HEIGHT, 8);
			_space.graphics.endFill();
			_space.x = 0;
			_space.y = 0;
			addChild(_space);
			
			_prev = new Editer(this);
			previewX = SchoolCompete.PEWVIEW_WIDTH - SchoolCompete.EDITER_WIDTH >> 1;
			previewY = 10;
			addChild(_prev);
			
			_lock = new LoaderSprite('http://p4.qhimg.com/t0144c59deccdcb1dc7.gif', Editer.WIDTH, Editer.HEIGHT);
			_lock.x = 0;
			_lock.y = 0;
			_lock.hide();
			addChild(_lock);
			_lock.text = '加载图片中...';
			
			this.addEventListener(Event.ADDED_TO_STAGE, function (evt: Event): void {
				_prev.render(Terminal.terminal);
				_prev.update(Terminal.data);
			});
			
			var g: Graphics = this.graphics;
			g.lineStyle(1, 0, 0);
			g.beginFill(0x333333, .4);
			g.drawRect(0, 0, SchoolCompete.PEWVIEW_WIDTH, SchoolCompete.PEWVIEW_HEIGHT);
			g.endFill();
			
			_main = new Button('主屏');
			_main.x = SchoolCompete.PEWVIEW_WIDTH - Button.WIDTH * 2 - 32 >> 1;
			_main.y = SchoolCompete.EDITER_HEIGHT + 8;
			_space.addChild(_main);
			_main.addEventListener(MouseEvent.CLICK, function (evt: MouseEvent): void {
				_prev.view = 'main';
			});
			
			_drawer = new Button('抽屉');
			_drawer.x = SchoolCompete.PEWVIEW_WIDTH - _main.x - Button.WIDTH;
			_drawer.y = _main.y;
			_space.addChild(_drawer);
			_drawer.addEventListener(MouseEvent.CLICK, function (evt: MouseEvent): void {
				_prev.view = 'drawer';
			});
		}
		
		public function update(items: Object): void {
			for (var pack: String in items) {
				_prev.change(pack, Terminal.host + items[pack]);
			}
		}
		
		public function doLoad(): void {
			_lock.show();
		}
		
		public function doLoaded(): void {
			_lock.hide();
		}
	}
}