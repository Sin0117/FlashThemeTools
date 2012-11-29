package org.sjx.components {
	import flash.display.Sprite;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	
	import org.sjx.data.Terminal;
	import org.sjx.utils.TextFormats;
	
	public class ThemeInfo extends Sprite {
		
		private var _themeLabel: TextField;
		private var _authorLabel: TextField;
		private var _descLabel: TextField;
		private var _priceLabel: TextField;
		private var _ceteLabel: TextField;
		
		private var _themeField: TextField;
		private var _authorField: TextField;
		private var _descField: TextField;
		private var _priceFields: Array;
		private var _ceteField: Select;
		
		private var _price: String;
		
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
			
			_priceLabel = new TextField();
			_priceLabel.text = '作品价格：';
			_priceLabel.setTextFormat(TextFormats.THEME_LABEL_FORMAT);
			_priceLabel.x = 0;
			_priceLabel.y = 48;
			_priceLabel.width = 60;
			_priceLabel.height = 20;
			_priceLabel.mouseEnabled = false;
			addChild(_priceLabel);
			
			_descLabel = new TextField();
			_descLabel.text = '描述信息：';
			_descLabel.setTextFormat(TextFormats.THEME_LABEL_FORMAT);
			_descLabel.x = 0;
			_descLabel.y = 72;
			_descLabel.width = 60;
			_descLabel.height = 20;
			_descLabel.mouseEnabled = false;
			addChild(_descLabel);
			
			_ceteLabel = new TextField();
			_ceteLabel.text = '作品分类：';
			_ceteLabel.setTextFormat(TextFormats.THEME_LABEL_FORMAT);
			_ceteLabel.x = 0;
			_ceteLabel.y = 128;
			_ceteLabel.width = 60;
			_ceteLabel.height = 20;
			_ceteLabel.mouseEnabled = false;
			addChild(_ceteLabel);
			
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
			
			var prices: Array = Terminal.prices.split(",");
			_priceFields = [];
			for (var i: int = 0, price: String; price = prices[i]; i ++) {
				var priceItem: Radio = new Radio(72, 15, price, price);
				priceItem.x = 64 + i * 76;
				priceItem.y = 50;
				addChild(priceItem);
				priceItem.addEventListener(MouseEvent.CLICK, doRadioChanged);
				_priceFields.push(priceItem);
			}
			if (!!_priceFields.length)
				_priceFields[0].selected = true;
			
			_descField = new TextField();
			_descField.x = 64;
			_descField.y = 72;
			_descField.width = 640;
			_descField.height = 48;
			_descField.setTextFormat(TextFormats.THEME_INPUT_FORMAT);
			// _descField.maxChars = 40;
			_descField.restrict = "A-Za-z0-9\u4e00-\u9fa5";
			_descField.border = true;
			_descField.type = TextFieldType.INPUT;
			_descField.borderColor = 0x777777;
			addChild(_descField);
			
			_ceteField = new Select(221, 16, Terminal.categorys.split(","));
			_ceteField.x = 64;
			_ceteField.y = 128;
			addChild(_ceteField);
		}
		
		/** 价格变更时的处理. */
		private function doRadioChanged(evt: MouseEvent): void {
			var priceItem: Radio = evt.currentTarget as Radio;
			for (var i: int = 0, price: Radio; price = _priceFields[i]; i ++) {
				if (priceItem != price)
					price.selected = false;
			}
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
		public function get price(): String {
			return _price;
		}
		public function get category(): String {
			return _ceteField.value;
		}
	}
}