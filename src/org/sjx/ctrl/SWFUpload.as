package {
	import com.qihoo.sjx.upload.comps.Button;
	import com.qihoo.sjx.upload.mode.Parame;
	
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.SecurityErrorEvent;
	import flash.external.ExternalInterface;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.FileReferenceList;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.system.Security;
	
	[SWF(backgroundColor="0xFFFFFF", frameRate="20", width="72", height="23")]
	public class SWFUpload extends MovieClip {
		
		private var _uploading: Boolean = false;
		private var _fr: FileReference;
		private var _frs: FileReferenceList;
		private var _types:Array;
		private var _button: Button;
		
		private var _uploadFileNum: int;
		private var _uploadFileIndex: int;
		private var _uploadFileCurNum: int;
		
		private var _param: Parame;
		private var _request: URLRequest;
		
		public function SWFUpload() {
			Security.allowDomain('*');
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			_param = new Parame(root.loaderInfo.parameters);
			
			if (_param.multiple > 1) {
				_frs = new FileReferenceList();
				_frs.addEventListener(Event.SELECT, doSelect);
			} else {
				_fr = new FileReference();
				_fr.addEventListener(Event.SELECT, doSelect);
			}
			_types = [new FileFilter(_param.descript, _param.filter)];
			
			_button = new Button();
			_button.x = 0;
			_button.y = 0;
			_button.addEventListener(MouseEvent.CLICK, doBrowse);
			this.addChild(_button);
			
			_request = new URLRequest(_param.path);
			var variables:URLVariables = new URLVariables();
			for (var str: String in _param.post)
				variables[str] = _param.post[str];
			_request.data = variables;
			_request.method = URLRequestMethod.POST;
			/*
			var cookieHeader:URLRequestHeader = new URLRequestHeader("Cookie", call('function(){return document.cookie;}'));
			_request.requestHeaders.push(cookieHeader);
			*/
			fire(_param.loaded, _param.parent);
		}

		private function doBrowse(e: Event):void {
			if(_uploading == false) {
				if (_fr) {
					_fr.browse(_types);
				} else {
					_frs.browse(_types);
				}
			} else {
				fire(_param.frequently, '上传中，请稍候.');
			}
		}

		private function doSelect(e: Event):void {
			_uploadFileIndex = 0;
			if (_fr) {
				_uploadFileNum = 1;
				fire(_param.begin, _uploadFileNum + '');
				_doUpload(_fr);
			} else {
				var arr: Array = _frs.fileList, num: int = _param.multiple;
				_uploadFileCurNum = arr.length;
				_uploadFileNum = num > _uploadFileCurNum ? _uploadFileCurNum : num;
				fire(_param.begin, num + '', _uploadFileCurNum);
				for (var i: int = 0, n: int = _uploadFileNum; i < n; i ++) {
					if (!_doUpload(FileReference(arr[i]))) {
						break;
					}
				}
			}
		}
		
		private function _doUpload(fr: FileReference): Boolean {
			if(_param.size < fr.size) {
				// 如果文件格式错误，那么同样上传计数要变更 - sjx: 2012-5-9
				_uploadFileIndex++;
				fire(_param.error, '文件大小超过限制!');
				return false;
			} else {
				fr.addEventListener(Event.COMPLETE , doSuccess);
				fr.addEventListener(IOErrorEvent.IO_ERROR, doIoError);
				fr.addEventListener(SecurityErrorEvent.SECURITY_ERROR, doSecurityError);
				fr.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, doComplete);
				try {
					fr.upload(_request, 'Filedata', false);
					_uploading = true;
				} catch(e: Error) {
					fire(_param.error, '文件上传失败，请重试。');
					_uploading = false;
					return false;
				}
			}
			return true;
		}
		
		private function doSecurityError(evt: SecurityErrorEvent): void {
			_uploading = false;
			fire(_param.error, '文件上传失败，请检查地址是否正确。');
		}
		
		private function doIoError(evt: IOErrorEvent): void {
			_uploading = false;
			fire(_param.error, '文件上传失败，请检查网络并重试。');
		}
		
		private function doSuccess(evt: Event): void {
			_uploading = false;
			fire(_param.success);
		}
		
		private function doComplete(event: DataEvent): void {
			var fr: FileReference = FileReference(event.currentTarget);
			fire(_param.success, event.data, _uploadFileIndex, _uploadFileNum, _param.multiple, _uploadFileCurNum, fr.name);
			_uploadFileIndex++;
		}
		
		/** 调用js函数. */
		public function fire(fun: String, msg: String = null, cur: int = 0, num: int = 0, max: int = 1, curMax: int = 0, fname: String = null): void {
			if (fun)
				ExternalInterface.call(fun, msg, cur, num, max, curMax, fname);
		}
		
		public function call(fun: String): String {
			return ExternalInterface.call(fun);
		}
	}
}