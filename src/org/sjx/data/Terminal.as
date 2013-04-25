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
				"icon_folder":{"z":4,"rollable":true,"background":"", "uploaded": "http://p9.qhimg.com/t010a1455d0b7dce814.png", "parent":"icon","width":86,"height":86,"v_width":72,"v_height":72,"label":"图标文件夹"},
				"widget_quickaccess":{"z":4,"rollable":true,"background":"","parent":"icon","width":86,"height":86,"v_width":72,"v_height":72,"label":"快速打开"},
				"widget_screenlock_widget":{"z":4,"rollable":true,"background":"","parent":"icon","width":86,"height":86,"v_width":72,"v_height":72,"label":"一键锁屏"},
				"widget_feedback":{"z":4,"rollable":true,"background":"","parent":"icon","width":86,"height":86,"v_width":72,"v_height":72,"label":"意见反馈"},
				"widget_quicksettings":{"z":4,"rollable":true,"background":"","parent":"icon","width":86,"height":86,"v_width":72,"v_height":72,"label":"快速设置"},
				"icon":{"z":4,"rollable":true,"background":"","parent":"icon","width":86,"height":86,"v_width":72,"v_height":72,"label":"Logo"},
				// "icon_home":{'y':704,'z':4,'index':2,'dockbar':true,'parent':'icon','width':76,'height':76,'label':'桌面'},
				"workspace_bg":{"x":-240,"y":0,"z":0,"parent":"background","width":960,"height":800,"mask":"0x000000","maskAlpha":0.6},
				"workspace_dockbar_bg":{"x":0,"y":695,"z":1,"parent":"dockbar","width":480,"height":105},
				"icon_3":{"z":4,"rollable":true,"background":"icon_bg", "foreground": "icon_fg", "icon_mask": "icon_mask", "parent":"icon","width":86,"height":86,"v_width":72,"v_height":72,"label":"第三方图标"},
				
				"icon_bg":{"z":3,"y":-800,"rollable":true,"background":"","parent":"icon","width":86,"height":86,"v_width":72,"v_height":72,"label":"背板"},
				"icon_fg":{"z":3,"y":-800,"rollable":true,"background":"","parent":"icon","width":86,"height":86,"v_width":72,"v_height":72,"label":"前板"},
				"icon_mask":{"z":3,"y":-800,"rollable":true,"background":"","parent":"icon","width":86,"height":86,"v_width":72,"v_height":72,"label":"蒙版"},
				// "icon_shadow":{"z":3,"y":-800,"rollable":true,"background":"","parent":"icon","width":86,"height":86,"v_width":72,"v_height":72,"label":"阴影"},
				"workspace_indicator":{"arr":[{"x":160,"y":668,"z":2},{"x":192,"y":668,"z":2},{"x":256,"y":668,"z":2},{"x":288,"y":668,"z":2}],"parent":"navigation","width":52,"height":38},
				"workspace_indicator_current":{"x":224,"y":668,"z":2,"parent":"navigation","width":52,"height":38}
			}
		};
		
		public static var widget: Object = { "clockweather_default" : 
			{ "name" : "默认天气时钟", "parent" : "main", "root" : "img_clockweather_bg", 
				"labels" : [ 
					{ "color" : "0xFFFFFFFF", "size" : 28, "x" : 54, "y" : 33, "txt" : "AM", "group" : "其他", "zoom" : 0.5, 
						"shadow_color" : "0xFF000000", "shadow_radius" : 3, "shadow_dx" : 0, "shadow_dy" : 2, "name" : "午", "pack" : "txt_pm" }, 
					{ "size_limit": 99, "shadow_radius_limit": 22, "shadow_dx_limit": 22, "shadow_dy_limit": 22, 
						"color" : "0xFFFFFFFF", "size" : 123, "x" : 43, "y" : 56, "txt" : "10:56", "group" : "时间", "zoom" : 0.5, 
						"shadow_color" : "0xFF000000", "shadow_radius" : 5, "shadow_dx" : 3, "shadow_dy" : 4, "name" : "时间", "pack" : "txt_clock" }, 
					{ "color" : "0xFFFFFFFF", "size" : 30, "x" : 53, "y" : 143, "txt" : "9/16", "group" : "其他", "zoom" : 0.5, 
						"shadow_color" : "0xFF000000", "shadow_radius" : 3, "shadow_dx" : 0, "shadow_dy" : 2, "name" : "日期", "pack" : "txt_date" }, 
					{ "color" : "0xFFFFFFFF", "size" : 30, "x" : 100, "y" : 143, "txt" : "周日", "group" : "其他", "zoom" : 0.5, 
						"shadow_color" : "0xFF000000", "shadow_radius" : 3, "shadow_dx" : 0, "shadow_dy" : 2, "name" : "星期", "pack" : "txt_week" }, 
					{ "color" : "0xFFFFFFFF", "size" : 30, "x" : 53, "y" : 168, "txt" : "八月初一", "group" : "其他", "zoom" : 0.5, 
						"shadow_color" : "0xFF000000", "shadow_radius" : 3, "shadow_dx" : 0, "shadow_dy" : 2, "name" : "农历", "pack" : "txt_lunar" }, 
					{ "color" : "0xFFFFFFFF", "size" : 30, "x" : 319, "y" : 110, "txt" : "晴", "group" : "其他", "zoom" : 0.5, 
						"shadow_color" : "0xFF000000", "shadow_radius" : 3, "shadow_dx" : 0, "shadow_dy" : 2, "name" : "天气", "pack" : "txt_weather_description" }, 
					{ "color" : "0xFFFFFFFF", "size" : 30, "x" : 319, "y" : 144, "txt" : "16°~28", "group" : "其他", "zoom" : 0.5, 
						"shadow_color" : "0xFF000000", "shadow_radius" : 3, "shadow_dx" : 0, "shadow_dy" : 2, "name" : "温度", "pack" : "txt_temperature" }, 
					{ "color" : "0xFFFFFFFF", "size" : 30, "x" : 319, "y" : 174, "txt" : "北京", "group" : "其他", "zoom" : 0.5, 
						"shadow_color" : "0xFF000000", "shadow_radius" : 3, "shadow_dx" : 0, "shadow_dy" : 2, "name" : "城市", "pack" : "txt_city" } 
				], 
				"images" : [ 
					{ "x" : 0, "y" : 0, "width" : 712, "height" : 353, "name" : "背景", "pack" : "img_clockweather_bg", 
						"size_lab" : "2M以内", "size" : 2097152, "zoom" : 0.67, "format" : "png" }, 
					{ "x" : 314, "y" : 174, "width" : 178, "height" : 40, "name" : "城市背景", "pack" : "img_clockweather_city_bg", 
						"size_lab" : "2M以内", "size" : 2097152, "zoom" : 0.7, "format" : "png" }, 
					{ "x" : 420, "y" : 177, "width" : 13, "height" : 21, "name" : "城市箭头", "pack" : "img_clockweather_changecity_arrow", 
						"size_lab" : "2M以内", "size" : 2097152, "format" : "png" }, 
					{ "width" : 240, "height" : 173, "name" : "实景预览图", "pack" : "preview", 
						"size_lab" : "2M以内", "size" : 2097152, "hidden" : true, "format" : "jpg" }, 
					{ "x" : 294, "y" : 0, "width" : 276, "height" : 215, "name" : "未联网", "pack" : "img_clockweather_w_nodata_3_0", 
						"size_lab" : "2M以内", "size" : 2097152, "list" : "weather", "zoom" : 0.7, "format" : "png" }, 
					{ "x" : 294, "y" : 0, "width" : 276, "height" : 215, "name" : "晴天", "pack" : "img_clockweather_w1", 
						"size_lab" : "2M以内", "size" : 2097152, "list" : "weather", "zoom" : 0.7, "format" : "png" }, 
					{ "x" : 294, "y" : 0, "width" : 276, "height" : 215, "name" : "晴天(夜)", "pack" : "img_clockweather_w1_night", 
						"size_lab" : "2M以内", "size" : 2097152, "list" : "weather", "zoom" : 0.7, "format" : "png" }, 
					{ "x" : 294, "y" : 0, "width" : 276, "height" : 215, "name" : "多云", "pack" : "img_clockweather_w2", 
						"size_lab" : "2M以内", "size" : 2097152, "list" : "weather", "zoom" : 0.7, "format" : "png" }, 
					{ "x" : 294, "y" : 0, "width" : 276, "height" : 215, "name" : "多云(夜)", "pack" : "img_clockweather_w2_night", 
						"size_lab" : "2M以内", "size" : 2097152, "list" : "weather", "zoom" : 0.7, "format" : "png" }, 
					{ "x" : 294, "y" : 0, "width" : 276, "height" : 215, "name" : "阴天", "pack" : "img_clockweather_w3", 
						"size_lab" : "2M以内", "size" : 2097152, "list" : "weather", "zoom" : 0.7, "format" : "png" }, 
					{ "x" : 294, "y" : 0, "width" : 276, "height" : 215, "name" : "雨", "pack" : "img_clockweather_w5", 
						"size_lab" : "2M以内", "size" : 2097152, "list" : "weather", "zoom" : 0.7, "format" : "png" }, 
					{ "x" : 294, "y" : 0, "width" : 276, "height" : 215, "name" : "雪", "pack" : "img_clockweather_w12", 
						"size_lab" : "2M以内", "size" : 2097152, "list" : "weather", "zoom" : 0.7, "format" : "png" }, 
					{ "x" : 294, "y" : 0, "width" : 276, "height" : 215, "name" : "雾", "pack" : "img_clockweather_w16", 
						"size_lab" : "2M以内", "size" : 2097152, "list" : "weather", "zoom" : 0.7, "format" : "png" }, 
					{ "x" : 294, "y" : 0, "width" : 276, "height" : 215, "name" : "沙尘", "pack" : "img_clockweather_w17", 
						"size_lab" : "2M以内", "size" : 2097152, "list" : "weather", "zoom" : 0.7, "format" : "png" } 
				]
			}
		};
		
		public static var widgetInit: Object = {"theme":"clockweather_default","img_clockweather_w16":{"url":"http://img1.mobile.360.cn/XT_Test0_NoAuth/baibian/themes/images/origin/img_clockweather_w16_resources_177521649_1365581309740.png"},"img_clockweather_bg":{"url":"http://img1.mobile.360.cn/XT_Test0_NoAuth/baibian/themes/images/origin/img_clockweather_bg_resources_177521649_1365581285541.png"},"img_clockweather_w3":{"url":"http://img1.mobile.360.cn/XT_Test0_NoAuth/baibian/themes/images/origin/img_clockweather_w3_resources_177521649_1365581304160.png"},"img_clockweather_w2_night":{"url":"http://img1.mobile.360.cn/XT_Test0_NoAuth/baibian/themes/images/origin/img_clockweather_w2_night_resources_177521649_1365581302291.png"},"img_clockweather_w1":{"url":"http://img1.mobile.360.cn/XT_Test0_NoAuth/baibian/themes/images/origin/img_clockweather_w1_resources_177521649_1365581293954.png"},"img_clockweather_w_nodata_3_0":{"url":"http://img1.mobile.360.cn/XT_Test0_NoAuth/baibian/themes/images/origin/img_clockweather_w_nodata_3_0_resources_177521649_1365581292174.png"},"preview":{"url":"http://img1.mobile.360.cn/XT_Test0_NoAuth/baibian/themes/images/origin/preview_resources_177521649_1365581290409.jpg"},"img_clockweather_w17":{"url":"http://img1.mobile.360.cn/XT_Test0_NoAuth/baibian/themes/images/origin/img_clockweather_w17_resources_177521649_1365581311809.png"},"img_clockweather_w2":{"url":"http://img1.mobile.360.cn/XT_Test0_NoAuth/baibian/themes/images/origin/img_clockweather_w2_resources_177521649_1365581297356.png"},"img_clockweather_w5":{"url":"http://img1.mobile.360.cn/XT_Test0_NoAuth/baibian/themes/images/origin/img_clockweather_w5_resources_177521649_1365581306155.png"},"img_clockweather_w1_night":{"url":"http://img1.mobile.360.cn/XT_Test0_NoAuth/baibian/themes/images/origin/img_clockweather_w1_night_resources_177521649_1365581295525.png"},"img_clockweather_city_bg":{"url":"http://img1.mobile.360.cn/XT_Test0_NoAuth/baibian/themes/images/origin/img_clockweather_city_bg_resources_177521649_1365581287219.png"},"img_clockweather_w12":{"url":"http://img1.mobile.360.cn/XT_Test0_NoAuth/baibian/themes/images/origin/img_clockweather_w12_resources_177521649_1365581308073.png"},"img_clockweather_changecity_arrow":{"url":"http://img1.mobile.360.cn/XT_Test0_NoAuth/baibian/themes/images/origin/img_clockweather_changecity_arrow_resources_177521649_1365581288763.png"},"txt_lunar":{"size":"35","color":"#ffff0000","shadow_color":"#fffffafa","shadow_radius":"4"},"txt_pm":{"size":"35","color":"#ffff0000","shadow_color":"#fffffafa","shadow_radius":"4"},"txt_weather_description":{"size":"35","color":"#ffff0000","shadow_color":"#fffffafa","shadow_radius":"4"},"txt_clock":{"size":"120","color":"#fff000ff","shadow_color":"#fffff000","shadow_radius":"4"},"txt_city":{"size":"35","color":"#ffff0000","shadow_color":"#fffffafa","shadow_radius":"4"},"txt_temperature":{"size":"35","color":"#ffff0000","shadow_color":"#fffffafa","shadow_radius":"4"},"txt_date":{"size":"35","color":"#ffff0000","shadow_color":"#fffffafa","shadow_radius":"4"},"txt_week":{"size":"35","color":"#ffff0000","shadow_color":"#fffffafa","shadow_radius":"4"}};
		
		public static const data: Object = {
			/*
			"workspace_indicator_current": "http://p4.qhimg.com/t01437b052a2329508f.png",
			"workspace_indicator": "http://p6.qhimg.com/t01b4f8547453047d4b.png",
			*/
			
			"icon_3": "http://p5.qhimg.com/t0149ff60fdafa8a625.png",
			"status_bar":"http://p2.qhimg.com/t01e34730d2f2f6a5be.png",
			"weather_widget":"http://p9.qhimg.com/t0133504cd478199f10.png"
			
		}
		// 所有编辑项
		public static const items: Object = [
			{pack: 'app_com_android_contacts2', name: '电话', type: 'icon', size: 2097152, size_lab: '2M以内', max_width: 120, max_height: 120, min_width: 120, min_height: 120, format: 'png'},
			{pack: 'app_com_android_mms', name: '短信', type: 'icon', size: 2097152, size_lab: '2M以内', max_width: 120, max_height: 120, min_width: 120, min_height: 120, format: 'png'},
			{pack: 'app_com_android_contacts', name: '联系人', type: 'icon', size: 2097152, size_lab: '2M以内', max_width: 120, max_height: 120, min_width: 120, min_height: 120, format: 'png'},
			{pack: 'app_com_android_browser', name: '浏览器', type: 'icon', size: 2097152, size_lab: '2M以内', max_width: 120, max_height: 120, min_width: 120, min_height: 120, format: 'png'},
			{pack: 'app_com_android_camera', name: '相机', type: 'icon', size: 2097152, size_lab: '2M以内', max_width: 120, max_height: 120, min_width: 120, min_height: 120, format: 'png'},
			{pack: 'app_com_android_vending', name: '应用市场', type: 'icon', size: 2097152, size_lab: '2M以内', max_width: 120, max_height: 120, min_width: 120, min_height: 120, format: 'png'},
			{pack: 'app_com_cooliris_media', name: '图库', type: 'icon', size: 2097152, size_lab: '2M以内', max_width: 120, max_height: 120, min_width: 120, min_height: 120, format: 'png'},
			{pack: 'app_com_android_music', name: '音乐', type: 'icon', size: 2097152, size_lab: '2M以内', max_width: 120, max_height: 120, min_width: 120, min_height: 120, format: 'png'},
			{pack: 'app_com_android_deskclock', name: '时钟', type: 'icon', size: 2097152, size_lab: '2M以内', max_width: 120, max_height: 120, min_width: 120, min_height: 120, format: 'png'},
			{pack: 'app_com_android_calendar', name: '日历', type: 'icon', size: 2097152, size_lab: '2M以内', max_width: 120, max_height: 120, min_width: 120, min_height: 120, format: 'png'},
			{pack: 'app_com_android_calculator2', name: '计算器', type: 'icon', size: 2097152, size_lab: '2M以内', max_width: 120, max_height: 120, min_width: 120, min_height: 120, format: 'png'},
			{pack: 'app_com_google_android_apps_maps', name: '地图', type: 'icon', size: 2097152, size_lab: '2M以内', max_width: 120, max_height: 120, min_width: 120, min_height: 120, format: 'png'},
			{pack: 'app_com_android_settings', name: '系统设置', type: 'icon', size: 2097152, size_lab: '2M以内', max_width: 120, max_height: 120, min_width: 120, min_height: 120, format: 'png'},
			{pack: 'app_com_android_email', name: '电子邮件', type: 'icon', size: 2097152, size_lab: '2M以内', max_width: 120, max_height: 120, min_width: 120, min_height: 120, format: 'png'},
			{pack: 'app_net_qihoo_launcher_theme', name: '主题市场', type: 'icon', size: 2097152, size_lab: '2M以内', max_width: 120, max_height: 120, min_width: 120, min_height: 120, format: 'png'},
			{pack: 'icon_folder', name: '图标文件夹', tip: '<font color="#F00000">图片比实际效果略有出入</font>', type: 'icon', size: 2097152, size_lab: '2M以内', max_width: 120, max_height: 120, min_width: 120, min_height: 120, format: 'png'},
			// {pack: 'icon_home', name: '进入主屏', type: 'icon', max_width: 120, max_height: 120, min_width: 120, min_height: 120, format: 'png'},
			{pack: 'widget_quickaccess', name: '快速打开', type: 'other', size: 2097152, size_lab: '2M以内', max_width: 120, max_height: 120, min_width: 120, min_height: 120, format: 'png'},
			{},
			
			{pack: 'icon_drawer', name: '进入抽屉', type: 'icon', size: 2097152, size_lab: '2M以内', max_width: 120, max_height: 120, min_width: 120, min_height: 120, format: 'png'},
			{pack: 'workspace_indicator', name: '标记点(未选状态)', tip: '<font color="#F00000">预览有拉伸，非最终效果</font>', type: 'other', size: 2097152, size_lab: '2M以内', max_width: 52, max_height: 38, min_width: 1, min_height: 38, format: 'png'},
			{pack: 'workspace_indicator_current', name: '标记点(选中状态)', tip: '<font color="#F00000">预览有拉伸，非最终效果</font>', type: 'other', size: 2097152, size_lab: '2M以内', max_width: 52, max_height: 38, min_width: 1, min_height: 38, format: 'png'},
			{pack: 'workspace_dockbar_bg', name: '托盘', type: 'other', size: 2097152, size_lab: '2M以内', max_width: 720, max_height: 221, min_width: 720, min_height: 220, format: 'png'},
			{pack: 'icon', name: 'Logo', type: 'other', size: 204800, size_lab: '200K以内', max_width: 120, max_height: 120, min_width: 120, min_height: 120, format: 'png'},
			{},
			
			{pack: 'workspace_bg', name: '壁纸', type: 'other', size: 2097152, size_lab: '2M以内', max_width: 1440, max_height: 1280, min_width: 1440, min_height: 1280, format: 'jpg'},
			{pack: 'cover', name: '主题宣传图1', type: 'other', size: 204800, size_lab: '200K以内',max_width: 350, max_height: 370, min_width: 350, min_height: 370, format: 'jpg'},
			{pack: 'cover2', name: '主题宣传图2', tip: '<font color="#F00000">主题宣传图2是用于在站酷网做宣传。</font>', type: 'other', size: 204800, size_lab: '200K以内',max_width: 250, max_height: 188, min_width: 250, min_height: 188, format: 'jpg'},
			{pack: 'preview1', name: '预览图1', type: 'other', size: 204800, size_lab: '200K以内',max_width: 720, max_height: 1280, min_width: 480, min_height: 800, format: 'jpg'},
			{pack: 'tpreview1', name: '预览图2(有抽屉)', type: 'other', size: 204800, size_lab: '200K以内',max_width: 720, max_height: 1280, min_width: 480, min_height: 800, format: 'jpg'},
			{pack: 'spreview1', name: '预览图3(无抽屉)', type: 'other', size: 204800, size_lab: '200K以内',max_width: 720, max_height: 1280, min_width: 480, min_height: 800, format: 'jpg'},
			
			{pack: 'icon_fg', name: '图标前板', type: 'other', size: 2097152, size_lab: '2M以内', optional: true, max_width: 120, max_height: 120, min_width: 120, min_height: 120, format: 'png'},
			{pack: 'icon_mask', name: '图标蒙版', type: 'other', size: 2097152, size_lab: '2M以内', optional: true, max_width: 120, max_height: 120, min_width: 120, min_height: 120, format: 'png'},
			{pack: 'icon_bg', name: '图标背板', type: 'other', size: 2097152, size_lab: '2M以内', optional: true, max_width: 120, max_height: 120, min_width: 120, min_height: 120, format: 'png'},
			// {pack: 'icon_shadow', name: '图标阴影', type: 'other', optional: true, max_width: 151, max_height: 148, min_width: 120, min_height: 120, format: 'png'},
			{pack: 'widget_screenlock_widget', name: '一键锁屏', type: 'other', size: 2097152, size_lab: '2M以内', optional: true, max_width: 120, max_height: 120, min_width: 120, min_height: 120, format: 'png'},
			{pack: 'widget_feedback', name: '意见反馈', type: 'other', size: 2097152, size_lab: '2M以内', optional: true, max_width: 120, max_height: 120, min_width: 120, min_height: 120, format: 'png'},
			// dev模式：{pack: 'widget_quicksettings', name: '快速设置', type: 'other', size: 2097152, size_lab: '2M以内', optional: true, dev: true, max_width: 120, max_height: 120, min_width: 120, min_height: 120, format: 'png'}
			{pack: 'widget_quicksettings', name: '快速设置', type: 'other', size: 2097152, size_lab: '2M以内', optional: true, max_width: 120, max_height: 120, min_width: 120, min_height: 120, format: 'png'}
		];
		
		// 分类
		public static var categorys: String = '卡通动漫,帅哥美女,风景独特,未来元素,美丽风景,动物宠物,酷炫动漫,时尚生活,电玩游戏,金属机械';
		// 代理设置，如果没有就直接抓取图片，如果有会回去返回路径.
		public static var proxy: String = null;
		// 价格
		public static var prices: String = '0.0,0.01,0.99,1.99'; 
		// 打包进度地址
		public static var status: String = 'platform/md/enquirePack'
		// 打包地址.
		public static var builder: String = 'platform/md/builder';
		// 上传地址
		// public static const upload: String = 'compete/upload';
		public static var upload: String = 'platform/md/upload';
		// 获取用户uuid
		public static var uuidPath: String = 'platform/md/uuid';
		// 清除当前用户上传的数据
		public static var clear: String = 'platform/md/clear';
		// 打包后的下载地址.
		public static var download: String = 'platform/md/downloadPack?tid=';
		// apk上传路径
		public static var apkPath: String = '';
		// 初始化数据抓取函数，因为数据长度超过255个字符，所以采用flash装载后抓取.
		public static var initDataCallback: String = '';
		// 初始化widget的数据抓取.
		public static var initWidgetCallback: String = '';
		// 未登录的跳转处理.
		public static var loginCallback: String = '';
		// 打包进度获取异常的处理
		public static var builderErrorCallback: String = '';
		// 上传的唯一标识
		public static var uuid: String = '';
		// 是否是开发模式，不对图片数量进行校验.
		public static var dev: Boolean = false;
		// 是否显示包名.
		public static var isPkg: Boolean = false;
		// 查询打包状态用的
		public static var source: String = '';
		public static var pid: String = '';
		// 设计师信息是否完善
		public static var userInfo: int = 0;
		// 完善个人信息回调
		public static var userInfoCk: String = "";
		// 我的收益回调
		public static var profitsCk: String = "";
		// 我的作品回调
		public static var worksCk: String = "";
		// 制作完成的回调
		public static var finishCk: String = '';
		// 时钟天气widget的初始化加载参数
		public static var initWidgetCk: String = '';
		// 作者名称
		public static var userName: String = '';
		// 主题描述
		public static var themeDesc: String = '';
		// 主题名称
		public static var themeName: String = '';
		// 是否允许编辑主题信息
		public static var isInfoEdit: Boolean = true;
		// 主题的包名
		public static var pkg: String = '';
		// 主题分类
		public static var category: String = null;
		// 主题价格
		public static var price: String = null;
		// 主题版本
		public static var versionCode: String = null;
		// 打包成功后的页面回调
		public static var finish: String;
		// 主机地址.
		public static var host: String = 'http://designer.sjx.mobile.360.cn:9000/';
		// public static var host: String = 'http://themeshop.mobile.jx.360.cn/';
		// public static var host: String = '/';
		// public static var host: String = 'http://zt.mobile.360.cn/';
	}
}