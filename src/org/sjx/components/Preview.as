package org.sjx.components {
	import com.qihoo.themefactory.sjx.components.LoaderSprite;
	
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import org.sjx.data.Terminal;

	public class Preview extends Sprite{
		
		public static const WIDTH: int = 480;
		public static const HEIGHT: int = 580;
		
		// 预览的整体界面
		private var _space: Sprite;
		
		private var _prev: Editer;
		private var _lock: LoaderSprite;
		
		// 打包操作.
		private var _builder: Button;
		// 返回编辑.
		private var _back: Button;
		
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
			_space.graphics.drawRoundRect(0, 0, WIDTH, HEIGHT, 8);
			_space.graphics.endFill();
			_space.x = SchoolCompete.WIDTH - WIDTH >> 1;
			_space.y = SchoolCompete.HEIGHT - HEIGHT >> 1;
			addChild(_space);
			
			previewX = _space.x + (WIDTH - Editer.WIDTH >> 1);
			previewY = _space.y + 36;
			
			_prev = new Editer(this);
			addChild(_prev);
			
			_lock = new LoaderSprite('http://p4.qhimg.com/t0144c59deccdcb1dc7.gif', Editer.WIDTH, Editer.HEIGHT);
			_lock.x = 0;
			_lock.y = 0;
			_lock.hide();
			addChild(_lock);
			_lock.text = '加载图片中...';
			
			this.addEventListener(Event.ADDED_TO_STAGE, function (evt: Event): void {
trace ('add to stage!');				
				_prev.render(Terminal.terminal);
				_prev.update(Terminal.data);
			});
			
			var g: Graphics = this.graphics;
			g.lineStyle(1, 0, 0);
			g.beginFill(0x333333, .4);
			g.drawRect(0, 0, SchoolCompete.WIDTH, SchoolCompete.HEIGHT);
			g.endFill();
			
			_main = new Button('主屏');
			_main.x = WIDTH - Button.WIDTH * 2 - 32 >> 1;
			_main.y = HEIGHT - Button.HEIGHT * 2 - 48;
			_space.addChild(_main);
			_main.addEventListener(MouseEvent.CLICK, function (evt: MouseEvent): void {
				_prev.view = 'main';
			});
			
			_drawer = new Button('抽屉');
			_drawer.x = WIDTH - _main.x - Button.WIDTH;
			_drawer.y = _main.y;
			_space.addChild(_drawer);
			_drawer.addEventListener(MouseEvent.CLICK, function (evt: MouseEvent): void {
				_prev.view = 'drawer';
			});
			
			_builder = new Button('打包');
			_builder.x = _main.x;
			_builder.y = HEIGHT - Button.HEIGHT - 32;
			_space.addChild(_builder);
			_builder.addEventListener(MouseEvent.CLICK, function (evt: MouseEvent): void {
				_root.doBuilder();
			});
			
			_back = new Button('返回');
			_back.x = _drawer.x;
			_back.y = _builder.y;
			_space.addChild(_back);
			_back.addEventListener(MouseEvent.CLICK, function (evt: MouseEvent): void {
				_root.preview = false;
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