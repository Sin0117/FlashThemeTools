package org.sjx.utils {
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	public class TextFormats {
		// 主题信息标签
		public static const THEME_LABEL_FORMAT: TextFormat = new TextFormat('微软雅黑', 12, 0x333333, true);
		// 异常的颜色
		public static const THEEM_ERROR_LABEL_FORMAT: TextFormat = new TextFormat('微软雅黑', 12, 0xFF3333, true);
		// 主题信息输入
		public static const THEME_INPUT_FORMAT: TextFormat = new TextFormat('微软雅黑', 12, 0x333333, false, false, false, null, null, TextFormatAlign.CENTER, 4, 4);
		// 操作按钮
		public static const BUTTON_FORMAT: TextFormat = new TextFormat('微软雅黑', 12, 0x333333, true, false, false, null, null, TextFormatAlign.CENTER);
		// 提示框文字
		public static const ALERT_FORMAT: TextFormat = new TextFormat('微软雅黑', 12, 0x333333, false, false, false, null, null, TextFormatAlign.CENTER);
		// 上传界面
		public static const UPLOAD_FORMAT: TextFormat = new TextFormat('微软雅黑', 12, 0x333333, false, false, false, null, null, TextFormatAlign.LEFT);
		// 普通文字
		public static const TEXT_FORMAT: TextFormat = new TextFormat('微软雅黑', 12, 0x333333, false, false, false, null, null, TextFormatAlign.LEFT);
	}
}