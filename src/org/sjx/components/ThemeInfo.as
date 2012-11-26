package org.sjx.components {
	import flash.display.Sprite;
	import flash.events.FocusEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	
	import org.sjx.utils.TextFormats;
	
	public class ThemeInfo extends Sprite {
		
		private var _themeLabel: TextField;
		private var _authorLabel: TextField;
		
		private var _themeField: TextField;
		private var _authorField: TextField;
		
		/** 主题相关信息. */
		public function ThemeInfo() {
			_themeLabel = new TextField();
			_themeLabel.text = '主题名称：';
			_themeLabel.setTextFormat(TextFormats.THEME_LABEL_FORMAT);
			_themeLabel.x = 0;
			_themeLabel.y = 0;
			_themeLabel.width = 60;
			_themeLabel.height = 20;
			_themeLabel.mouseEnabled = false;
			addChild(_themeLabel);
			_authorLabel = new TextField();
			_authorLabel.text = '作者名称：';
			_authorLabel.setTextFormat(TextFormats.THEME_LABEL_FORMAT);
			_authorLabel.x = 0;
			_authorLabel.y = 24;
			_authorLabel.width = 60;
			_authorLabel.height = 20;
			_authorLabel.mouseEnabled = false;
			addChild(_authorLabel);
			
			_themeField = new TextField();
			_themeField.x = 64;
			_themeField.y = 0;
			_themeField.width = 640;
			_themeField.height = 20;
			_themeField.setTextFormat(TextFormats.THEME_INPUT_FORMAT);
			_themeField.maxChars = 40;
			_themeField.restrict = "A-Za-z0-9\u4e00-\u9fa5";
			_themeField.border = true;
			_themeField.type = TextFieldType.INPUT;
			_themeField.borderColor = 0x777777;
			addChild(_themeField);
			_themeField.addEventListener(FocusEvent.FOCUS_OUT, function (): void {
				if (!!_themeField.text && _themeField.text.length > 0)
					_themeLabel.setTextFormat(TextFormats.THEME_LABEL_FORMAT);
			});
			_authorField = new TextField();
			_authorField.x = 64;
			_authorField.y = 24;
			_authorField.width = 640;
			_authorField.height = 20;
			_authorField.setTextFormat(TextFormats.THEME_INPUT_FORMAT);
			_authorField.maxChars = 40;
			_authorField.restrict = "A-Za-z0-9\u4e00-\u9fa5";
			_authorField.border = true;
			_authorField.type = TextFieldType.INPUT;
			_authorField.borderColor = 0x777777;
			addChild(_authorField);
			_authorField.addEventListener(FocusEvent.FOCUS_OUT, function (): void {
				if (!!_authorField.text && _authorField.text.length > 0)
					_authorLabel.setTextFormat(TextFormats.THEME_LABEL_FORMAT);
			});
		}
		
		/** 检测信息是否完整. */
		public function checkAuthor(): Boolean {
			if (!_authorField.text || _authorField.text.length <= 0) {
				_authorLabel.setTextFormat(TextFormats.THEEM_ERROR_LABEL_FORMAT);
				return false;
			}
			_authorLabel.setTextFormat(TextFormats.THEME_LABEL_FORMAT);
			_authorField.setSelection(0, 0);
			return true;
		}
		public function checkThemeName(): Boolean {
			if (!_themeField.text || _themeField.text.length <= 0) {
				_themeLabel.setTextFormat(TextFormats.THEEM_ERROR_LABEL_FORMAT);
				return false;
			}
			_themeLabel.setTextFormat(TextFormats.THEME_LABEL_FORMAT);
			_themeLabel.setSelection(0, 0);
			return true;
		}
		
		/** 设置是否可以编辑. */
		public function set enable(e: Boolean): void {
			if (e) {
				_themeField.type = TextFieldType.INPUT;
				_authorField.type = TextFieldType.INPUT;
			} else {
				_themeField.type = TextFieldType.DYNAMIC;
				_authorField.type = TextFieldType.DYNAMIC;
			}
		}
		
		/** 清空. */
		public function clear(): void {
			_themeField.text = '';
			_authorField.text = '';
			_themeLabel.setTextFormat(TextFormats.THEME_LABEL_FORMAT);
			_authorLabel.setTextFormat(TextFormats.THEME_LABEL_FORMAT);
		}
		
		public function get theme(): String {
			return _themeField.text;
		}
		public function get author(): String {
			return _authorField.text;
		}
	}
}