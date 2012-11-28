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
		
		private var _lists: Sprite;
		private var _mask: Shape;
		private var _scroll: ScrollBar;
		
		private var _root: SchoolCompete;
		private var _dialogView: Sprite;
		private var _dialogLab:  TextField;
		private var _uploadTip: UploadTip;
		
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
			
			_scroll = new ScrollBar(12, SchoolCompete.UPLOAD_HEIGHT, 8);
			_scroll.x = SchoolCompete.UPLOAD_WIDTH - 12;
			_scroll.y = 0;
			_scroll.addEventListener(ScrollBar.DRAG_MOVE_EVENT, function (evt: Event): void {
				_lists.y = -_scroll.zoom * _scroll.scrollTop;
			});
			addChild(_scroll);
			
			_mask = new Shape();
			_mask.graphics.beginFill(0xFFFFFF);
			_mask.graphics.drawRect(0, 0, SchoolCompete.UPLOAD_WIDTH, SchoolCompete.UPLOAD_HEIGHT);
			_mask.graphics.endFill();
			addChild(_mask);
			mask = _mask;
			
			var beginX: int = SchoolCompete.UPLOAD_ITEM_PADDING_H * 2.5;
			for (var i: int = 0, n: Object; n = Terminal.items[i]; i ++) {
				var pack: String = n['pack'], item: UploadItem = new UploadItem(pack, n, this);
				item.x = beginX + i % SchoolCompete.UPLOAD_ITEM_SIZE * (SchoolCompete.UPLOAD_ITEM_PADDING_H + SchoolCompete.UPLOAD_ITEM_WIDTH);
				item.y = SchoolCompete.UPLOAD_ITEM_PADDING_V + (i / SchoolCompete.UPLOAD_ITEM_SIZE >> 0) * (SchoolCompete.UPLOAD_ITEM_PADDING_V + SchoolCompete.UPLOAD_ITEM_HEIGHT);
				item.addEventListener(MouseEvent.MOUSE_OVER, doItemOver);
				item.addEventListener(MouseEvent.MOUSE_OUT, doItemOut);
				_lists.addChild(item);
				_itmes.push(item);
				_root.update(pack, null);
			}
			_scrollHeight = Math.ceil(Terminal.items.length / SchoolCompete.UPLOAD_ITEM_SIZE) + SchoolCompete.UPLOAD_ITEM_HEIGHT + SchoolCompete.UPLOAD_ITEM_PADDING_V;
			_scroll.update(SchoolCompete.UPLOAD_HEIGHT, _scrollHeight);
			
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
			_dialogLab.wordWrap = true;
			_dialogView.addChild(_dialogLab);
			
			_uploadTip = new UploadTip();
			_uploadTip.visible = false;
			addChild(_uploadTip);
			
			var btn: Button = new Button('确定');
			btn.x = 164;
			btn.y = 145;
			btn.addEventListener(MouseEvent.CLICK, function (evt: MouseEvent): void {
				_root.close();
			});
			_dialogView.addChild(btn);
		}
		/** 鼠标移入上传项的提示. */
		private function doItemOver(evt: MouseEvent): void {
			var curItem: UploadItem = evt.currentTarget as UploadItem;
			_uploadTip.y = curItem.y + SchoolCompete.UPLOAD_ITEM_HEIGHT;
			_uploadTip.x = curItem.x; // + SchoolCompete.UPLOAD_ITEM_WIDTH * 0.5 >> 0;
			_uploadTip.visible = true;
			_uploadTip.pos();
		}
		/** 鼠标移出上传项的提示. */
		private function doItemOut(evt: MouseEvent): void {
			_uploadTip.visible = false;
		}
		/** 鼠标移入上传项的内容处理. */
		public function doTip(tip: String): void {
			_uploadTip.update(tip);
		}
		
		/** 获取全部的制作数据. */
		public function update(pack: String, val: String): void {
			_root.update(pack, val || null);
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