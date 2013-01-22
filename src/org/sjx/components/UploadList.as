package org.sjx.components {
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	import org.sjx.data.Terminal;
	import org.sjx.utils.TextFormats;
	
	public class UploadList extends Sprite {
		
		private var _lists: Sprite;
//		private var _mask: Shape;
		// private var _scroll: ScrollBar;
		
		private var _root: SchoolCompete;
		private var _uploadLab: TextField;
		private var _dialogView: Sprite;
		private var _dialogLab: TextField;
		private var _uploadTip: UploadTip;
		
		private var _optionalSpace: Sprite;
		private var _requiredSpace: Sprite;
		
		private var _clearBtn: ClearButton;
		
		private var _itmes: Array;
		// private var _scrollHeight: uint;
		private var _tipTimer: Timer;
		
		public function UploadList(r: SchoolCompete) {
			_root = r;
			
			_itmes = [];
			// _scrollHeight = 0;
			_lists = new Sprite();
			_lists.x = 0;
			_lists.y = 0;
			addChild(_lists);
			
			var uploadLabY: int = (Terminal.dev ? SchoolCompete.DEV_UPLOAD_HEIGHT : SchoolCompete.UPLOAD_HEIGHT);
			graphics.beginFill(0xececec, 1);
			graphics.drawRect(20, uploadLabY, 220, 27);
			graphics.endFill();
			_uploadLab = new TextField();
			_uploadLab.width = 220;
			_uploadLab.height = 20;
			_uploadLab.x = 28;
			_uploadLab.y = uploadLabY + 3;
			addChild(_uploadLab);
			
			_clearBtn = new ClearButton('全部清空');
			_clearBtn.x = 240;
			_clearBtn.y = uploadLabY;
			addChild(_clearBtn);
			_clearBtn.addEventListener(MouseEvent.CLICK, function(evt: MouseEvent): void {
				_root.doClearConfirm();
			});
			
			/*
			_scroll = new ScrollBar(12, SchoolCompete.UPLOAD_HEIGHT, 8);
			_scroll.x = SchoolCompete.UPLOAD_WIDTH - 12;
			_scroll.y = 0;
			_scroll.addEventListener(ScrollBar.DRAG_MOVE_EVENT, function (evt: Event): void {
				_lists.y = -_scroll.zoom * _scroll.scrollTop;
			});
			addChild(_scroll);
			*/
			
			// _mask = new Shape();
			// _mask.graphics.beginFill(0xFFFFFF);
			// _mask.graphics.drawRect(0, 0, SchoolCompete.UPLOAD_WIDTH, SchoolCompete.UPLOAD_HEIGHT);
			// _mask.graphics.endFill();
			// addChild(_mask);
			// mask = _mask;
			
			var beginX: int = 0, beginY: int = 0, rowIndex: int = 0, itemIndex: int = 0,
				itemHeight: int = SchoolCompete.UPLOAD_ITEM_PADDING_V + SchoolCompete.UPLOAD_ITEM_HEIGHT;
			_requiredSpace = new Sprite();
			_drawLine('必选上传项：', _requiredSpace);
			_requiredSpace.y = beginY;
			beginY += 24 + SchoolCompete.UPLOAD_ITEM_PADDING_V;
			_lists.addChild(_requiredSpace);
			for (var i: int = 0, n: Object; n = Terminal.items[i]; i ++) {
				if (n.optional || (n.dev && !Terminal.dev)) continue;
				var pack: String = n['pack'];
				if (pack) {
					var item: UploadItem = new UploadItem(pack, n, this);
					item.x = beginX + itemIndex % SchoolCompete.UPLOAD_ITEM_SIZE * (SchoolCompete.UPLOAD_ITEM_PADDING_H + SchoolCompete.UPLOAD_ITEM_WIDTH);
					item.y = beginY;
					item.addEventListener(MouseEvent.MOUSE_OVER, doItemOver);
					item.addEventListener(MouseEvent.MOUSE_OUT, doItemOut);
					_lists.addChild(item);
					_itmes.push(item);
					_root.update(pack, null);
				}
				itemIndex ++;
				var index: int = itemIndex / SchoolCompete.UPLOAD_ITEM_SIZE >> 0;
				if (rowIndex < index) {
					beginY += itemHeight;
					rowIndex = index;
				}
			}
			beginY += itemHeight;
			
			_optionalSpace = new Sprite();
			_drawLine('可选上传项：', _optionalSpace);
			_optionalSpace.y = beginY;
			beginY += 24 + SchoolCompete.UPLOAD_ITEM_PADDING_V;
			_lists.addChild(_optionalSpace);
			beginX = 0, itemIndex = 0, rowIndex = 0;
			for (i = 0, n = null; n = Terminal.items[i]; i ++) {
				if (!n.optional || (n.dev && !Terminal.dev)) continue;
				pack = n['pack'], item = new UploadItem(pack, n, this);
				item.x = beginX + itemIndex % SchoolCompete.UPLOAD_ITEM_SIZE * (SchoolCompete.UPLOAD_ITEM_PADDING_H + SchoolCompete.UPLOAD_ITEM_WIDTH);
				item.y = beginY;
				item.addEventListener(MouseEvent.MOUSE_OVER, doItemOver);
				item.addEventListener(MouseEvent.MOUSE_OUT, doItemOut);
				_lists.addChild(item);
				_itmes.push(item);
				_root.update(pack, null);
				itemIndex ++;
				index = itemIndex / SchoolCompete.UPLOAD_ITEM_SIZE >> 0;
				if (rowIndex < index) {
					beginY += itemHeight;
					rowIndex = index;
				}
			}
			
			// _scrollHeight = Math.ceil(Terminal.items.length / SchoolCompete.UPLOAD_ITEM_SIZE) + SchoolCompete.UPLOAD_ITEM_HEIGHT + SchoolCompete.UPLOAD_ITEM_PADDING_V;
			// _scroll.update(SchoolCompete.UPLOAD_HEIGHT, _scrollHeight);
			
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
			
			_tipTimer = new Timer(200, 0);
			_tipTimer.addEventListener(TimerEvent.TIMER, function (evt: TimerEvent): void {
				_uploadTip.visible = false;
			});
			
			_uploadTip = new UploadTip();
			_uploadTip.visible = false;
			_uploadTip.addEventListener(MouseEvent.MOUSE_OVER, function (evt: MouseEvent): void {
				_tipTimer.stop();
			});_uploadTip.addEventListener(MouseEvent.MOUSE_OUT, function (evt: MouseEvent): void {
				doItemOut(null);
			});
			addChild(_uploadTip);
			
			var btn: ViewButton = new ViewButton('确定');
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
			_tipTimer.stop();
			_uploadTip.visible = true;
			_uploadTip.pos();
		}
		/** 鼠标移出上传项的提示. */
		private function doItemOut(evt: MouseEvent): void {
			_tipTimer.reset();
			_tipTimer.start();
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
		
		/** 绘制横线. */
		private function _drawLine(txt: String, space: Sprite): void {
			var g: Graphics = space.graphics, lab: TextField = new TextField();
			g.lineStyle(1, 0x666666);
			g.moveTo(0, 22);
			g.lineTo(SchoolCompete.UPLOAD_WIDTH - 8, 22);
			g.endFill();
			lab.text = txt;
			lab.width = SchoolCompete.UPLOAD_WIDTH;
			lab.height = 20;
			lab.x = 4;
			lab.y = 0;
			space.addChild(lab);
		}
		
		/** 获取全部的上传项. */
		override public function toString(): String {
			var items: Array = [];
			for (var i: int = 0, n: UploadItem; n = _itmes[i]; i ++)
				items.push('"' + n.pack + '":"' + (n.value || '') + '"');
			return '{' + items.join(',') + '}';
		}
		/** 获取全部的上传项. */
		public function get items(): Object {
			var items: Object = {};
			for (var i: int = 0, n: UploadItem; n = _itmes[i]; i ++)
				items[n.pack] = n.value;
			return items;
		}
		
		/** 更新上传数量. */
		public function updateUploads(): void {
			var size: int = 0, max: int = 0, cur: int = 0, required: int = 0;
			for (var i: int = 0, n: UploadItem; n = _itmes[i]; i ++) {
				if (n.optional) {
					required ++;
					if (n.value)
						cur ++;
				}
				if (n.value)
					size ++;
				max ++;
			}
			_uploadLab.text = '共' + max + '个元素，已上传' + size + '个';
			_uploadLab.setTextFormat(TextFormats.TEXT_UPLOAD_LABEL);
			
			if (required == cur)
				_root.readyUpload = true;
			else
				_root.readyUpload = false;
		}
		
		/** 上传错误的提示框. */
		public function alert(txt: String): void {
			_dialogLab.text = txt;
			_dialogLab.setTextFormat(TextFormats.ALERT_FORMAT);
			_root.alert(_dialogView);
		}
		/** 清空上传的数据列表. */
		public function clear(): void {
			for (var i: int = 0, n: UploadItem; n = _itmes[i]; i ++)
				n.clear();
			updateUploads();
		}
	}
}