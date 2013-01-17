package org.sjx.data {
	public class Terminal {
		// 界面原数据
		public static const terminal: Object = {
			"main":{
				"status_bar":{"z":9,"x":0,"y":0,"widget":true,"parent":"icon","width":480,"height":36},
				"app_com_android_email":{"z":6,"x":0,"y":480,"background":"","parent":"icon","width":86,"height":86,"v_width":72,"v_height":72,"label":"邮件"},
				"app_com_android_deskclock":{"z":6,"x":120,"y":480,"background":"","parent":"icon","width":86,"height":86,"v_width":72,"v_height":72,"label":"时钟"},
				"app_com_android_camera":{"z":6,"x":240,"y":480,"background":"","parent":"icon","width":86,"height":86,"v_width":72,"v_height":72,"label":"相机"},
				"app_com_cooliris_media":{"z":6,"x":360,"y":480,"background":"","parent":"icon","width":86,"height":86,"v_width":72,"v_height":72,"label":"图库"},
				"app_com_android_contacts2":{"index":0,"z":4,"y":704,"dockbar":true,"parent":"icon","width":76,"height":76,"label":"电话"},
				"app_com_android_mms":{"index":3,"z":4,"y":704,"dockbar":true,"parent":"icon","width":76,"height":76,"label":"短信"},
				"icon_drawer":{"index":2,"y":704,"z":4,"dockbar":true,"parent":"icon","width":76,"height":76,"label":"抽屉"},
				"app_com_android_contacts":{"index":1,"y":704,"z":4,"dockbar":true,"parent":"icon","width":76,"height":76,"label":"联系人"},
				"app_com_android_browser":{"index":4,"y":704,"z":4,"dockbar":true,"parent":"icon","width":76,"height":76,"label":"浏览器"},
				"workspace_bg":{"x":-240,"y":0,"z":0,"parent":"background","width":960,"height":800},
				"workspace_dockbar_bg":{"x":0,"y":695,"z":1,"parent":"dockbar","width":480,"height":105},
				// "icon_bg":{"z":3,"y":-800,"parent":"dockbar","width":86,"height":86},
				"mask":{"z":3,"y":-800,"parent":"dockbar","width":86,"height":86},
				"shadow":{"z":3,"y":-800,"parent":"dockbar","width":86,"height":86},
				"workspace_indicator":{"arr":[{"x":160,"y":668,"z":2},{"x":192,"y":668,"z":2},{"x":256,"y":668,"z":2},{"x":288,"y":668,"z":2}],"parent":"navigation","width":35,"height":25},
				"workspace_indicator_current":{"x":224,"y":668,"z":2,"parent":"navigation","width":35,"height":25}
			}, "drawer":{
				"status_bar":{"z":9,"x":0,"y":0,"widget":true,"parent":"icon","width":480,"height":36},
				"app_com_android_vending":{"z":4,"rollable":true,"background":"","parent":"icon","width":86,"height":86,"v_width":72,"v_height":72,"label":"应用市场"},
				"app_net_qihoo_launcher_theme":{"z":4,"rollable":true,"background":"","parent":"icon","width":86,"height":86,"v_width":72,"v_height":72,"label":"主题市场"},
				"app_com_android_settings":{"z":4,"rollable":true,"background":"","parent":"icon","width":86,"height":86,"v_width":72,"v_height":72,"label":"设置"},
				"app_com_android_calendar":{"z":4,"rollable":true,"background":"","parent":"icon","width":86,"height":86,"v_width":72,"v_height":72,"label":"日历"},
				"app_com_android_calculator2":{"z":4,"rollable":true,"background":"","parent":"icon","width":86,"height":86,"v_width":72,"v_height":72,"label":"计算器"},
				"app_com_android_music":{"z":4,"rollable":true,"background":"","parent":"icon","width":86,"height":86,"v_width":72,"v_height":72,"label":"音乐"},
				"app_com_google_android_apps_maps":{"z":4,"rollable":true,"background":"","parent":"icon","width":86,"height":86,"v_width":72,"v_height":72,"label":"地图"},
				"icon_folder":{"z":4,"rollable":true,"background":"","parent":"icon","width":86,"height":86,"v_width":72,"v_height":72,"label":"文件夹"},
				"icon":{"z":4,"rollable":true,"background":"","parent":"icon","width":86,"height":86,"v_width":72,"v_height":72,"label":"Logo"},
				// "icon_home":{'y':704,'z':4,'index':2,'dockbar':true,'parent':'icon','width':76,'height':76,'label':'桌面'},
				"workspace_bg":{"x":-240,"y":0,"z":0,"parent":"background","width":960,"height":800,"mask":"0x000000","maskAlpha":0.6},
				"workspace_dockbar_bg":{"x":0,"y":695,"z":1,"parent":"dockbar","width":480,"height":105},
				"icon_bg":{"z":4,"rollable":true,"background":"","parent":"icon","width":86,"height":86,"v_width":72,"v_height":72,"label":"背板"},
				"icon_mask":{"z":4,"rollable":true,"background":"","parent":"icon","width":86,"height":86,"v_width":72,"v_height":72,"label":"蒙板"},
				// "icon_shadow":{"z":4,"rollable":true,"background":"","parent":"icon","width":86,"height":86,"v_width":72,"v_height":72,"label":"阴影"},
				"mask":{"z":3,"y":-800,"parent":"dockbar","width":86,"height":86},
				"shadow":{"z":3,"y":-800,"parent":"dockbar","width":86,"height":86},
				"workspace_indicator":{"arr":[{"x":160,"y":668,"z":2},{"x":192,"y":668,"z":2},{"x":256,"y":668,"z":2},{"x":288,"y":668,"z":2}],"parent":"navigation","width":20,"height":20},
				"workspace_indicator_current":{"x":224,"y":668,"z":2,"parent":"navigation","width":20,"height":20}
			}
		};
		
		public static const data: Object = {
			"status_bar":"http://p2.qhimg.com/t01e34730d2f2f6a5be.png",
			"weather_widget":"http:\/\/p9.qhimg.com\/t0133504cd478199f10.png"
		}
		// 所有编辑项
		public static const items: Object = [
			{pack: 'workspace_bg', name: '壁纸', type: 'other', size: 2097152, size_lab: '2M以内', max_width: 1440, max_height: 1280, min_width: 1440, min_height: 1280, format: 'jpg'},
			{pack: 'workspace_dockbar_bg', name: '托盘', type: 'other', size: 2097152, size_lab: '2M以内', max_width: 720, max_height: 221, min_width: 720, min_height: 220, format: 'png'},
			{pack: 'workspace_indicator', name: '标记点(未选状态)', tip: '<font color="#F00000">预览有拉伸，非最终效果</font>', type: 'other', size: 2097152, size_lab: '2M以内', max_width: 52, max_height: 38, min_width: 1, min_height: 38, format: 'png'},
			{pack: 'workspace_indicator_current', name: '标记点(选中状态)', tip: '<font color="#F00000">预览有拉伸，非最终效果</font>', type: 'other', size: 2097152, size_lab: '2M以内', max_width: 52, max_height: 38, min_width: 1, min_height: 38, format: 'png'},
			
			{pack: 'icon', name: 'Logo', type: 'other', size: 204800, size_lab: '200K以内',max_width: 120, max_height: 120, min_width: 120, min_height: 120, format: 'png'},
			{pack: 'cover', name: '主题宣传图', type: 'other', size: 204800, size_lab: '200K以内',max_width: 350, max_height: 370, min_width: 350, min_height: 370, format: 'jpg'},
			{pack: 'preview1', name: '预览图1', type: 'other', size: 204800, size_lab: '200K以内',max_width: 720, max_height: 1280, min_width: 480, min_height: 800, format: 'jpg'},
			{pack: 'tpreview1', name: '预览图2(有抽屉)', type: 'other', size: 204800, size_lab: '200K以内',max_width: 720, max_height: 1280, min_width: 480, min_height: 800, format: 'jpg'},
			{pack: 'spreview1', name: '预览图3(无抽屉)', type: 'other', size: 204800, size_lab: '200K以内',max_width: 720, max_height: 1280, min_width: 480, min_height: 800, format: 'jpg'},
			
			{pack: 'app_com_android_contacts2', name: '电话', type: 'icon', size: 2097152, size_lab: '2M以内', max_width: 120, max_height: 120, min_width: 120, min_height: 120, format: 'png'},
			{pack: 'app_com_android_mms', name: '短信', type: 'icon', size: 2097152, size_lab: '2M以内', max_width: 120, max_height: 120, min_width: 120, min_height: 120, format: 'png'},
			{pack: 'app_com_android_browser', name: '浏览器', type: 'icon', size: 2097152, size_lab: '2M以内', max_width: 120, max_height: 120, min_width: 120, min_height: 120, format: 'png'},
			{pack: 'app_com_android_contacts', name: '联系人', type: 'icon', size: 2097152, size_lab: '2M以内', max_width: 120, max_height: 120, min_width: 120, min_height: 120, format: 'png'},
			{pack: 'app_com_android_email', name: '电子邮件', type: 'icon', size: 2097152, size_lab: '2M以内', max_width: 120, max_height: 120, min_width: 120, min_height: 120, format: 'png'},
			{pack: 'app_com_android_deskclock', name: '时钟', type: 'icon', size: 2097152, size_lab: '2M以内', max_width: 120, max_height: 120, min_width: 120, min_height: 120, format: 'png'},
			{pack: 'app_com_android_vending', name: '应用市场', type: 'icon', size: 2097152, size_lab: '2M以内', max_width: 120, max_height: 120, min_width: 120, min_height: 120, format: 'png'},
			{pack: 'app_net_qihoo_launcher_theme', name: '主题市场', type: 'icon', size: 2097152, size_lab: '2M以内', max_width: 120, max_height: 120, min_width: 120, min_height: 120, format: 'png'},
			{pack: 'app_com_android_camera', name: '相机', type: 'icon', size: 2097152, size_lab: '2M以内', max_width: 120, max_height: 120, min_width: 120, min_height: 120, format: 'png'},
			{pack: 'app_com_android_calculator2', name: '计算器', type: 'icon', size: 2097152, size_lab: '2M以内', max_width: 120, max_height: 120, min_width: 120, min_height: 120, format: 'png'},
			{pack: 'app_com_cooliris_media', name: '图库', type: 'icon', size: 2097152, size_lab: '2M以内', max_width: 120, max_height: 120, min_width: 120, min_height: 120, format: 'png'},
			{pack: 'app_com_google_android_apps_maps', name: '地图', type: 'icon', size: 2097152, size_lab: '2M以内', max_width: 120, max_height: 120, min_width: 120, min_height: 120, format: 'png'},
			{pack: 'app_com_android_music', name: '音乐', type: 'icon', size: 2097152, size_lab: '2M以内', max_width: 120, max_height: 120, min_width: 120, min_height: 120, format: 'png'},
			{pack: 'app_com_android_settings', name: '系统设置', type: 'icon', size: 2097152, size_lab: '2M以内', max_width: 120, max_height: 120, min_width: 120, min_height: 120, format: 'png'},
			{pack: 'app_com_android_calendar', name: '日历', type: 'icon', size: 2097152, size_lab: '2M以内', max_width: 120, max_height: 120, min_width: 120, min_height: 120, format: 'png'},
			{pack: 'icon_folder', name: '文件夹', type: 'icon', size: 2097152, size_lab: '2M以内', max_width: 120, max_height: 120, min_width: 120, min_height: 120, format: 'png'},
			{pack: 'icon_drawer', name: '进入抽屉', type: 'icon', size: 2097152, size_lab: '2M以内', max_width: 120, max_height: 120, min_width: 120, min_height: 120, format: 'png'},
			// {pack: 'icon_home', name: '进入主屏', type: 'icon', max_width: 120, max_height: 120, min_width: 120, min_height: 120, format: 'png'},
			
			{pack: 'icon_fg', name: '图标前板', type: 'other', size: 2097152, size_lab: '2M以内', optional: true, max_width: 120, max_height: 120, min_width: 120, min_height: 120, format: 'png'},
			{pack: 'icon_bg', name: '图标背板', type: 'other', size: 2097152, size_lab: '2M以内', optional: true, max_width: 120, max_height: 120, min_width: 120, min_height: 120, format: 'png'},
			// {pack: 'icon_shadow', name: '图标阴影', type: 'other', optional: true, max_width: 151, max_height: 148, min_width: 120, min_height: 120, format: 'png'},
			{pack: 'icon_mask', name: '图标蒙板', type: 'other', size: 2097152, size_lab: '2M以内', optional: true, max_width: 120, max_height: 120, min_width: 120, min_height: 120, format: 'png'},
			
			{pack: 'widget_screenlock_widget', name: '一键锁屏', type: 'other', size: 2097152, size_lab: '2M以内', optional: true, dev: true, max_width: 1920, max_height: 1920, min_width: 1, min_height: 1, format: 'png'},
			{pack: 'widget_feedback', name: '意见反馈', type: 'other', size: 2097152, size_lab: '2M以内', optional: true, dev: true, max_width: 1920, max_height: 1920, min_width: 1, min_height: 1, format: 'png'},
			{pack: 'widget_quickaccess', name: '快速打开', type: 'other', size: 2097152, size_lab: '2M以内', optional: true, dev: true, max_width: 1920, max_height: 1920, min_width: 1, min_height: 1, format: 'png'},
			{pack: 'widget_quicksettings', name: '快速设置', type: 'other', size: 2097152, size_lab: '2M以内', optional: true, dev: true, max_width: 1920, max_height: 1920, min_width: 1, min_height: 1, format: 'png'}
		];
		
		// 分类
		public static var categorys: String = '卡通动漫,帅哥美女,风景独特,未来元素,美丽风景,动物宠物,酷炫动漫,时尚生活,电玩游戏,金属机械';
		// 代理设置，如果没有就直接抓取图片，如果有会回去返回路径.
		public static var proxy: String = null;
		// 价格
		public static var prices: String = '0.0,0.01,0.99,1.99'; 
		// 打包进度地址
		public static const status: String = 'platform/md/enquirePack'
		// 打包地址.
		public static const builder: String = 'platform/md/builder';
		// 上传地址
		// public static const upload: String = 'compete/upload';
		public static const upload: String = 'platform/md/upload';
		// 获取用户uuid
		public static const uuidPath: String = 'platform/md/uuid';
		// 清除当前用户上传的数据
		public static const clear: String = 'platform/md/clear';
		// 打包后的下载地址.
		public static const download: String = 'platform/md/downloadPack?tid=';
		// 未登录的跳转处理.
		public static var loginCallback: String = 'alert';
		// 上传的唯一标识
		public static var uuid: String = '';
		// 是否是开发模式，不对图片数量进行校验.
		public static var dev: Boolean = false;
		// 是否显示包名.
		public static var pkg: Boolean = false;
		// 查询打包状态用的
		public static var source: String = '';
		public static var pid: String = '';
		// 设计师信息是否完善
		public static var userInfo: int = 0;
		// 完善个人信息回调
		public static var userInfoCk: String = "alert";
		// 我的收益回调
		public static var profitsCk: String = "alert";
		// 我的作品回调
		public static var worksCk: String = "alert";
		// 作者名称
		public static var userName: String = '';
		// 打包成功后的页面回调
		public static var finish: String;
		// 主机地址.
		// public static var host: String = 'http://sjx.shop.360.cn:9000/';
		// public static var host: String = 'http://themeshop.mobile.jx.360.cn/';
		public static var host: String = '/';
		// public static var host: String = 'http://zt.mobile.360.cn/';
	}
}