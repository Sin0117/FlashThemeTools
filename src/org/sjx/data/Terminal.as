package org.sjx.data {
	public class Terminal {
		// 界面原数据
		public static const terminal: Object = {
			"main":{
				"status_bar":{"z":9,"x":0,"y":0,"widget":true,"parent":"icon","width":480,"height":36},
				// "weather_widget":{"z":2,"x":1,"y":120,"widget":true,"parent":"icon","width":479,"height":238},
				"widget_quicksettings":{"z":6,"x":0,"y":480,"widget":true,"parent":"icon","width":86,"height":86,"label":"快速设置"},
				"app_net_qihoo_launcher_theme":{"z":6,"x":120,"y":480,"parent":"icon","width":86,"height":86,"v_width":72,"v_height":72,"label":"\u6211\u7684\u4e3b\u9898"},
				"app_com_android_camera":{"z":6,"x":240,"y":480,"parent":"icon","width":86,"height":86,"label":"\u76f8\u673a"},
				"app_com_cooliris_media":{"z":6,"x":360,"y":480,"parent":"icon","width":86,"height":86,"label":"\u56fe\u5e93"},
				"app_com_android_contacts2":{"index":0,"z":4,"y":704,"dockbar":true,"parent":"icon","width":76,"height":76,"label":"\u7535\u8bdd"},
				"app_com_android_mms":{"index":3,"z":4,"y":704,"dockbar":true,"parent":"icon","width":76,"height":76,"label":"\u77ed\u4fe1"},
				"icon_drawer":{"index":2,"y":704,"z":4,"dockbar":true,"parent":"icon","width":76,"height":76,"label":"\u8fdb\u5165\u62bd\u5c49"},
				"app_com_android_contacts":{"index":1,"y":704,"z":4,"dockbar":true,"parent":"icon","width":76,"height":76,"label":"\u8054\u7cfb\u4eba"},
				"app_com_android_browser":{"index":4,"y":704,"z":4,"dockbar":true,"parent":"icon","width":76,"height":76,"label":"\u6d4f\u89c8\u5668"},
				"workspace_bg":{"x":-240,"y":0,"z":0,"parent":"background","width":960,"height":800},
				"workspace_dockbar_bg":{"x":0,"y":695,"z":1,"parent":"dockbar","width":480,"height":105},
				"icon_bg":{"z":3,"y":-800,"parent":"dockbar","width":86,"height":86},
				"workspace_indicator":{"arr":[{"x":160,"y":668,"z":2},{"x":192,"y":668,"z":2},{"x":256,"y":668,"z":2},{"x":288,"y":668,"z":2}],"parent":"navigation","width":20,"height":20},
				"workspace_indicator_current":{"x":224,"y":668,"z":2,"parent":"navigation","width":20,"height":20}
			}, "drawer":{
				"status_bar":{"z":9,"x":0,"y":0,"widget":true,"parent":"icon","width":480,"height":36},
				// "drawer_folder":{"z":2,"x":1,"y":36,"widget":true,"parent":"icon","width":480,"height":68},
				"app_com_android_settings":{"z":4,"rollable":true,"background":"icon_bg","foreground":"","parent":"icon","width":86,"height":86,"v_width":72,"v_height":72,"label":"设置"},
				"app_com_android_calendar":{"z":4,"rollable":true,"background":"icon_bg","foreground":"","parent":"icon","width":86,"height":86,"v_width":72,"v_height":72,"label":"日历"},
				"app_com_android_deskclock":{"z":4,"rollable":true,"background":"icon_bg","foreground":"","parent":"icon","width":86,"height":86,"v_width":72,"v_height":72,"label":"时钟"},
				"app_com_android_calculator2":{"z":4,"rollable":true,"background":"icon_bg","foreground":"","parent":"icon","width":86,"height":86,"v_width":72,"v_height":72,"label":"计算器"},
				"app_com_android_music":{"z":4,"rollable":true,"background":"icon_bg","foreground":"","parent":"icon","width":86,"height":86,"v_width":72,"v_height":72,"label":"音乐"},
				"app_com_google_android_apps_maps":{"z":4,"rollable":true,"background":"icon_bg","foreground":"","parent":"icon","width":86,"height":86,"v_width":72,"v_height":72,"label":"地图"},
				"icon_folder":{"z":4,"rollable":true,"background":"icon_bg","foreground":"","parent":"icon","width":86,"height":86,"v_width":72,"v_height":72,"label":"文件夹"},
				"app_com_android_email":{"z":4,"rollable":true,"background":"icon_bg","foreground":"","parent":"icon","width":86,"height":86,"v_width":72,"v_height":72,"label":"电子邮件"},
				"icon":{"z":4,"rollable":true,"background":"icon_bg","foreground":"","parent":"icon","width":86,"height":86,"v_width":72,"v_height":72,"label":"主题图标"},
				"widget_recentlyinstalled":{"z":4,"rollable":true,"background":"icon_bg","foreground":"","parent":"icon","width":86,"height":86,"v_width":72,"v_height":72,"label":"最近安装"},
				"workspace_bg":{"x":-240,"y":0,"z":0,"parent":"background","width":960,"height":800,"mask":"0x000000","maskAlpha":0.6},
				"workspace_dockbar_bg":{"x":0,"y":695,"z":1,"parent":"dockbar","width":480,"height":105},
				"icon_bg":{"z":3,"y":-800,"parent":"dockbar","width":86,"height":86},
				"workspace_indicator":{"arr":[{"x":160,"y":668,"z":2},{"x":192,"y":668,"z":2},{"x":256,"y":668,"z":2},{"x":288,"y":668,"z":2}],"parent":"navigation","width":20,"height":20},
				"workspace_indicator_current":{"x":224,"y":668,"z":2,"parent":"navigation","width":20,"height":20}
			}
		};
		
		public static const data: Object = {
			"status_bar":"http://p2.qhimg.com/t01e34730d2f2f6a5be.png",
			"weather_widget":"http:\/\/p9.qhimg.com\/t0133504cd478199f10.png",
			"drawer_folder":"http://p7.qhimg.com/t01022552ead1294c26.png"
		}
		// 所有编辑项
		public static const items: Object = [
			{pack: 'workspace_bg', name: '壁纸', width: 960, height: 800, format: 'jpg,jpeg'},
			{pack: 'workspace_dockbar_bg', name: '托盘', width: 480, height: 105, format: 'png'},
			{pack: 'workspace_indicator', name: '标记点(未选状态)', width: 21, height: 21, format: 'png'},
			{pack: 'workspace_indicator_current', name: '标记点(选中状态)', width: 21, height: 21, format: 'png'},
			{pack: 'icon_bg', name: '图标背板', width: 90, height: 90, format: 'png'},
			{pack: 'app_com_android_contacts2', name: '电话图标', width: 90, height: 90, format: 'png'},
			{pack: 'app_com_android_mms', name: '短信图标', width: 90, height: 90, format: 'png'},
			{pack: 'app_com_android_browser', name: '浏览器图标', width: 90, height: 90, format: 'png'},
			{pack: 'app_com_android_contacts', name: '联系人图标', width: 90, height: 90, format: 'png'},
			{pack: 'app_com_android_email', name: '电子邮件图标', width: 90, height: 90, format: 'png'},
			{pack: 'app_com_android_deskclock', name: '时钟图标', width: 90, height: 90, format: 'png'},
			{pack: 'app_com_android_calculator2', name: '计算器图标', width: 90, height: 90, format: 'png'},
			{pack: 'app_com_android_camera', name: '相机图标', width: 90, height: 90, format: 'png'},
			{pack: 'app_com_cooliris_media', name: '图库图标', width: 90, height: 90, format: 'png'},
			{pack: 'app_com_google_android_apps_maps', name: '地图图标', width: 90, height: 90, format: 'png'},
			{pack: 'app_com_android_music', name: '音乐图标', width: 90, height: 90, format: 'png'},
			{pack: 'app_com_android_settings', name: '设置图标', width: 90, height: 90, format: 'png'},
			{pack: 'app_com_android_calendar', name: '日历图标', width: 90, height: 90, format: 'png'},
			{pack: 'icon_folder', name: '文件夹图标', width: 90, height: 90, format: 'png'},
			{pack: 'icon', name: '主题图标', width: 90, height: 90, format: 'png'},
			{pack: 'app_net_qihoo_launcher_theme', name: '我的主题图标', width: 90, height: 90, format: 'png'},
			{pack: 'widget_quicksettings', name: '快速设置图标', width: 90, height: 90, format: 'png'},
			{pack: 'widget_recentlyinstalled', name: '最近安装图标', width: 90, height: 90, format: 'png'},
			{pack: 'icon_drawer', name: '进入抽屉图标', width: 90, height: 90, format: 'png'}
		];
		// 打包进度地址
		public static const status: String = 'zcool/enquirePack'
		// 打包地址.
		public static const builder: String = 'zcool/builder';
		// 上传地址
		// public static const upload: String = 'compete/upload';
		public static const upload: String = 'zcool/upload';
		// 获取用户uuid
		public static const uuidPath: String = 'zcool/uuid';
		// 清除当前用户上传的数据
		public static const clear: String = 'zcool/clear';
		// 打包后的下载地址.
		public static const download: String = 'zcool/downloadPack?tid=';
		// 上传文件大小.
		public static const size: uint = 2 * 1024 * 1024;
		// 上传文件的大小显示。
		public static const sizeLab: String = '2M以内';
		// 上传的唯一标识
		public static var uuid: String = '';
		// 主机地址.
		public static var host: String = 'http://sjx.shop.360.cn:9000/';
		// public static var host: String = 'http://themeshop.mobile.jx.360.cn/';
		// public static var host: String = '/';
		// public static var host: String = 'http://zt.mobile.360.cn/';
	}
}