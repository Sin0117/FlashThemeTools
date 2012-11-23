package org.sjx.components {
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import org.sjx.data.Terminal;
	import org.sjx.utils.TextFormats;
	
	public class UploadList extends Sprite {
		
		public static const WIDTH: int = 720;
		public static const HEIGHT: int = 488;
		
		private var _lists: Sprite;
		private var _mask: Shape;
		private var _scroll: ScrollBar;
		
		private var _root: SchoolCompete;
		private var _dialogView: Sprite;
		private var _dialogLab:  TextField;
		
		private var _itmes: Array;
		private var _scrollHeight: uint;
		
		public function UploadList(r: SchoolCompete) {
			_root = r;
			
			_itmes = [];
			_scrollHeight = 0;
			_lists = new Sprite();
			_lists.x = 0;
			_lists.y = 0;
			addChild(_lists);
			
			_scroll = new ScrollBar(12, HEIGHT, 8);
			_scroll.x = WIDTH - 12;
			_scroll.y = 0;
			_scroll.addEventListener(ScrollBar.DRAG_MOVE_EVENT, function (evt: Event): void {
				_lists.y = -_scroll.zoom * _scroll.scrollTop;
			});
			addChild(_scroll);
			
			_mask = new Shape();
			_mask.graphics.beginFill(0xFFFFFF);
			_mask.graphics.drawRect(0, 0, WIDTH, HEIGHT);
			_mask.graphics.endFill();
			addChild(_mask);
			mask = _mask;
			
			for (var i: int = 0, n: Object; n = Terminal.items[i]; i ++) {
				var pack: String = n['pack'], item: UploadItem = new UploadItem(pack, n, this);
				item.x = 0;
				item.y = _scrollHeight;
				_lists.addChild(item);
				_itmes.push(item);
				_root.update(pack, null);
				_scrollHeight += UploadItem.HEIGHT;
			}
			_scroll.update(HEIGHT, _scrollHeight);
			
			// 绘制弹出框
			_dialogView = new Sprite();
			_dialogView.graphics.lineStyle(2, 0x777777);
			_dialogView.graphics.beginFill(0xFAFAFA, 0.8);
			_dialogView.graphics.drawRoundRect(0, 0, 400, 240, 8);
			_dialogView.graphics.endFill();
			
			_dialogLab = new TextField();
			_dialogLab.x = 20;
			_dialogLab.y = 96;
			_dialogLab.width = 360;
			_dialogLab.height = 20;
			_dialogLab.mouseEnabled = false;
			_dialogView.addChild(_dialogLab);
			
			var btn: Button = new Button('确定');
			btn.x = 164;
			btn.y = 145;
			btn.addEventListener(MouseEvent.CLICK, function (evt: MouseEvent): void {
				_root.close();
			});
			_dialogView.addChild(btn);
		}
		
		/** 检测上传的数据项. */		
		public function check(): Boolean {
			for (var i: int = 0, n: UploadItem; n = _itmes[i] as UploadItem; i ++) {
				if (n.check())
					continue;
				return false;
			}
			return true;
		}
		
		/** 获取全部的上传项. */
		override public function toString(): String {
			var items: Array = [];
			for (var i: int = 0, n: UploadItem; n = _itmes[i]; i ++)
				items.push('"' + n.pack + '":"' + n.value + '"');
			return '{' + items.join(',') + '}';
		}
		/** 获取全部的上传项. */
		public function get items(): Object {
			var items: Object = {};
			for (var i: int = 0, n: UploadItem; n = _itmes[i]; i ++)
				items[n.pack] = n.value;
			return items;
		}
		
		/** 上传错误的提示框. */
		public function alert(txt: String): void {
			_dialogLab.text = txt;
			_dialogLab.setTextFormat(TextFormats.ALERT_FORMAT);
			_root.alert(_dialogView);
		}
		/** 清空上传的数据列表. */
		public function clear(): void {
			for (var i: int = 0, n: UploadItem; n = _itmes[i]; i ++) {
				n.clear();
			}
		}
	}
}