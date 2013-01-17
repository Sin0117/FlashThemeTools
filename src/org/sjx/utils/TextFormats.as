package org.sjx.utils {
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	public class TextFormats {
		// 主题信息标签
		public static const THEME_LABEL_FORMAT: TextFormat = new TextFormat('微软雅黑', 12, 0x333333, true);
		// 主题信息标签
		public static const THEME_INFO_LABEL_FORMAT: TextFormat = new TextFormat('微软雅黑', 12, 0x333333, true, false, false, null, null, TextFormatAlign.RIGHT);
		// 异常的颜色
		public static const THEEM_ERROR_LABEL_FORMAT: TextFormat = new TextFormat('微软雅黑', 12, 0xFF3333, true);
		// 主题制作协议
		public static const AGREEMENT_FORMAT: TextFormat = new TextFormat('微软雅黑', 12, 0x666666, false, false, false, "http://designer.mobile.360.cn/platform/info/agreement", "_blank", TextFormatAlign.LEFT);
		// 主题信息输入
		public static const THEME_INPUT_FORMAT: TextFormat = new TextFormat('微软雅黑', 12, 0x333333, false, false, false, null, null, TextFormatAlign.LEFT, 4, 4);
		public static const THEME_TEXTAREA_FORMAT: TextFormat = new TextFormat('微软雅黑', 12, 0x333333, false, false, false, null, null, TextFormatAlign.LEFT, 16, 16, 16, 16);
		// 操作按钮
		public static const BUTTON_FORMAT: TextFormat = new TextFormat('微软雅黑', 12, 0xFFFFFF, true, false, false, null, null, TextFormatAlign.CENTER);
		// 清除操作按钮
		public static const CLEAR_BUTTON_FORMAT: TextFormat = new TextFormat('微软雅黑', 12, 0xFF3333, false, false, false, null, null, TextFormatAlign.CENTER);
		// 主题信息的规范文字样式.
		public static const THEME_INFO_SPECIFICATION: TextFormat = new TextFormat('微软雅黑', 13, 0xdd605e, false, false, false, null, null, TextFormatAlign.LEFT, null, null, null, 10);
		public static const THEME_INFO_SPECIFICATION_LINK: TextFormat = new TextFormat('微软雅黑', 13, 0x78cb3b, false, false, true, "http://designer.mobile.360.cn/platform/info/tutorial", "_blank", TextFormatAlign.LEFT, null, null, null, 10);
		// 打包异常信息文字
		public static const BUILDER_ERROR_FORMAT: TextFormat = new TextFormat('微软雅黑', 12, 0xFF3333, true, false, false, null, null, TextFormatAlign.LEFT);
		// 提示框文字
		public static const ALERT_FORMAT: TextFormat = new TextFormat('微软雅黑', 12, 0x333333, false, false, false, null, null, TextFormatAlign.CENTER);
		// 异常提示文字
		public static const ALERT_ERROR_FORMAT: TextFormat = new TextFormat('微软雅黑', 12, 0xdd605e, false, false, false, null, null, TextFormatAlign.CENTER);
		// 版权文字
		public static const COPY_LABEL_FORMAT: TextFormat = new TextFormat('微软雅黑', 12, 0x666666, false, false, false, "http://designer.mobile.360.cn/platform/info/tutorial", "_blank", TextFormatAlign.CENTER);
		public static const COPY_LABEL_HOVER_FORMAT: TextFormat = new TextFormat('微软雅黑', 12, 0x777777, false, false, true, "http://designer.mobile.360.cn/platform/info/tutorial", "_blank", TextFormatAlign.CENTER);
		// 上传界面
		public static const UPLOAD_FORMAT: TextFormat = new TextFormat('微软雅黑', 12, 0x333333, false, false, false, null, null, TextFormatAlign.LEFT);
		// 普通文字
		public static const TEXT_FORMAT: TextFormat = new TextFormat('微软雅黑', 12, 0x333333, false, false, false, null, null, TextFormatAlign.LEFT);
		// 上传统计文字
		public static const TEXT_UPLOAD_LABEL: TextFormat = new TextFormat('微软雅黑', 12, 0x8c8c8c, false, false, false, null, null, TextFormatAlign.LEFT);
	}
}