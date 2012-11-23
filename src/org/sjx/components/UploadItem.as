package org.sjx.components {
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	
	import org.sjx.data.Terminal;
	import org.sjx.utils.TextFormats;
	
	public class UploadItem extends Sprite {
		
		public static const WIDTH: int = 700;
		public static const HEIGHT: int = 50;
		
		private var _name: TextField;
		private var _lab: TextField;
		private var _val: TextField;
		
		// 包名
		public var pack: String;
		// 路径
		public var value: String;
		// 项数据
		public var terminal: Object;
		// 上传来的图片地址
		public var src: String;
		
		// 是否上传中
		private var _uploading: Boolean;
		
		private var _btn: Button;
		private var _fr: FileReference;
		private var _filter: Array;
		private var _request: URLRequest;
		
		private var _list: UploadList;
		private var _htmlFormat: StyleSheet;
		private var _htmlFormatCheck: StyleSheet;
		
		private var _preview: Bitmap;
		private var previewLoader: Loader
		
		public function UploadItem(p: String, t: Object, list: UploadList) {
			pack = p;
			terminal = t;
			_list = list;
			_htmlFormat = new StyleSheet();
			_htmlFormat.setStyle(".item", {
				color: '#333333',
				fontSize: '12px',
				fontStyle: '微软雅黑'
			});
			_htmlFormatCheck = new StyleSheet();
			_htmlFormatCheck.setStyle(".item", {
				color: '#FF3333',
				fontSize: '12px',
				fontStyle: '微软雅黑'
			});
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
						_btn.text = '上传中..'
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
			
			_name = new TextField();
			_name.styleSheet = _htmlFormat;
			_name.htmlText = '<span class="item"><b>' + terminal.name + '</b> （图片尺寸：' + terminal.width + 'x' + terminal.height + '像素、图片格式：' + terminal.format + '、大小：' + Terminal.sizeLab + '）</span>';
			_name.x = 0;
			_name.y = 3;
			_name.width = WIDTH - Button.WIDTH - 26;
			_name.height = 20;
			_name.mouseEnabled = false;
			addChild(_name);
			
			_lab = new TextField();
			_lab.text = '地址：';
			_lab.setTextFormat(TextFormats.UPLOAD_FORMAT);
			_lab.x = 0;
			_lab.y = 27;
			_lab.width = 36;
			_lab.height = 20;
			_lab.mouseEnabled = false;
			addChild(_lab);
			
			_val = new TextField();
			_val.text = '还未上传';
			_val.setTextFormat(TextFormats.UPLOAD_FORMAT);
			_val.x = 36;
			_val.y = 27;
			_val.width = 520;
			_val.height = 20;
			addChild(_val);
			
			_btn = new Button('上传');
			_btn.x = WIDTH - Button.WIDTH - 16;
			_btn.y = 15;
			addChild(_btn);
			_btn.addEventListener(MouseEvent.CLICK, function (evt: MouseEvent): void {
				if(_uploading == false) {
					_fr.browse(_filter);
				} else {
					_list.alert('上传中，请稍候.');
				}
			});
			
			this.graphics.lineStyle(1, 0x7F7F7F, .8);
			this.graphics.moveTo(0, HEIGHT - 0.5);
			this.graphics.lineTo(WIDTH, HEIGHT - 0.5);
			
			previewLoader = new Loader();
			previewLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, doPreviewLoaded);
		}
			
		private function doSecurityError(evt: SecurityErrorEvent): void {
			_uploading = false;
			_btn.text = '上传';
			_list.alert('文件上传失败，请检查地址是否正确。');
		}
		
		private function doIoError(evt: IOErrorEvent): void {
			_uploading = false;
			_btn.text = '上传';
			_list.alert('文件上传失败，请检查网络并重试。');
		}
		
		private function doSuccess(evt: Event): void {
			_uploading = false;
			_btn.text = '上传';
		}
		
		/** 更新预览图. */
		private function update(url: String = null): void {
			if (!!url)
				previewLoader.load(new URLRequest(url));
			else if (!!_preview && _preview.parent)
				removeChild(_preview);
		}
		
		private function doPreviewLoaded(evt: Event): void {
			var bmp: Bitmap = Bitmap(this.previewLoader.content);
			if (!!_preview && _preview.parent) {
				removeChild(_preview);
			}
			_preview = new Bitmap(bmp.bitmapData, "auto", true);
			_preview.width = 40;
			_preview.height = 40;
			_preview.x = 564;
			_preview.y = 4;
			addChild(_preview);
		}
		
		/** 上传成功. */
		private function doComplete(event: DataEvent): void {
			var strs: Array = event.data.split('|');
			if (!!strs[1]) {
				_name.visible = false;
				_val.text = strs[1];
				_val.setTextFormat(TextFormats.UPLOAD_FORMAT);
				value = strs[1];
				_name.htmlText = _name.htmlText;
				_name.styleSheet = _htmlFormat;
				_name.visible = true;
				_btn.text = '重新上传';
			} else {
				_list.alert(strs[2]);
			}
			update(strs[1] || null);
		}
		/** 检测当前是否有上传内容. */
		public function check(): Boolean {
			if (!!value) {
				_name.styleSheet = _htmlFormat;
				return true;
			} else {
				_name.styleSheet = _htmlFormatCheck;
				return false;
			}
		}
		/** 清除内容. */
		public function clear(): void {
			_name.visible = false;
			_val.text = '还未上传';
			_val.setTextFormat(TextFormats.UPLOAD_FORMAT);
			value = null;
			_name.htmlText = _name.htmlText;
			_name.styleSheet = _htmlFormat;
			_name.visible = true;
		}
	}
}
