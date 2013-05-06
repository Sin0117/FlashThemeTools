package org.sjx.components {
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	import org.sjx.data.Terminal;
	import org.sjx.utils.TextFormats;
	
	public class UploadList extends Sprite {
		
		public static const TAB_HEIGHT: int = 32;
		
		private var _root: SchoolCompete;
		private var _uploadLab: TextField;
		private var _dialogView: Sprite;
		private var _dialogLab: TextField;
		private var _uploadTip: UploadTip;
		
		private var _modeMap: Object;
		private var _modeKeyMap: Object;
		private var _iconSpace: Sprite;
		private var _widgetSpace: Sprite;
		private var _widgetList: Object;
		
		private var _optionalSpace: Sprite;
		private var _requiredSpace: Sprite;
		
		private var _clearBtn: ClearButton;
		private var _iconTab: TabButton;
		private var _widgetTab: TabButton;
		private var _weatherSelect: Select;
		
		private var _itmes: Array;
		private var _packs: Object;
		private var _tipTimer: Timer;
		
		public function UploadList(r: SchoolCompete) {
			_root = r;
			
			_itmes = [];
			_packs = {};
			_modeMap = {};
			_modeKeyMap = {};
			_widgetList = {};
			_iconSpace = new Sprite();
			_iconSpace.x = 0;
			_iconSpace.y = TAB_HEIGHT;
			addChild(_iconSpace);
			
			_widgetSpace = new Sprite();
			_widgetSpace.x = 0;
			_widgetSpace.y = TAB_HEIGHT;
			addChild(_widgetSpace);
			_widgetSpace.visible = false;
			
			// 加载widget的定制项
			if (Terminal['widget']) {
				var widgetItems: Object = Terminal.widget, index: int = 0, modeArr: Array = [];
				// 加载时钟天气
				for (var weather: String in widgetItems) {
					var data: Object = widgetItems[weather], name = data['name'] || weather,
						weatherSpace: WeatherSetting = new WeatherSetting(weather, data, this, _root);
					weatherSpace.y = TAB_HEIGHT;
					weatherSpace.visible = !index;
					_widgetSpace.addChild(weatherSpace);
					_widgetList[weather] = weatherSpace;
					modeArr.push(name);
					_modeMap[name] = weather;
					_modeKeyMap[weather] = name;
					index ++;
				}
				
				var listLabel: TextField = new TextField();
				listLabel.x = 0;
				listLabel.y = 2;
				listLabel.autoSize = TextFieldAutoSize.LEFT;
				listLabel.text = '当前模板：';
				listLabel.setTextFormat(TextFormats.makeTextFormat(14, 0x333333));
				_widgetSpace.addChild(listLabel);
				_weatherSelect = new Select(180, 24, modeArr, 0xcccccc, 0xa7cf72, false, modeArr[0]);
				_weatherSelect.x = 72;
				_weatherSelect.y = 0;
				_widgetSpace.addChild(_weatherSelect);
				_weatherSelect.addEventListener(Select.EVENT_CLICK, function (evt: Event): void {
					var key: String = _modeMap[_weatherSelect.value];
					_root.weatherModeChange(key);
				});
			}
			
			var uploadLabY: int = (Terminal.dev ? SchoolCompete.DEV_UPLOAD_HEIGHT : SchoolCompete.UPLOAD_HEIGHT) - TAB_HEIGHT
									+ SchoolCompete.UPLOAD_ITEM_PADDING_V + SchoolCompete.UPLOAD_ITEM_HEIGHT;
			_iconSpace.graphics.beginFill(0xececec, 1);
			_iconSpace.graphics.drawRect(20, uploadLabY, 220, 27);
			_iconSpace.graphics.endFill();
			_uploadLab = new TextField();
			_uploadLab.width = 220;
			_uploadLab.height = 20;
			_uploadLab.x = 28;
			_uploadLab.y = uploadLabY + 3;
			_iconSpace.addChild(_uploadLab);
			
			_clearBtn = new ClearButton('全部清空');
			_clearBtn.x = 240;
			_clearBtn.y = uploadLabY;
			_iconSpace.addChild(_clearBtn);
			_clearBtn.addEventListener(MouseEvent.CLICK, function(evt: MouseEvent): void {
				_root.doClearConfirm();
			});
			
			/* 2013-02-26： 对应widget的定制. */
			_iconTab = new TabButton("主题定制");
			_iconTab.x = 0;
			_iconTab.y = 0;
			addChild(_iconTab);
			_iconTab.addEventListener(MouseEvent.CLICK, function (evt: MouseEvent): void {
				_iconSpace.visible = true;
				_widgetSpace.visible = false;
				_widgetTab.doUp();
			});
			
			_widgetTab = new TabButton("时钟天气");
			_widgetTab.x = 108;
			_widgetTab.y = 0;
			addChild(_widgetTab);
			_widgetTab.addEventListener(MouseEvent.CLICK, function (evt: MouseEvent): void {
				_iconSpace.visible = false;
				_widgetSpace.visible = true;
				_iconTab.doUp();
			});
			_iconTab.doDown();
			
			var beginX: int = 0, beginY: int = 0, rowIndex: int = 0, itemIndex: int = 0,
				itemHeight: int = SchoolCompete.UPLOAD_ITEM_PADDING_V + SchoolCompete.UPLOAD_ITEM_HEIGHT;
			_requiredSpace = new Sprite();
			_drawLine('必选上传项：', _requiredSpace);
			_requiredSpace.y = beginY;
			beginY += 24 + SchoolCompete.UPLOAD_ITEM_PADDING_V;
			_iconSpace.addChild(_requiredSpace);
			for (var i: int = 0, n: Object; n = Terminal.items[i]; i ++) {
				if (n.optional || (n.dev && !Terminal.dev)) continue;
				var pack: String = n['pack'];
				if (pack) {
					var item: UploadItem = new UploadItem(pack, n, this);
					item.x = beginX + itemIndex % SchoolCompete.UPLOAD_ITEM_SIZE * (SchoolCompete.UPLOAD_ITEM_PADDING_H + SchoolCompete.UPLOAD_ITEM_WIDTH);
					item.y = beginY;
					item.addEventListener(MouseEvent.MOUSE_OVER, _doItemOver);
					item.addEventListener(MouseEvent.MOUSE_OUT, doItemOut);
					_iconSpace.addChild(item);
					_itmes.push(item);
					_packs[pack] = item;
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
			_iconSpace.addChild(_optionalSpace);
			beginX = 0, itemIndex = 0, rowIndex = 0;
			for (i = 0, n = null; n = Terminal.items[i]; i ++) {
				if (!n.optional || (n.dev && !Terminal.dev)) continue;
				pack = n['pack'], item = new UploadItem(pack, n, this);
				item.x = beginX + itemIndex % SchoolCompete.UPLOAD_ITEM_SIZE * (SchoolCompete.UPLOAD_ITEM_PADDING_H + SchoolCompete.UPLOAD_ITEM_WIDTH);
				item.y = beginY;
				item.addEventListener(MouseEvent.MOUSE_OVER, _doItemOver);
				item.addEventListener(MouseEvent.MOUSE_OUT, doItemOut);
				_iconSpace.addChild(item);
				_itmes.push(item);
				_packs[pack] = item;
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
			_dialogLab.y = 72;
			_dialogLab.width = 360;
			_dialogLab.height = 60;
			_dialogLab.mouseEnabled = false;
			_dialogLab.wordWrap = true;
			_dialogLab.multiline = true;
			_dialogView.addChild(_dialogLab);
			
			_tipTimer = new Timer(200, 0);
			_tipTimer.addEventListener(TimerEvent.TIMER, function (evt: TimerEvent): void {
				_uploadTip.visible = false;
			});
			
			_uploadTip = new UploadTip();
			_uploadTip.visible = false;
			_uploadTip.addEventListener(MouseEvent.MOUSE_OVER, function (evt: MouseEvent): void {
				_tipTimer.stop();
			});
			_uploadTip.addEventListener(MouseEvent.MOUSE_OUT, function (evt: MouseEvent): void {
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
		private function _doItemOver(evt: MouseEvent): void {
			var curItem: UploadItem = evt.currentTarget as UploadItem;
			doItemOver(curItem);
		}
		/** 鼠标移出上传项的提示. */
		public function doItemOut(evt: MouseEvent = null): void {
			_tipTimer.reset();
			_tipTimer.start();
		}
		/** 鼠标移入上传项的提示. */
		public function doItemOver(item: DisplayObject, offsetX: Number = 0, offsetY: Number = 0): void {
			_uploadTip.y = TabButton.HEIGHT * .5 + item.y + SchoolCompete.UPLOAD_ITEM_HEIGHT + offsetY;
			_uploadTip.x = item.x + offsetX; // + SchoolCompete.UPLOAD_ITEM_WIDTH * 0.5 >> 0;
			_tipTimer.stop();
			_uploadTip.visible = true;
			_uploadTip.pos();
		}
		/** 鼠标移入上传项的内容处理. */
		public function doTip(tip: String): void {
			_uploadTip.update(tip);
		}
		
		/** 获取全部的制作数据. */
		public function update(pack: String, val: String): void {
			_root.update(pack, val || null);
		}
		public function updateWidget(pack: String, val: String): void {
			_root.updateWeather(pack, val || null);
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
		public function addToString(add: Object): String {
			var items: Array = [];
			for (var i: int = 0, n: UploadItem; n = _itmes[i]; i ++)
				items.push('"' + n.pack + '":"' + (n.value || '') + '"');
			for (var k: String in add) {
				if (add[k])
					items.push('"' + k + '":"' + (add[k] || '') + '"');
			}
			return '{' + items.join(',') + '}';
		}
		/** 获取全部的上传项. */
		public function get items(): Object {
			var items: Object = {};
			for (var i: int = 0, n: UploadItem; n = _itmes[i]; i ++)
				items[n.pack] = n.value;
			return items;
		}
		
		/** 更新上传内容. */
		public function setItme(pack: String, val: String): void {
			if (_packs[pack]) {
				UploadItem(_packs[pack]).update(val);
			}
		}
		
		/** widget的模板变更。 */
		public function widgetModeChange(key: String): void {
			for (var mode: String in _widgetList)
				_widgetList[mode].visible = false;
			_widgetList[key].visible = true;
			_weatherSelect.value = _modeKeyMap[key];
		}
		
		/** 更新widget的mode。 */
		public function updateWidgetMode(key: String, setting: Object): void {
			if (!_widgetList[key]) return;
			for (var pack: String in setting) {
				if (pack != 'theme') {
					_widgetList[key].setItme(pack, setting[pack]);
				}
			}
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