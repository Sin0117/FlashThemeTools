package org.sjx.components {
	import com.qihoo.themefactory.sjx.components.LoaderSprite;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	import org.sjx.data.Terminal;

	public class Preview extends Sprite{
		
		[Embed(source="images/phone_bg.png")]
		public static var PreviewBg: Class;
		
		// 预览的整体界面
		private var _space: Sprite;
		
		private var _prev: Editer;
		private var _lock: LoaderSprite;
		private var _main: ViewButton;
		private var _drawer: ViewButton;
		
		// 当前显示的视图.
		public var view: String = 'main';
		// 图片缩放比例
		public var zoom: Number = 1;
		
		// 预览区坐标
		public var previewX: int;
		public var previewY: int;
		
		private var _bg: BitmapData;
		
		private var _root: SchoolCompete;
		
		public function Preview(r: SchoolCompete) {
			_root = r;
			_space = new Sprite();
			_space.x = 0;
			_space.y = 0;
			addChild(_space);
			
			_bg = Bitmap(new PreviewBg()).bitmapData;
			graphics.beginBitmapFill(_bg, new Matrix(1, 0, 0, 1, 0, 0), false, true);
			graphics.drawRect(0, 0, SchoolCompete.PREVIEW_BG_WIDTH, SchoolCompete.PREVIEW_BG_HEIGHT);
			graphics.endFill();
			
			_prev = new Editer(this);
			previewX = SchoolCompete.EDITER_X;
			previewY = SchoolCompete.EDITER_Y;
			addChild(_prev);
			
			_lock = new LoaderSprite('http://p4.qhimg.com/t0144c59deccdcb1dc7.gif', Editer.WIDTH, Editer.HEIGHT);
			_lock.x = previewX;
			_lock.y = previewY;
			_lock.hide();
			addChild(_lock);
			_lock.text = '加载图片中...';
			
			this.addEventListener(Event.ADDED_TO_STAGE, function (evt: Event): void {
				_prev.render(Terminal.terminal);
				_prev.update(Terminal.data);
			});
			
			_main = new ViewButton('第一屏图标预览');
			_main.x = SchoolCompete.PEWVIEW_WIDTH - ViewButton.WIDTH * 2 - 32 >> 1;
			_main.y = SchoolCompete.PREVIEW_BG_HEIGHT + 36;
			_space.addChild(_main);
			_main.addEventListener(MouseEvent.CLICK, function (evt: MouseEvent): void {
				_prev.view = 'main';
			});
			
			_drawer = new ViewButton('第二屏图标预览');
			_drawer.x = SchoolCompete.PEWVIEW_WIDTH - _main.x - ViewButton.WIDTH;
			_drawer.y = _main.y;
			_space.addChild(_drawer);
			_drawer.addEventListener(MouseEvent.CLICK, function (evt: MouseEvent): void {
				_prev.view = 'drawer';
			});
		}
		
		public function update(items: Object): void {
			for (var pack: String in items)
				_prev.change(pack, Terminal.host + items[pack]);
		}
		
		public function clear(): void {
			for (var i: int = 0, item: Object; item = Terminal.items[i]; i ++)
				_prev.change(item.pack, null);
		}
		
		public function updateAt(pack: String, url: String): void {
			_prev.change(pack, url);
		}
		
		public function doLoad(): void {
			_lock.show();
		}
		
		public function doLoaded(): void {
			_lock.hide();
		}
	}
}