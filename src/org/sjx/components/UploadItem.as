package org.sjx.components {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.DataEvent;
	import flash.events.Event;
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
		
		[Embed(source="images/uploads.png")]
		public static var BG: Class;
		
		public static const WIDTH: int = 40;
		public static const HEIGHT: int = 40;
		
		// 包名
		public var pack: String;
		// 路径
		public var value: String;
		// 项数据
		public var terminal: Object;
		// 上传来的图片地址
		public var src: String;
		// 提示内容
		private var _tip: String;
		// 背景
		private var _bg: BitmapData;
		// 当前上传的图片
		private var _cur: BitmapData;
		// 遮罩层
		private var _mask: Shape;
		// 点击的图标
		private var _btn: Sprite;
		// 图标文字
		private var _label: TextField;
		
		private var _loadAnimate: Shape;
		
		// 是否上传中
		private var _uploading: Boolean;
		
		private var _fr: FileReference;
		private var _filter: Array;
		private var _request: URLRequest;
		
		private var _list: UploadList;
		private var _previewLoader: Loader
		
		public function UploadItem(p: String, t: Object, list: UploadList) {
			pack = p;
			terminal = t;
			_list = list;
			
			_bg = Bitmap(new BG()).bitmapData;
			_btn = new Sprite();
			_btn.x = SchoolCompete.UPLOAD_ITEM_WIDTH - WIDTH >> 1;
			_btn.y = SchoolCompete.UPLOAD_ITEM_HEIGHT - SchoolCompete.UPLOAD_ITEM_LABEL_HEIGHT - HEIGHT >> 1;
			addChild(_btn);
			
			_label = new TextField();
			_label.x = 0;
			_label.y = _btn.y + HEIGHT; //SchoolCompete.UPLOAD_IEEM_LABEL_MARGIN - SchoolCompete.UPLOAD_ITEM_LABEL_HEIGHT;
			_label.width = SchoolCompete.UPLOAD_ITEM_WIDTH;
			_label.height = SchoolCompete.UPLOAD_ITEM_HEIGHT;
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
			
			var loadAnimateWidth: int = WIDTH >> 1, loadAnimateHeight: int = HEIGHT >> 1;
			_loadAnimate = new Shape();
			_loadAnimate.graphics.beginBitmapFill(_bg, new Matrix(1, 0, 0, 1, -20, -140), false, true);
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
				if(Terminal.size < _fr.size) {
					_list.alert('文件大小超过限制!');
				} else {
					try {
						var request: URLRequest = new URLRequest(Terminal.host + Terminal.upload + '?d=' + new Date().getTime() + 
									'&userId=' + Terminal.uuid + '&item=' + pack + '&w=' + terminal.width + 
									'&h=' + terminal.height + '&f=' + terminal.format);
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
			
			_tip = '<span class="item"><b>' + terminal.name + '</b>\n图片尺寸：' + terminal.width + 'x' + terminal.height + '像素\n图片格式：' + terminal.format + '\n图片大小：' + Terminal.sizeLab + '</span>';
			
			this.addEventListener(MouseEvent.MOUSE_OVER, function (evt: MouseEvent): void {
				if (!value && !_uploading) draw(1);
				_list.doTip(_tip);
			});
			this.addEventListener(MouseEvent.MOUSE_OUT, function (evt: MouseEvent): void {
				if (!value && !_uploading) draw(0);
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
		
		/** 更新预览图. */
		private function update(url: String = null): void {
			_list.update(pack, value = url);
			if (!!url) {
				_previewLoader.load(new URLRequest(url));
			} else {
				_uploading = false;
				draw(0);
			}
		}
		
		private function doPreviewLoaded(evt: Event): void {
			var bmp: Bitmap = Bitmap(_previewLoader.content);
			_cur = bmp.bitmapData;
			draw(3);
			_uploading = false;
		}
		
		/** 上传成功. */
		private function doComplete(event: DataEvent): void {
			var strs: Array = event.data.split('|');
			if (!!strs[2]) {
				update(strs[2] || null);
			} else {
				_uploading = false;
				this._list.alert(strs[3]);
				draw(0);
			}
		}
		
		/** 检测当前是否有上传内容. */
		public function check(): Boolean {
			if (!!this.value) {
				return true;
			} else {
				return false;
			}
		}
		/** 清除内容. */
		public function clear(): void {
			this.value = null;
			draw(0);
		}
		
		/** 界面变更. */
		private function draw(type: int = 0): void {
			var g: Graphics = _btn.graphics;
			g.clear();
			g.beginFill(0xFFFFFF);
			g.drawRect(0, 0, WIDTH, HEIGHT);
			var matr: Matrix = new Matrix(1, 0, 0, 1, 0, 0);
			if (type == 3) {
				matr.createBox(WIDTH / _cur.width, HEIGHT / _cur.height, 0, 0, 0);
				g.beginBitmapFill(_cur, matr, false, true);
				_loadAnimate.visible = false;
				removeEventListener(Event.ENTER_FRAME, doEnterFrame);
			}
			if (type == 0) {
				g.beginBitmapFill(_bg, matr, false, true);
				_loadAnimate.visible = false;
				removeEventListener(Event.ENTER_FRAME, doEnterFrame);
			}
			if (type == 1) {
				matr.createBox(1, 1, 0, 0, -40);
				g.beginBitmapFill(_bg, matr, false, true);
				_loadAnimate.visible = false;
				removeEventListener(Event.ENTER_FRAME, doEnterFrame);
			}
			if (type == 2) {
				matr.createBox(1, 1, 0, 0, -80);
				g.beginBitmapFill(_bg, matr, false, true);
				_loadAnimate.visible = true;
				addEventListener(Event.ENTER_FRAME, doEnterFrame);
			}
			g.drawRect(0, 0, WIDTH, HEIGHT);
			g.endFill();
		}
		
		private function doEnterFrame(evt: Event): void {
			_loadAnimate.rotation += 30
		}
	}
}
