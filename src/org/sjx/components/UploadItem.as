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
	
	import org.sjx.data.Terminal;
	
	public class UploadItem extends Sprite {
		
		[Embed(source="images/uploads.png")]
		public static var BG: Class;
		
		public static const WIDTH: int = 40;
		public static const HEIGHT: int = 40;
		public static const LABEL_HEIGHT: int = 24;
		// 边距离
		public static const PADDING_V: int = 16;
		public static const PADDING_H: int = 16;
		
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
			_mask = new Shape();
			_mask.graphics.beginFill(0xFFFFFF);
			_mask.graphics.drawRoundRect(0, 0, WIDTH, HEIGHT, 4, 4);
			_mask.graphics.endFill();
			addChild(_mask);
			this.mask = _mask;
			
			_loadAnimate = new Shape();
			_loadAnimate.graphics.beginBitmapFill(_bg, new Matrix(1, 0, 0, 1, 0, -120), false, true);
			_loadAnimate.graphics.drawRect(0, 0, WIDTH, HEIGHT);
			_loadAnimate.graphics.endFill();
			_loadAnimate.visible = false;
			
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
									'&uuid=' + Terminal.uuid + '&pack=' + pack + '&w=' + terminal.width + 
									'&h=' + terminal.height + '&f=' + terminal.format);
						request.method = URLRequestMethod.POST;
						_fr.upload(request, 'Filedata', false);
						_uploading = true;
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
				if (!value) draw(1);
				_list.doTip(_tip);
			});
			this.addEventListener(MouseEvent.MOUSE_OUT, function (evt: MouseEvent): void {
				if (!value) draw(0);
			});
			this.addEventListener(MouseEvent.CLICK, function (): void {
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
			_uploading = false;
			draw(0);
		}
		
		/** 更新预览图. */
		private function update(url: String = null): void {
			if (!!url)
				_previewLoader.load(new URLRequest(url));
			else
				draw(0);
		}
		
		private function doPreviewLoaded(evt: Event): void {
			var bmp: Bitmap = Bitmap(_previewLoader.content);
			_cur = bmp.bitmapData;
			draw(4);
		}
		
		/** 上传成功. */
		private function doComplete(event: DataEvent): void {
			var strs: Array = event.data.split('|');
			if (!!strs[1]) {
				value = strs[1];
				update(strs[1] || null);
			} else {
				this._list.alert(strs[2]);
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
			var g: Graphics = this.graphics;
			g.clear();
			g.beginFill(0xFFFFFF);
			g.drawRect(0, 0, WIDTH, HEIGHT);
			var matr: Matrix = new Matrix(1, 0, 0, 1, 0, 0);
			this.buttonMode = true;
			if (type == 4) {
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
				this.buttonMode = true;
				matr.createBox(1, 1, 0, 0, 80);
				g.beginBitmapFill(_bg, matr, false, true);
				_loadAnimate.visible = true;
				addEventListener(Event.ENTER_FRAME, doEnterFrame);
			}
			g.drawRect(0, 0, WIDTH, HEIGHT);
			g.endFill();
		}
		
		private function doEnterFrame(evt: Event): void {
			_loadAnimate.rotation += 2
		}
	}
}
