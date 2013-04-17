package org.sjx.components {
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class WeatherSetting extends Sprite {
		
		private var _data: Object;
		private var _list: UploadList;
		private var _root: SchoolCompete;
		
		private var _items: Array;
		private var _packs: Object;
		private var _imagesSpace: Sprite;
		private var _weatherSpace: Sprite;
		private var _labelsSpace: Sprite;
		
		private var _colorFields: Object;
		private var _sizeFields: Object;
		private var _shadowColorFields: Object;
		private var _shadowRadiusFields: Object;
		private var _shadowAngleFields: Object;
		private var _shadowFuzzyFields: Object;
		
		private var _current: String;
		private var _weatherList: Select;
		private var _weathers: Object;
		private var _weatherArr: Object;
		private var _group: Object;
		private var _modeName: String;
		
		public function WeatherSetting(name: String, data: Object, list: UploadList, r: SchoolCompete) {
			_modeName = name;
			_root = r;
			_data = data;
			_list = list;
			_items = [];
			_colorFields = {};
			_sizeFields = {};
			_shadowColorFields = {};
			_shadowRadiusFields = {};
			_shadowAngleFields = {};
			_shadowFuzzyFields = {};
			_packs = {};
			_weathers = {};
			_weatherArr = {};
			_group = {};
			draw(); 
		}
		
		private function draw(): void {
			var labelsData: Object = _data['labels'], imagesData: Object = _data['images'],
				beginX: int = 0, itemIndex: int = 0, beginY: int = 0, rowIndex: int = 0,
				itemHeight: int = SchoolCompete.UPLOAD_ITEM_PADDING_V + SchoolCompete.UPLOAD_ITEM_HEIGHT;
			
			_imagesSpace = new Sprite();
			_drawLine('图片设置：', _imagesSpace);
			_imagesSpace.y = beginY;
			beginY += 24 + SchoolCompete.UPLOAD_ITEM_PADDING_V;
			addChild(_imagesSpace);
			for (var j: int = 0, imgData: Object; imgData = imagesData[j]; j++) {
				if (imgData['list']) {
					var listKey: String = imgData['list'];
					if (!_weatherArr[listKey]) {
						_weathers[listKey] = {};
						_weatherArr[listKey] = [];
					}
					_weathers[listKey][imgData['name']] = imgData;
					_weatherArr[listKey].push(imgData['name']);
				} else {
					var name: String = imgData['name'], pack: String = imgData['pack'];
					var item: WeatherImage = new WeatherImage(pack, imgData, _list);
					item.x = beginX + itemIndex % SchoolCompete.UPLOAD_ITEM_SIZE * (SchoolCompete.UPLOAD_ITEM_PADDING_H + SchoolCompete.UPLOAD_ITEM_WIDTH);
					item.y = beginY;
					item.addEventListener(MouseEvent.MOUSE_OVER, doItemOver);
					item.addEventListener(MouseEvent.MOUSE_OUT, doItemOut);
					addChild(item);
					_items.push(item);
					_packs[pack] = item;
					_root.updateWeather(pack, imgData['def'] || null, _modeName);
					
					itemIndex ++;
				}
				var index: int = itemIndex / SchoolCompete.UPLOAD_ITEM_SIZE >> 0;
				if (rowIndex < index) {
					beginY += itemHeight;
					rowIndex = index;
				}
			}
			if (_items.length % SchoolCompete.UPLOAD_ITEM_SIZE)
				beginY += itemHeight;
			
			_weatherSpace = new Sprite();
			_drawLine('天气图标：', _weatherSpace);
			_weatherSpace.y = beginY;
			beginY += 24 + SchoolCompete.UPLOAD_ITEM_PADDING_V;
			addChild(_weatherSpace);
			
			beginX = 0;
			itemIndex = 0;
			rowIndex = 0;
			for (var k: int = 0, weatherKey: String; weatherKey = _weatherArr["weather"][k]; k++) {
				var weatherImgData: Object = _weathers["weather"][weatherKey];
				var weatherName: String = weatherImgData['name'], weatherPack: String = weatherImgData['pack'];
				var weatherItem: WeatherImage = new WeatherImage(weatherPack, weatherImgData, _list);
				weatherItem.x = beginX + itemIndex % SchoolCompete.UPLOAD_ITEM_SIZE * (SchoolCompete.UPLOAD_ITEM_PADDING_H + SchoolCompete.UPLOAD_ITEM_WIDTH);
				weatherItem.y = beginY;
				weatherItem.addEventListener(MouseEvent.MOUSE_OVER, doItemOver);
				weatherItem.addEventListener(MouseEvent.MOUSE_OUT, doItemOut);
				addChild(weatherItem);
				_items.push(weatherItem);
				_packs[weatherPack] = weatherItem;
				_root.updateWeather(weatherPack, weatherImgData['def'] || null, _modeName);
				
				itemIndex ++;
				var weatherIndex: int = itemIndex / SchoolCompete.UPLOAD_ITEM_SIZE >> 0;
				if (rowIndex < weatherIndex) {
					beginY += itemHeight;
					rowIndex = weatherIndex;
				}
			}
			if (_weatherArr["weather"].length % SchoolCompete.UPLOAD_ITEM_SIZE)
				beginY += itemHeight;
			
			var listLabel: TextField = new TextField();
			listLabel.x = 0;
			listLabel.y = beginY;
			listLabel.autoSize = TextFieldAutoSize.LEFT;
			listLabel.text = '当前天气：';
			listLabel.setTextFormat(_makeTextFormat(14, 0x333333));
			addChild(listLabel);
			_weatherList = new Select(180, 24, _weatherArr['weather'], 0xcccccc, 0xa7cf72);
			_weatherList.x = 72;
			_weatherList.y = beginY - 2;
			_weatherList.addEventListener(Select.EVENT_CLICK, doWeatherSelect);
			beginY += 24 + SchoolCompete.UPLOAD_ITEM_PADDING_V;
			
			_labelsSpace = new Sprite();
			_drawLine('文本设置：', _labelsSpace);
			_labelsSpace.y = beginY;
			beginY += 24 + SchoolCompete.UPLOAD_ITEM_PADDING_V;
			addChild(_labelsSpace);
			for (var i: int = 0, labData: Object; labData = labelsData[i]; i++) {
				var group: String = labData['group'];
				if (_group[group]) {
					_group[group].push(labData);
				} else {
					var shadowX: int = labData['shadow_dx'],
						shadowY: int = labData['shadow_dy'],
						shadowAngle: int = Math.atan2(shadowY, shadowX) * 180 / Math.PI,
						shadowSize: int = Math.sqrt(shadowY * shadowY + shadowX * shadowX);
					var label: TextField = new TextField();
					label.x = 0;
					label.y = beginY;
					label.autoSize = TextFieldAutoSize.LEFT;
					label.text = group;
					label.setTextFormat(_makeTextFormat(14, 0x333333));
					addChild(label);
					var colLab: TextField = new TextField();
					colLab.x = 36;
					colLab.y = beginY;
					colLab.autoSize = TextFieldAutoSize.LEFT;
					colLab.text = '文字颜色:';
					colLab.setTextFormat(_makeTextFormat(14, 0x333333));
					addChild(colLab);
					var colorField: TextField = new TextField();
					colorField.x = 100;
					colorField.y = beginY;
					colorField.width = 64;
					colorField.height = 18;
					colorField.name = group;
					colorField.border = true;
					colorField.restrict = "abcdefABCDEF0-9";
					colorField.type = TextFieldType.INPUT;
					colorField.maxChars = 8;
					colorField.text = labData['color'] ? uint(labData['color']).toString(16) : 'FF000000';
					colorField.setTextFormat(_makeTextFormat(12, 0x333333));
					colorField.addEventListener(FocusEvent.FOCUS_OUT, function (evt: FocusEvent): void {
						var curField: TextField = evt.currentTarget as TextField,
							group: String = curField.name;
						for (var l: int = 0, groupName: Object; groupName = _group[group][l]; l ++)
							_root.updateWeatherColor(groupName['pack'], uint('0x' + curField.text));
					});
					addChild(colorField);
					_colorFields[group] = colorField;
					
					var sizeLab: TextField = new TextField();
					sizeLab.x = 172;
					sizeLab.y = beginY;
					sizeLab.autoSize = TextFieldAutoSize.LEFT;
					sizeLab.text = '文字尺寸:';
					sizeLab.setTextFormat(_makeTextFormat(14, 0x333333));
					addChild(sizeLab);
					var sizeField: TextField = new TextField();
					sizeField.x = 236;
					sizeField.y = beginY;
					sizeField.width = 64;
					sizeField.height = 18;
					sizeField.name = group;
					sizeField.restrict = "0-9";
					sizeField.type = TextFieldType.INPUT;
					sizeField.maxChars = 3;
					sizeField.border = true;
					sizeField.text = labData['size'];
					sizeField.setTextFormat(_makeTextFormat(12, 0x333333));
					sizeField.addEventListener(FocusEvent.FOCUS_OUT, function (evt: FocusEvent): void {
						var curField: TextField = evt.currentTarget as TextField,
						group: String = curField.name;
						for (var l: int = 0, groupName: Object; groupName = _group[group][l]; l ++)
							_root.updateWeatherSize(groupName['pack'], Number(curField.text));
					});
					addChild(sizeField);
					_sizeFields[group] = sizeField;
					beginY += SchoolCompete.UPLOAD_LABEL_HEIGHT;
					// 阴影颜色
					var shadowColorLab: TextField = new TextField();
					shadowColorLab.x = 36;
					shadowColorLab.y = beginY;
					shadowColorLab.autoSize = TextFieldAutoSize.LEFT;
					shadowColorLab.text = '阴影颜色:';
					shadowColorLab.setTextFormat(_makeTextFormat(14, 0x333333));
					addChild(shadowColorLab);
					var shadowColorField: TextField = new TextField();
					shadowColorField.x = 100;
					shadowColorField.y = beginY;
					shadowColorField.width = 64;
					shadowColorField.height = 18;
					shadowColorField.name = group;
					shadowColorField.restrict = "abcdefABCDEF0-9";
					shadowColorField.type = TextFieldType.INPUT;
					shadowColorField.maxChars = 8;
					shadowColorField.border = true;
					shadowColorField.text = labData['shadow_color'] ? uint(labData['shadow_color']).toString(16) : 'FF000000';
					shadowColorField.setTextFormat(_makeTextFormat(12, 0x333333));
					shadowColorField.addEventListener(FocusEvent.FOCUS_OUT, function (evt: FocusEvent): void {
						var curField: TextField = evt.currentTarget as TextField,
							group: String = curField.name;
						for (var l: int = 0, groupName: Object; groupName = _group[group][l]; l ++)
							_root.updateWeatherShadowColor(groupName['pack'], uint('0x' + curField.text));
					});
					addChild(shadowColorField);
					_shadowColorFields[group] = shadowColorField;
					// 阴影距离
					var shadowRadiusLab: TextField = new TextField();
					shadowRadiusLab.x = 172;
					shadowRadiusLab.y = beginY;
					shadowRadiusLab.autoSize = TextFieldAutoSize.LEFT;
					shadowRadiusLab.text = '阴影距离:';
					shadowRadiusLab.setTextFormat(_makeTextFormat(14, 0x333333));
					addChild(shadowRadiusLab);
					var shadowRadiusField: TextField = new TextField();
					shadowRadiusField.x = 236;
					shadowRadiusField.y = beginY;
					shadowRadiusField.width = 64;
					shadowRadiusField.height = 18;
					shadowRadiusField.name = group;
					shadowRadiusField.restrict = "0-9";
					shadowRadiusField.type = TextFieldType.INPUT;
					shadowRadiusField.maxChars = 3;
					shadowRadiusField.border = true;
					shadowRadiusField.text = 'shadowSize';
					shadowRadiusField.setTextFormat(_makeTextFormat(12, 0x333333));
					shadowRadiusField.addEventListener(FocusEvent.FOCUS_OUT, function (evt: FocusEvent): void {
						var curField: TextField = evt.currentTarget as TextField,
							group: String = curField.name;
						for (var l: int = 0, groupName: Object; groupName = _group[group][l]; l ++)
							_root.updateWeatherShadowDistance(groupName['pack'], int(curField.text));
					});
					addChild(shadowRadiusField);
					_shadowRadiusFields[group] = shadowRadiusField;
					beginY += SchoolCompete.UPLOAD_LABEL_HEIGHT;
					// 阴影角度
					var shadowAngleLab: TextField = new TextField();
					shadowAngleLab.x = 36;
					shadowAngleLab.y = beginY;
					shadowAngleLab.autoSize = TextFieldAutoSize.LEFT;
					shadowAngleLab.text = '阴影角度:';
					shadowAngleLab.setTextFormat(_makeTextFormat(14, 0x333333));
					addChild(shadowAngleLab);
					var shadowAngleField: TextField = new TextField();
					shadowAngleField.x = 100;
					shadowAngleField.y = beginY;
					shadowAngleField.width = 64;
					shadowAngleField.height = 18;
					shadowAngleField.name = group;
					shadowAngleField.restrict = "0-9";
					shadowAngleField.type = TextFieldType.INPUT;
					shadowAngleField.maxChars = 3;
					shadowAngleField.border = true;
					shadowAngleField.text = '' + shadowAngle;
					shadowAngleField.setTextFormat(_makeTextFormat(12, 0x333333));
					shadowAngleField.addEventListener(FocusEvent.FOCUS_OUT, function (evt: FocusEvent): void {
						var curField: TextField = evt.currentTarget as TextField,
						group: String = curField.name;
						for (var l: int = 0, groupName: Object; groupName = _group[group][l]; l ++)
							_root.updateWeatherShadowAngle(groupName['pack'], int(curField.text));
					});
					addChild(shadowAngleField);
					_shadowAngleFields[group] = shadowAngleField;
					// 模糊力度
					var shadowFuzzyLab: TextField = new TextField();
					shadowFuzzyLab.x = 172;
					shadowFuzzyLab.y = beginY;
					shadowFuzzyLab.autoSize = TextFieldAutoSize.LEFT;
					shadowFuzzyLab.text = '模糊力度:';
					shadowFuzzyLab.setTextFormat(_makeTextFormat(14, 0x333333));
					addChild(shadowFuzzyLab);
					var shadowFuzzyField: TextField = new TextField();
					shadowFuzzyField.x = 236;
					shadowFuzzyField.y = beginY;
					shadowFuzzyField.width = 64;
					shadowFuzzyField.height = 18;
					shadowFuzzyField.name = group;
					shadowFuzzyField.restrict = "0-9";
					shadowFuzzyField.type = TextFieldType.INPUT;
					shadowFuzzyField.maxChars = 3;
					shadowFuzzyField.border = true;
					shadowFuzzyField.text = labData['shadow_radius'];
					shadowFuzzyField.setTextFormat(_makeTextFormat(12, 0x333333));
					shadowFuzzyField.addEventListener(FocusEvent.FOCUS_OUT, function (evt: FocusEvent): void {
						var curField: TextField = evt.currentTarget as TextField,
						group: String = curField.name;
						for (var l: int = 0, groupName: Object; groupName = _group[group][l]; l ++)
							_root.updateWeatherShadowFuzzy(groupName['pack'], Number(curField.text));
					});
					addChild(shadowFuzzyField);
					_shadowFuzzyFields[group] = shadowFuzzyField;
					beginY += SchoolCompete.UPLOAD_LABEL_HEIGHT;
					_group[group] = [labData];
				}
			}
			addChild(_weatherList);
			
			addEventListener(Event.ADDED_TO_STAGE, function (evt: Event): void {
				doWeatherSelect();
			});
		}
		
		/** 根据pack获取group名称. */
		private function findGroupByPack(pack: String): String {
			for (var group: String in _group) {
				for (var i: int = 0, groupItem: Object; groupItem = _group[group][i]; i ++)
					if (groupItem['pack'] && groupItem['pack'] == pack)
						return group;
			}
			return null;
		}
		
		/** 下拉列表变更. */
		private function doWeatherSelect(evt: Event = null): void {
			var selected: Object = _weathers['weather'][_weatherList.value];
			_root.changeWeather(selected['pack'], _modeName);
			_root.updateWeatherText("txt_weather_description", selected['name'], _modeName);
		}
		
		/** 绘制横线. */
		private function _drawLine(txt: String, space: Sprite): void {
			var g: Graphics = space.graphics, lab: TextField = new TextField();
			g.lineStyle(1, 0x666666);
			g.moveTo(0, 22);
			g.lineTo(SchoolCompete.UPLOAD_WIDTH - 8, 22);
			g.endFill();
			lab.text = txt;
			lab.width = SchoolCompete.UPLOAD_WIDTH;
			lab.height = 20;
			lab.x = 4;
			lab.y = 0;
			space.addChild(lab);
		}
		
		/** 获取当前数据. */
		public function get data(): Object {
			return _data;
		}
		
		/** 设置内容项。 */
		public function setItme(pack: String, itemData: Object): void {
			if (itemData['url']) {
				if (_packs[pack])
					_packs[pack].update(itemData['url']);
			} else {
				var group: String = findGroupByPack(pack), field: TextField, format: TextFormat;
				if (!group) return;
				if (itemData['size']) {
					field = _sizeFields[group];
					format = field.getTextFormat();
					field.text = itemData['size'];
					field.setTextFormat(format);
				}
				if (itemData['color']) {
					field = _colorFields[group];
					format = field.getTextFormat();
					field.text = itemData['color'].replace('#', '');
					field.setTextFormat(format);
				}
				if (itemData['shadow_color']) {
					field = _shadowColorFields[group];
					format = field.getTextFormat();
					field.text = itemData['shadow_color'].replace('#', '');
					field.setTextFormat(format);
				}
				if (itemData['shadow_radius']) {
					field = _shadowRadiusFields[group];
					format = field.getTextFormat();
					field.text = itemData['shadow_radius'];
					field.setTextFormat(format);
				}
			}
		}
		
		/** 鼠标移出上传项的提示. */
		private function doItemOut(evt: MouseEvent): void {
			_list.doItemOut();
		}
		/** 鼠标移入上传项的提示. */
		public function doItemOver(evt: MouseEvent): void {
			var curItem: DisplayObject = evt.currentTarget as DisplayObject;
			_list.doItemOver(curItem, 0, UploadList.TAB_HEIGHT);
		}
		
		private static function _makeTextFormat(size: int, color: uint): TextFormat {
			return new TextFormat('微软雅黑', size, color, false, false, false, null, null, TextFormatAlign.LEFT);
		}
	}
}