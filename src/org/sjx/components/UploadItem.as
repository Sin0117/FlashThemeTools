package org.sjx.components {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.SecurityErrorEvent;
	import flash.geom.Matrix;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.text.TextField;
	
	import org.sjx.data.Terminal;
	import org.sjx.utils.TextFormats;
	
	public class UploadItem extends Sprite {
		
		[Embed(source="images/btn.png")]
		public static var BG: Class;
		
		public static const WIDTH: int = 50;
		public static const HEIGHT: int = 50;
		
		// 包名
		public var pack: String;
		// 路径
		public var value: String;
		// 必选
		public var optional: Boolean;
		// 项数据
		public var terminal: Object;
		// 上传来的图片地址
		public var src: String;
		// 提示内容
		private var _tip: String;
		// 背景
		private var _bg: BitmapData;
		// 当前上传的图片
		// private var _cur: BitmapData;
		// 遮罩层
		private var _mask: Shape;
		// 点击的图标
		private var _btn: Sprite;
		// 图标文字
		private var _label: TextField;
		
		private var _loadAnimate: Shape;
		private var _clearBg: Sprite;
		private var _clearLab: TextField;
		private var _clearHeight: int;
		private var _clearWidth: int;
		
		// 是否上传中
		private var _uploading: Boolean;
		
		private var _fr: FileReference;
		private var _filter: Array;
		private var _request: URLRequest;
		
		private var _list: UploadList;
		private var _previewLoader: Loader;
		
		// 图标颜色偏移
		private var _leftOffset: int; 
		
		public function UploadItem(p: String, t: Object, list: UploadList) {
			pack = p;
			terminal = t;
			_list = list;
			// if (terminal.type == 'icon')
			optional = !terminal.optional;
			_leftOffset = 0;
			
			_bg = Bitmap(new BG()).bitmapData;
			_btn = new Sprite();
			_btn.x = SchoolCompete.UPLOAD_ITEM_WIDTH - WIDTH >> 1;
			_btn.y = SchoolCompete.UPLOAD_ITEM_HEIGHT - SchoolCompete.UPLOAD_ITEM_LABEL_HEIGHT - HEIGHT >> 1;
			addChild(_btn);
			
			_label = new TextField();
			_label.x = 0;
			_label.y = _btn.y + HEIGHT; //SchoolCompete.UPLOAD_IEEM_LABEL_MARGIN - SchoolCompete.UPLOAD_ITEM_LABEL_HEIGHT;
			_label.width = SchoolCompete.UPLOAD_ITEM_WIDTH;
			_label.height = SchoolCompete.UPLOAD_ITEM_LABEL_HEIGHT;
			_label.text = terminal.name;
			_label.setTextFormat(TextFormats.ALERT_FORMAT);
			_label.mouseEnabled = false;
			addChild(_label);
			
			_mask = new Shape();
			_mask.graphics.beginFill(0xFFFFFF);
			_mask.graphics.drawRoundRect(0, 0, WIDTH, HEIGHT, 4, 4);
			_mask.graphics.endFill();
			_btn.addChild(_mask);
			_btn.mask = _mask;
			
			/*
			graphics.lineStyle(1, 0xFF0000);
			graphics.drawRect(0, 0, SchoolCompete.UPLOAD_ITEM_WIDTH, SchoolCompete.UPLOAD_ITEM_HEIGHT);
			graphics.endFill();
			*/
			
			// 绘制删除操作
			_clearHeight = HEIGHT * .4 >> 0;
			_clearWidth = WIDTH - 1;
			_clearBg = new Sprite();
			drawClearBg(0.4);
			_clearBg.y = HEIGHT - _clearHeight + 1;
			_clearBg.buttonMode = true;
			_btn.addChild(_clearBg);
			_clearBg.addEventListener(MouseEvent.MOUSE_OVER, function (evt: MouseEvent): void {
				drawClearBg(0.9);
				_clearBg.visible = true;
			});
			_clearBg.addEventListener(MouseEvent.MOUSE_OUT, function (evt: MouseEvent): void {
				drawClearBg(0.4);
			});
			_clearBg.addEventListener(MouseEvent.CLICK, function (evt: MouseEvent): void {
				clear();
				evt.stopPropagation();
			});
			_clearLab = new TextField();
			_clearLab.width = WIDTH;
			_clearLab.height = 18;
			_clearLab.mouseEnabled = false;
			_clearLab.x = 0;
			_clearLab.y = 0;
			_clearLab.text = '清除';
			_clearLab.setTextFormat(TextFormats.CLEAR_BUTTON_FORMAT);
			_clearBg.addChild(_clearLab);
			_clearBg.visible = false;
			
			var loadAnimateWidth: int = WIDTH >> 1, loadAnimateHeight: int = HEIGHT >> 1;
			_loadAnimate = new Shape();
			_loadAnimate.graphics.beginBitmapFill(_bg, new Matrix(1, 0, 0, 1, _leftOffset + -25, -175), false, true);
			_loadAnimate.graphics.drawRect(-loadAnimateWidth, -loadAnimateHeight, WIDTH, HEIGHT);
			_loadAnimate.graphics.endFill();
			_loadAnimate.x = _btn.x + loadAnimateWidth;
			_loadAnimate.y = _btn.y + loadAnimateHeight;
			_loadAnimate.visible = false;
			addChild(_loadAnimate);
			
			_filter = [];
			var filters: Array = terminal.format.split(',');
			for (var i: int = 0, n: String; n = filters[i]; i ++) {
				_filter.push(new FileFilter('图片(' + n + ')', '*.' + n));
			}
			_fr = new FileReference();
			_fr.addEventListener(Event.SELECT, function (evt: Event): void {
				if (terminal.format.indexOf(_fr.type.substring(1)) == -1) {
					_list.alert('您需要上传' + terminal.format + '格式的图片（必须是PS软件直接存储为' + terminal.format + '格式的图片）！');
				} else if(terminal.size < _fr.size) {
					_list.alert('您需要上传' + terminal.size_lab + '的图片！');
				} else {
					try {
						var request: URLRequest = new URLRequest(Terminal.host + Terminal.upload + 
									'?d=' + new Date().time + '&userId=' + Terminal.uuid + '&item=' + pack + 
									'&f=' + terminal.format + '&dev=' + Terminal.dev + 
									'&maxw=' + terminal.max_width + '&maxh=' + terminal.max_height +
									'&minw=' + terminal.min_width + '&minh=' + terminal.min_height);
						request.method = URLRequestMethod.POST;
						_fr.upload(request, 'resource', false);
						_uploading = true;
						draw(2);
					} catch(e: Error) {
						_list.alert('文件上传失败，请重试。');
						_uploading = false;
					}
				}
			});
			_fr.addEventListener(Event.COMPLETE , doSuccess);
			_fr.addEventListener(IOErrorEvent.IO_ERROR, doIoError);
			_fr.addEventListener(SecurityErrorEvent.SECURITY_ERROR, doSecurityError);
			_fr.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, doComplete);
			
			_tip = '<span class="item"><b>' + terminal.name + (terminal.optional ? '(可选)' : '(必选)') + '</b>\n' + 
				'最小尺寸：' + terminal.min_width + 'x' + terminal.min_height + 'px\n' + 
				'最大尺寸：' + terminal.max_width + 'x' + terminal.max_height + 'px\n' + 
				'图片格式：' + terminal.format + '\n图片大小：' + terminal.size_lab + 
				(terminal.tip ? '\n' + terminal.tip : '') + '</span>';
			
			this.addEventListener(MouseEvent.MOUSE_OVER, function (evt: MouseEvent): void {
				if (!value && !_uploading) draw(1);
				_list.doTip(_tip);
				if (value)
					_clearBg.visible = true;
			});
			this.addEventListener(MouseEvent.MOUSE_OUT, function (evt: MouseEvent): void {
				if (!value && !_uploading) draw(0);
				if (value)
					_clearBg.visible = false;
			});
			_btn.addEventListener(MouseEvent.CLICK, function (): void {
				if (!_uploading)
					_fr.browse(_filter);
			});

			_previewLoader = new Loader();
			_previewLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, doPreviewLoaded);
			draw(0);
		}
			
		private function doSecurityError(evt: SecurityErrorEvent): void {
			_uploading = false;
			draw(0);
			_list.alert('文件上传失败，请检查地址是否正确。');
		}
		
		private function doIoError(evt: IOErrorEvent): void {
			_uploading = false;
			draw(0);
			_list.alert('文件上传失败，请检查网络并重试。');
		}
		
		private function doSuccess(evt: Event): void {
			draw(0);
		}
		/** 清除按钮的背景绘制. */
		private function drawClearBg(alpha: Number): void {
			var g: Graphics = _clearBg.graphics, r: int = 8;
			g.clear();
			g.beginFill(0xCCCCCC, alpha);
			g.moveTo(0.5, 0);
			g.lineTo(_clearWidth, 0);
			g.lineTo(_clearWidth, _clearHeight - r);
			g.curveTo(_clearWidth, _clearHeight, _clearWidth - r, _clearHeight);
			g.lineTo(r, _clearHeight);
			g.curveTo(0.5, _clearHeight, 0.5, _clearHeight - r);
			g.lineTo(0.5, 0);
			g.endFill();
		}
		/** 更新预览图. */
		private function update(url: String = null): void {
			_list.update(pack, value = url);
			if (url) {
				_uploading = false;
				_leftOffset = -50;
				_loadAnimate.graphics.clear();
				_loadAnimate.graphics.beginBitmapFill(_bg, new Matrix(1, 0, 0, 1, _leftOffset + -25, -175), false, true);
				_loadAnimate.graphics.drawRect(-(WIDTH >> 1), -(HEIGHT >> 1), WIDTH, HEIGHT);
				_loadAnimate.graphics.endFill();
				draw(3);
				_list.updateUploads();
				// _previewLoader.load(new URLRequest(url));
			} else {
				_uploading = false;
				draw(0);
			}
		}
		
		/** 上传成功以后加载新的预览图. */
		private function doPreviewLoaded(evt: Event): void {
			// var bmp: Bitmap = Bitmap(_previewLoader.content);
			// _cur = bmp.bitmapData;
			draw(3);
			_uploading = false;
			_list.updateUploads();
		}
		
		/** 上传成功. */
		private function doComplete(event: DataEvent): void {
			var strs: Array = event.data.split('|');
			if (strs[2]) {
				update(strs[2] || null);
			} else {
				_uploading = false;
				this._list.alert(strs[3]);
				draw(0);
			}
		}
		
		/** 检测当前是否有上传内容. */
		public function check(): Boolean {
			if (this.value) {
				return true;
			} else {
				return false;
			}
		}
		/** 清除内容. */
		public function clear(): void {
			this.value = null;
			_clearBg.visible = false;
			_leftOffset = 0;
			_loadAnimate.graphics.clear();
			_loadAnimate.graphics.beginBitmapFill(_bg, new Matrix(1, 0, 0, 1, _leftOffset + -25, -175), false, true);
			_loadAnimate.graphics.drawRect(-(WIDTH >> 1), -(HEIGHT >> 1), WIDTH, HEIGHT);
			_loadAnimate.graphics.endFill();
			draw(0);
			_list.updateUploads();
		}
		
		/** 界面变更. */
		private function draw(type: int = 0): void {
			var g: Graphics = _btn.graphics;
			g.clear();
			g.beginFill(0xFFFFFF);
			g.drawRect(0, 0, WIDTH, HEIGHT);
			var matr: Matrix = new Matrix(1, 0, 0, 1, _leftOffset, 0);
			if (type == 3) {
				// matr.createBox(WIDTH / _cur.width, HEIGHT / _cur.height, 0, 0, 0);
				// g.beginBitmapFill(_cur, matr, false, true);
				matr.createBox(1, 1, 0, _leftOffset, -200);
				g.beginBitmapFill(_bg, matr, false, true);
				_loadAnimate.visible = false;
				removeEventListener(Event.ENTER_FRAME, doEnterFrame);
			}
			if (type == 0) {
				g.beginBitmapFill(_bg, matr, false, true);
				_loadAnimate.visible = false;
				removeEventListener(Event.ENTER_FRAME, doEnterFrame);
			}
			if (type == 1) {
				matr.createBox(1, 1, 0, _leftOffset, -50);
				g.beginBitmapFill(_bg, matr, false, true);
				_loadAnimate.visible = false;
				removeEventListener(Event.ENTER_FRAME, doEnterFrame);
			}
			if (type == 2) {
				matr.createBox(1, 1, 0, _leftOffset, -100);
				g.beginBitmapFill(_bg, matr, false, true);
				_loadAnimate.visible = true;
				addEventListener(Event.ENTER_FRAME, doEnterFrame);
			}
			g.drawRect(0, 0, WIDTH, HEIGHT);
			g.endFill();
		}
		
		private function doEnterFrame(evt: Event): void {
			_loadAnimate.rotation -= 18;
		}
	}
}
