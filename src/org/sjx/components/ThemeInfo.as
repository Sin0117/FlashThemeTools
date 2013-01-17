package org.sjx.components {
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	
	import org.sjx.data.Terminal;
	import org.sjx.utils.TextFormats;
	
	public class ThemeInfo extends Sprite {
		
		public static const LABEL_WIDTH: int = 68;
		// “中文字符、半角环境下英文字符、阿拉伯数字以及如下特殊字符_ - — . · ( )  （） ~
		public static const INPUT_RESTRICT: String = 'A-Za-z0-9\u4e00-\u9fa5_\\-\\(\\)\\~\\—\\.\\·';
		
		private var _themeLabel: TextField;
		private var _authorLabel: TextField;
		private var _descLabel: TextField;
		private var _priceLabel: TextField;
		private var _ceteLabel: TextField;
		private var _pkgLabel: TextField;
		
		private var _specificationSpace: Sprite;
		
		private var _themeField: Input;
		private var _authorField: Input;
		private var _descField: TextField;
		private var _priceFields: Array;
		private var _ceteField: Select;
		private var _pkgField: Input;
		
		private var _price: String;
		private var _root: SchoolCompete;
		
		/** 主题相关信息. */
		public function ThemeInfo(r: SchoolCompete) {
			_root = r;
			_themeLabel = new TextField();
			_themeLabel.text = '主题名称：';
			_themeLabel.setTextFormat(TextFormats.THEME_INFO_LABEL_FORMAT);
//			_themeLabel.border = true;
			_themeLabel.x = 0;
			_themeLabel.y = 20;
			_themeLabel.width = LABEL_WIDTH;
			_themeLabel.height = 20;
			_themeLabel.mouseEnabled = false;
			addChild(_themeLabel);
			// 主题名称输入框
			_themeField = new Input(294, 38, true, 0xffffff, 0xffffff, 0xcccccc, 0xa7cf72);
			_themeField.x = 72;
			_themeField.y = 12;
			_themeField.setFormat(TextFormats.THEME_INPUT_FORMAT);
			_themeField.maxChars = 40;
			_themeField.restrict = INPUT_RESTRICT;
			_themeField.border = true;
			addChild(_themeField);
			_themeField.addEventListener(FocusEvent.FOCUS_OUT, function (): void {
				if (!!_themeField.text && _themeField.text.length > 0)
					_themeLabel.setTextFormat(TextFormats.THEME_LABEL_FORMAT);
				checkValue();
			});
			
			_authorLabel = new TextField();
			_authorLabel.text = '主题作者：';
			_authorLabel.setTextFormat(TextFormats.THEME_INFO_LABEL_FORMAT);
//			_authorLabel.border = true;
			_authorLabel.x = 0;
			_authorLabel.y = 76;
			_authorLabel.width = LABEL_WIDTH;
			_authorLabel.height = 20;
			_authorLabel.mouseEnabled = false;
			addChild(_authorLabel);
			// 作者输入框
			_authorField = new Input(294, 38, true, 0xffffff, 0xffffff, 0xcccccc, 0xa7cf72);
			_authorField.x = 72;
			_authorField.y = 68;
			if (Terminal.userName) {
				_authorField.text = Terminal.userName;
				_authorField.type = false;
			}
			_authorField.setFormat(TextFormats.THEME_INPUT_FORMAT);
			_authorField.maxChars = 40;
			_authorField.restrict = INPUT_RESTRICT;
			_authorField.border = true;
			addChild(_authorField);
			_authorField.addEventListener(FocusEvent.FOCUS_OUT, function (): void {
				if (!!_authorField.text && _authorField.text.length > 0)
					_authorLabel.setTextFormat(TextFormats.THEME_LABEL_FORMAT);
				checkValue();
			});
			
			_priceLabel = new TextField();
			_priceLabel.text = '作品价格：';
			_priceLabel.setTextFormat(TextFormats.THEME_INFO_LABEL_FORMAT);
//			_priceLabel.border = true;
			_priceLabel.x = 0;
			_priceLabel.y = 117;
			_priceLabel.width = LABEL_WIDTH;
			_priceLabel.height = 20;
			_priceLabel.mouseEnabled = false;
			addChild(_priceLabel);
			// 价格选择区域
			var prices: Array = Terminal.prices.split(",");
			_priceFields = [];
			for (var i: int = 0, price: String; price = prices[i]; i ++) {
				var priceItem: Radio = new Radio(48, 15, price, price);
				priceItem.x = 72 + i * 48;
				priceItem.y = 120;
				addChild(priceItem);
				priceItem.addEventListener(MouseEvent.CLICK, doRadioChanged);
				_priceFields.push(priceItem);
			}
			if (_priceFields.length) {
				_priceFields[0].selected = true;
				_price = _priceFields[0].value;
			}
			
			_descLabel = new TextField();
			_descLabel.text = '描述信息：';
			_descLabel.setTextFormat(TextFormats.THEME_INFO_LABEL_FORMAT);
//			_descLabel.border = true;
			_descLabel.x = 0;
			_descLabel.y = 156;
			_descLabel.width = LABEL_WIDTH;
			_descLabel.height = 20;
			_descLabel.mouseEnabled = false;
			addChild(_descLabel);
			// 描述输入框
			_descField = new TextField();
			_descField.x = 72;
			_descField.y = 148;
			_descField.width = 404;
			_descField.height = 104;
			_descField.setTextFormat(TextFormats.THEME_TEXTAREA_FORMAT);
			// _descField.restrict = "A-Za-z0-9\u4e00-\u9fa5";
			_descField.multiline = true;
			_descField.wordWrap = true;
			_descField.border = true;
			_descField.type = TextFieldType.INPUT;
			_descField.borderColor = 0xcccccc;
			_descField.addEventListener(FocusEvent.FOCUS_IN, doInputFocusIn);
			_descField.addEventListener(FocusEvent.FOCUS_OUT, doInputFocusOut);
			addChild(_descField);
			
			_ceteLabel = new TextField();
			_ceteLabel.text = '作品分类：';
			_ceteLabel.setTextFormat(TextFormats.THEME_INFO_LABEL_FORMAT);
//			_ceteLabel.border = true;
			_ceteLabel.x = 0;
			_ceteLabel.y = 274;
			_ceteLabel.width = LABEL_WIDTH;
			_ceteLabel.height = 20;
			_ceteLabel.mouseEnabled = false;
			addChild(_ceteLabel);
			// 分类的下拉列表
			_ceteField = new Select(160, 28, Terminal.categorys.split(","), 0xcccccc, 0xa7cf72);
			_ceteField.x = 72;
			_ceteField.y = 270;
			addChild(_ceteField);
			
			_pkgLabel = new TextField();
			_pkgLabel.text = '包名：';
			_pkgLabel.setTextFormat(TextFormats.THEME_INFO_LABEL_FORMAT);
			_pkgLabel.x = 270;
			_pkgLabel.y = 274;
			_pkgLabel.width = 32;
			_pkgLabel.height = 20;
			_pkgLabel.mouseEnabled = false;
			addChild(_pkgLabel);
			// 作者输入框
			_pkgField = new Input(294, 28, true, 0xffffff, 0xffffff, 0xcccccc, 0xa7cf72);
			_pkgField.x = 306;
			_pkgField.y = 270
			_pkgField.setFormat(TextFormats.THEME_INPUT_FORMAT);
			// _pkgField.restrict = "A-Za-z0-9\u4e00-\u9fa5";
			_pkgField.border = true;
			addChild(_pkgField);
			_pkgField.addEventListener(FocusEvent.FOCUS_OUT, function (): void {
				if (!!_pkgField.text && _pkgField.text.length > 0)
					_pkgLabel.setTextFormat(TextFormats.THEME_LABEL_FORMAT);
				checkValue();
			});
			if (!Terminal.pkg) {
				_pkgLabel.visible = false;
				_pkgField.visible = false;
			}
			
			_specificationSpace = new Sprite();
			_specificationSpace.x = 506;
			_specificationSpace.y = 12;
			var g: Graphics = _specificationSpace.graphics;
			g.lineStyle(8, 0xEEEEEE, .8);
			g.beginFill(0xFFFFFF);
			g.drawRoundRect(0, 0, 300, 240, 16);
			g.endFill();
			addChild(_specificationSpace);
			
			var specification: TextField = new TextField();
			specification.x = 16;
			specification.y = 16;
			specification.multiline = true;
			specification.width = 268;
			specification.height = 208;
			specification.text = '主题制作注意事项：\n1.主题名称、作者名称只能包含：\n   ' +
				'中文字符、半角环境下英文字符、阿拉伯数\n   字以及如下特殊字符  _  -  —  .  ·  (  )  ~；\n2.图片格式，请按照主题规范' +
				'内图片格式与尺\n   寸要求进行上传；\n3.图片格式必须是PS软件直接存储的格式，请\n   不要修改图片后缀名。';
			specification.setTextFormat(TextFormats.THEME_INFO_SPECIFICATION, 0, 98);
			specification.setTextFormat(TextFormats.THEME_INFO_SPECIFICATION_LINK, 98, 102);
			specification.setTextFormat(TextFormats.THEME_INFO_SPECIFICATION, 102, specification.text.length);
			_specificationSpace.addChild(specification);
		}
		
		/** 输入框的焦点事件. */
		private function doInputFocusIn(evt: FocusEvent): void {
			evt.currentTarget.borderColor = 0xa7cf72;
		}
		private function doInputFocusOut(evt: FocusEvent): void {
			evt.currentTarget.borderColor = 0xcccccc;
			checkValue();
		}
		
		/** 检测是否内容填写完毕. */
		public function checkValue(evt: Object = null): void {
			if (_themeField.text != null && _themeField.text.length &&
				_authorField.text != null && _authorField.text.length &&
				_descField.text != null && _descField.text.length) {
				if (!Terminal.pkg) {
					_root.readyInfo = true;
				} else {
					if (_pkgField.text != null && _pkgField.text.length)
						_root.readyInfo = true;
					else
						_root.readyInfo = false;
				}
			} else {
				_root.readyInfo = false;
			}
		}
		
		/** 价格变更时的处理. */
		private function doRadioChanged(evt: MouseEvent): void {
			var priceItem: Radio = evt.currentTarget as Radio;
			for (var i: int = 0, price: Radio; price = _priceFields[i]; i ++) {
				if (priceItem != price)
					price.selected = false;
			}
			_price = priceItem.value;
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
			_themeField.setSelection(0, 0);
			return true;
		}
		
		/** 设置是否可以编辑. */
		public function set enable(e: Boolean): void {
			_themeField.type = e;
		}
		
		/** 清空. */
		public function clear(): void {
			_themeField.text = '';
			_themeLabel.setTextFormat(TextFormats.THEME_LABEL_FORMAT);
			_authorField.text = '';
			_authorLabel.setTextFormat(TextFormats.THEME_LABEL_FORMAT);
			_descField.text = '';
			_descLabel.setTextFormat(TextFormats.THEME_LABEL_FORMAT);
		}
		
		public function get theme(): String {
			return _themeField.text;
		}
		public function get author(): String {
			return _authorField.text;
		}
		public function set author(name: String): void {
			_authorField.text = name;
		}
		public function get price(): String {
			return _price;
		}
		public function get desc(): String {
			return _descField.text;
		}
		public function get category(): String {
			return _ceteField.value;
		}
		public function get pkg(): String {
			return _pkgField.text;
		}
	}
}