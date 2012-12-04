package {
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.geom.Rectangle;
	import flash.net.FileReference;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.system.Security;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	import mx.events.Request;
	
	import org.sjx.components.Button;
	import org.sjx.components.Confirm;
	import org.sjx.components.Dialog;
	import org.sjx.components.Preview;
	import org.sjx.components.ThemeInfo;
	import org.sjx.components.UploadList;
	import org.sjx.data.Terminal;
	import org.sjx.utils.TextFormats;
	
	[SWF(frameRate="25", width="800", height="850")]
	public class SchoolCompete extends Sprite {
		
		[Embed(source="images/017.png")]
		public static var BuilderSuccess: Class;
		
		public static const WIDTH: int = 800;
		public static const HEIGHT: int = 834;
		public static const PADDING_V: int = 10;
		public static const PADDING_H: int = 20;
		public static const BORDER: int = 2;
		// 预览区域宽度
		public static const PEWVIEW_WIDTH: int = 400;
		public static const PEWVIEW_HEIGHT: int = 640;
		public static const EDITER_WIDTH: int = 360;
		public static const EDITER_HEIGHT: int = 600;
		// 上传区域宽度
		public static const UPLOAD_WIDTH: int = 350;
		public static const UPLOAD_HEIGHT: int = 600;
		// 上传项的参数
		public static const UPLOAD_ITEM_WIDTH: int = 56;
		public static const UPLOAD_ITEM_HEIGHT: int = 68;
		public static const UPLOAD_ITEM_LABEL_HEIGHT: int = 20;
		public static const UPLOAD_ITEM_PADDING_V: int = 8;
		public static const UPLOAD_ITEM_PADDING_H: int = 8;
		// 提示框的尺寸.
		public static const TIP_WIDTH: int = 200;
		public static const TIP_HEIGHT: int = 120;
		public static const TIP_HEAD_HEIGHT: int = 16;
		public static const TIP_HEAD_WIDTH: int = 24;
		public static const TIP_ROUND: int = 8;
		// 上传显示列数.
		public static const UPLOAD_ITEM_SIZE: int = 5;
		// 主题信息区域的尺寸
		public static const THEME_INFO_WIDTH: int = 760;
		public static const THEME_INFO_HEIGHT: int = 168;
		
		private var _list: UploadList;
		private var _info: ThemeInfo;
		
		private var _previewBtn: Button;
		private var _builderBtn: Button;
		private var _clearBtn: Button;
		private var _alert: Dialog;
		
		// 所有打包数据.
		private var _data: Object;
		// 打包的请求对象.
		private var _builderLoader: URLLoader;
		// 用户数据请求对象.
		private var _userLoader: URLLoader;
		// 打包进度请求对象
		private var _builderStatLoader: URLLoader;
		
		// 加载效果
		private var _loading: Sprite;
		private var _loadEffect: Sprite;
		private var _builderSuccess: Bitmap;
		private var _loadLabel: TextField;
		private var _loadProg: TextField;
		
		private var _downloadCallback: String;
		// 预览
		private var _preview: Preview;
		
		// 打包进度条计时器
		private var _builderTimer: Timer;
		// 打包ID;
		private var _builderId: String;
		// 打包后的包名.
		private var _builderPack: String;
		// 打包完成后的下载按钮.
		private var _builderDownloadBtn: Button;
		// 打包完成后的关闭按钮.
		private var _builderCloseBtn: Button;
		// 清空的提示.
		private var _clearConfirm: Confirm;
		
		public function SchoolCompete() {
			Security.allowDomain('*');
			Security.loadPolicyFile("http://p0.qhimg.com/crossdomain.xml");
			Security.loadPolicyFile("http://p1.qhimg.com/crossdomain.xml");
			Security.loadPolicyFile("http://p2.qhimg.com/crossdomain.xml");
			Security.loadPolicyFile("http://p3.qhimg.com/crossdomain.xml");
			Security.loadPolicyFile("http://p4.qhimg.com/crossdomain.xml");
			Security.loadPolicyFile("http://p5.qhimg.com/crossdomain.xml");
			Security.loadPolicyFile("http://p6.qhimg.com/crossdomain.xml");
			Security.loadPolicyFile("http://p7.qhimg.com/crossdomain.xml");
			Security.loadPolicyFile("http://p8.qhimg.com/crossdomain.xml");
			Security.loadPolicyFile("http://p9.qhimg.com/crossdomain.xml");
			// Security.loadPolicyFile("http://10.16.15.45:8989/crossdomain.xml");
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align  = StageAlign.TOP_LEFT;
			
			if (root.loaderInfo && root.loaderInfo.parameters) {
				if (root.loaderInfo.parameters['path'])
					Terminal.host = root.loaderInfo.parameters['path'];
				if (root.loaderInfo.parameters['categorys'])
					Terminal.categorys = root.loaderInfo.parameters['categorys'];
				if (root.loaderInfo.parameters['prices'])
					Terminal.prices = root.loaderInfo.parameters['prices'];
				if (root.loaderInfo.parameters['download'])
					_downloadCallback = root.loaderInfo.parameters['download'];
			}
			
			// 绘制加载效果
			_loading = new Sprite();
			_loading.graphics.lineStyle(2, 0x777777);
			_loading.graphics.beginFill(0xFAFAFA, 0.8);
			_loading.graphics.drawRoundRect(0, 0, 400, 240, 8);
			_loading.graphics.endFill();
			
			_loadEffect = new Sprite();
			_loadEffect.addChild(makeLoadShape(.1, 0));
			_loadEffect.addChild(makeLoadShape(.2, 12));
			_loadEffect.addChild(makeLoadShape(.3, 24));
			_loadEffect.addChild(makeLoadShape(.4, 36));
			_loadEffect.addChild(makeLoadShape(.5, 48));
			_loadEffect.addChild(makeLoadShape(.6, 60));
			_loadEffect.addChild(makeLoadShape(.7, 72));
			_loadEffect.addChild(makeLoadShape(.8, 84));
			_loadEffect.addChild(makeLoadShape(.9, 96));
			_loadEffect.addChild(makeLoadShape(1, 108));
			_loadEffect.x = 200;
			_loadEffect.y = 96;
			_loading.addChild(_loadEffect);
			
			_builderSuccess = new BuilderSuccess();
			_builderSuccess.x = 150;
			_builderSuccess.y = 52;
			_builderSuccess.visible = false;
			_loading.addChild(_builderSuccess);
			
			_loadProg = new TextField();
			_loadProg.x = 180;
			_loadProg.y = 86;
			_loadProg.width = 40;
			_loadProg.height = 20;
			_loadProg.mouseEnabled = false;
			_loading.addChild(_loadProg);
			
			_loadLabel = new TextField();
			_loadLabel.x = 20;
			_loadLabel.y = 168;
			_loadLabel.width = 360;
			_loadLabel.height = 20;
			_loadLabel.mouseEnabled = false;
			_loading.addChild(_loadLabel);
			
			_builderDownloadBtn = new Button('下载');
			_builderDownloadBtn.x = 400 - 36 - Button.WIDTH * 2 >> 1;
			_builderDownloadBtn.y = 200;
			_loading.addChild(_builderDownloadBtn);
			_builderDownloadBtn.addEventListener(MouseEvent.CLICK, function(evt: MouseEvent): void {
trace (Terminal.host + Terminal.download + _builderId);
				if (_downloadCallback) {
					ExternalInterface.call('doDownload', Terminal.host + Terminal.download + _builderId + '&packname=' + _builderPack);
				} else {
					var fr: FileReference = new FileReference();
					fr.download(new URLRequest(Terminal.host + Terminal.download + _builderId), _info.theme + '.zip');
				}				
			});
			_builderDownloadBtn.visible = false;
			
			_builderCloseBtn = new Button('关闭');
			_builderCloseBtn.x = 400 - _builderDownloadBtn.x - Button.WIDTH;
			_builderCloseBtn.y = 200;
			_loading.addChild(_builderCloseBtn);
			_builderCloseBtn.addEventListener(MouseEvent.CLICK, function(evt: MouseEvent): void {
				hideLoading();
			});
			_builderCloseBtn.visible = false;
			
			_alert = new Dialog(new Rectangle(0, 0, WIDTH, HEIGHT));
			
			// 用户相关请求对象初始化.
			_userLoader = new URLLoader();
			_userLoader.addEventListener(Event.COMPLETE, doUuid);
			/*
			// 用户信息初始化
			addEventListener(Event.ADDED_TO_STAGE, function (): void {
				_userLoader.load(new URLRequest(Terminal.host + Terminal.uuidPath + '?d=' + new Date().getTime()));
				doLoading('初始化中...');
			});
			*/
			
			/** 打包请求. */
			_builderLoader = new URLLoader();
			_builderLoader.addEventListener(Event.COMPLETE, function (evt: Event): void {
				var strs: Array = _builderLoader.data.toString().split('|');
				if (strs.length > 2) {
					_builderId = strs[1];
					_builderPack = strs[2];
					_builderTimer.reset();
					_builderTimer.start();
				} else {
					_list.alert(strs[1]);
				}
			});
			
			_alert = new Dialog(new Rectangle(0, 0, WIDTH, HEIGHT));
			_alert.x = 0;
			_alert.y = 0;
			addChild(_alert);
			_alert.hide();
			
			_preview = new Preview(this);
			_preview.x = PADDING_H;
			_preview.y = PADDING_V * 2 + THEME_INFO_HEIGHT;
			addChild(_preview);
			
			_builderTimer = new Timer(2000, 1);
			_builderTimer.addEventListener(TimerEvent.TIMER, function (evt: TimerEvent): void {
				_builderStatLoader.load(new URLRequest(Terminal.host + Terminal.status + '?tid=' + _builderId + '&d=' + new Date().getTime()));
			});
			
			_builderStatLoader = new URLLoader();
			_builderStatLoader.addEventListener(Event.COMPLETE, function (evt: Event): void {
				var strs: Array = _builderStatLoader.data.toString().split('|');
				switch (strs[1]) {
					case '0': updateLoading(strs[2], 15); break;
					case '1': updateLoading(strs[2], 30); break;
					case '2': updateLoading(strs[2], 45); break;
					case '3': updateLoading(strs[2], 60); break;
					case '4': updateLoading(strs[2], 75); break;
					case '5': updateLoading(strs[2], 90); break;
					case '6': updateLoading(strs[2]); break;
				}
				if (strs[1] == 6) {
					_builderId = strs[0];
					_builderDownloadBtn.visible = true;
					_builderCloseBtn.visible = true;
					_builderSuccess.visible = true;
					_loadEffect.visible = false;
				} else {
					_builderTimer.reset();
					_builderTimer.start();
				}
			});
			
			_clearConfirm = new Confirm('是否确认清空?', function (): void {
				_userLoader.load(new URLRequest(Terminal.host + Terminal.clear + '?d=' + new Date().getTime()));
				_info.clear();
				_list.clear();
				_data = {};
				hideClearConfirm();
			}, function (): void {
				hideClearConfirm();
			}, 300, 180);
			_data = {};
			Init(null);
		}
		
		/** 清空确认的提示. */
		public function doClearConfirm(): void {
			alert(_clearConfirm);
		}
		public function hideClearConfirm(): void {
			close();
		}
		
		/** 显示加载界面. */
		public function doLoading(lab: String, prog: int = -1): void {
			_info.enable = false;
			updateLoading(lab, prog);
			alert(_loading);
			addEventListener(Event.ENTER_FRAME, loadAnimation);
		}
		/** 隐藏加载界面. */
		public function hideLoading(): void {
			_info.enable = true;
			removeEventListener(Event.ENTER_FRAME, loadAnimation);
			_builderCloseBtn.visible = false;
			_builderDownloadBtn.visible = false;
			_builderSuccess.visible = false;
			_loadEffect.visible = true;
			close();
		}
		/** 更新加载界面文字. */
		public function updateLoading(lab: String, prog: int = -1): void {
			_loadLabel.text = lab;
			_loadLabel.setTextFormat(TextFormats.ALERT_FORMAT);
			if (prog >= 0) {
				_loadProg.text = prog + '%';
				_loadProg.setTextFormat(TextFormats.ALERT_FORMAT);
			} else {
				_loadProg.text = '';
			}
		}
		
		/** 绘制一个旋转效果. */
		private function makeLoadShape(a: Number = 1, r: Number = 0): Shape {
			var shape: Shape = new Shape();
			shape.graphics.lineStyle(1, 0x333333, a);
			shape.graphics.beginFill(0x999999, a);
			shape.graphics.drawRect(-40, -2, 20, 4);
			shape.graphics.drawRect(20, -2, 20, 4);
			shape.graphics.endFill();
			shape.rotation = r;
			return shape;
		}
		
		/** 加载到uuid后的处理. */
		private function doUuid(evt: Event): void {
			Terminal.uuid = _userLoader.data;
			hideLoading();
			
			_userLoader.removeEventListener(Event.COMPLETE, doUuid);
			_userLoader.addEventListener(Event.COMPLETE, doClear);
		}
		
		/** 清理用户数据后的回调. */
		private function doClear(evt: Event): void {
			
		}
		
		/** 加载的动画. */
		private function loadAnimation(evt: Event): void {
			_loadEffect.rotation += 15;
		}
		
		private function Init(evt: Event): void {
			_info = new ThemeInfo();
			_info.x = PADDING_H;
			_info.y = PADDING_V;
			addChild(_info);
			
			_list = new UploadList(this);
			_list.x = PADDING_H + PEWVIEW_WIDTH;
			_list.y = PADDING_V * 2 + THEME_INFO_HEIGHT;
			addChild(_list);
			
			var btnY: int = HEIGHT - Button.HEIGHT - 25;
			_builderBtn = new Button('打包');
			_builderBtn.x = _list.x + (UPLOAD_WIDTH - Button.WIDTH * 2 - 32 >> 1);
			_builderBtn.y = btnY;
			addChild(_builderBtn);
			_builderBtn.addEventListener(MouseEvent.CLICK, function(evt: MouseEvent): void {
				doBuilder();
			});
			
			_clearBtn = new Button('清空');
			_clearBtn.x = _list.x + WIDTH - _builderBtn.x - Button.WIDTH;
			_clearBtn.y = btnY;
			addChild(_clearBtn);
			_clearBtn.addEventListener(MouseEvent.CLICK, function(evt: MouseEvent): void {
				doClearConfirm();
			});
			
			draw();
		}
		
		/** 打包操作. */
		public function doBuilder(): void {
			if (_info.checkThemeName()) {
				if (_info.checkAuthor()) {
					if (_list.check()) {
						doLoading('打包中，请稍候...', 0);
						var request: URLRequest = new URLRequest(Terminal.host + Terminal.builder);
						var variables:URLVariables = new URLVariables();
						variables['uuid'] = Terminal.uuid;
						variables['name'] = _info.author;
						variables['theme'] = _info.theme;
						request.method = URLRequestMethod.GET;
						request.data = variables;
						_builderLoader.load(request);
					} else {
						_list.alert('还有未上传的图标');
					}
				} else {
					_list.alert('英雄! 请留下你的名字!');
				}
			} else {
				_list.alert('亲~ 主题名称要填哦!');
			}
		}
		
		private function draw(): void {
			var g: Graphics = this.graphics;
			g.beginFill(0xffffff, 1);
			g.drawRect(0, 0, WIDTH, HEIGHT);
			g.lineStyle(1, 0xf0f0f0, 1);
			g.beginFill(0xfafafa, 1);
			g.drawRoundRect(PADDING_H, PADDING_V + THEME_INFO_HEIGHT, 
				WIDTH - PADDING_H * 2, HEIGHT - PADDING_V * 2 - THEME_INFO_HEIGHT, BORDER * 4);
			g.moveTo(BORDER << 2, THEME_INFO_HEIGHT);
			g.lineStyle(BORDER, 0xe6e6e6, 1);
			g.lineTo(WIDTH - BORDER * 5, THEME_INFO_HEIGHT);
			g.endFill();
		}
		
		/** 显示提示框. */
		public function alert(view: DisplayObject): void {
			_alert.update(view);
		}
		/** 关闭提示框. */
		public function close(): void {
			_alert.hide();
		}
		/** 获取数据. */
		public function data(pack: String): String {
			return _data[pack];
		}
		/** 更新数据. */
		public function update(pack: String, url: String): void {
			_data[pack] = url;
			_preview.updateAt(pack, url);
		}
		/** 设置是否显示预览. */
		public function set preview(show: Boolean): void {
			_preview.parent.setChildIndex(_preview, _preview.parent.numChildren - 1);
			_preview.visible = show;
		}
	}
}
