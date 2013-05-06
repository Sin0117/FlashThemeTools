package org.sjx.components {
	import com.qihoo.themefactory.sjx.ctrl.ImageManager;
	import com.qihoo.themefactory.sjx.modes.Image;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.filters.DropShadowFilter;
	import flash.filters.ShaderFilter;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import org.osmf.net.StreamingURLResource;
	
	/** 时钟天气的widget。 */
	public class WeatherWidget extends Sprite {
		
		public static const WIDTH: int = 472;
		public static const HEIGHT: int = 236;
		
		public static const KEY: String = 'weather';
		
		private var _data: Object;
		
		private var _parentView: String;
		private var _labels: Object;
		private var _images: Object;
		private var _imageData: Object;
		private var _labelData: Object;
		private var _zoom: Number;
		private var _imagesLen: int;
		private var _labelsLen: int;
		private var _modeName: String;
		
		private var _current: DisplayObject;
		private var _imageManager: ImageManager;
		private var _keyVersion: Object;
		private var _root: SchoolCompete;
		
		public function WeatherWidget(name: String, weather: Object, z: Number, r: SchoolCompete) {
			_labels = {};
			_images = {};
			_keyVersion = {};
			_imageData = {};
			_labelData = {};
			_modeName = name;
			_root = r;
			_zoom = z;
			_imageManager = new ImageManager(_zoom);
			data = weather;
		}
		
		public function set data(weather: Object): void {
			_data = weather;
			_parentView = _data['parent'];
			var labelsData: Array = _data['labels'], 
				imagesData: Array = _data['images'],
				rootKey: String = _data['root'];
			_imagesLen = imagesData.length;
			_labelsLen = labelsData.length;
			for (var j: int = 0, imgData: Object; imgData = imagesData[j]; j++) {
				var key: String = imgData['pack']
				if (imgData['hidden']) {
					_imageData[key] = imgData;
					continue;
				}
				var vZoom: Number = imgData['zoom'] || 1,
					x: Number = imgData['x'] * _zoom, y: Number = imgData['y'] * _zoom,
					w: Number = imgData['width'] * _zoom * vZoom, 
					h: Number = imgData['height'] * _zoom * vZoom,
					cavnas: Bitmap = new Bitmap(new BitmapData(w, h, true, 0x00000000));
				cavnas.x = x;
				cavnas.y = y;
				cavnas.width = w;
				cavnas.height = h;
				addChild(cavnas);
				setChildIndex(cavnas, key == rootKey ? 0 : 1);
				
				if (imgData['list'])
					cavnas.visible = false;
				_images[key] = cavnas;
				_imageData[key] = imgData;
// ExternalInterface.call('console.log', imgData['name'] + ' 规格尺寸 : ' + imgData['width'] + ' * ' + imgData['height'] + '(' + imgData['format'] + ')');				
			}
			
			for (var i: int = 0, labData: Object; labData = labelsData[i]; i++) {
				var label: TextField = new TextField(), vZoom: Number = labData['zoom'] || 1;
				label.x = labData['x'] * _zoom;
				label.y = labData['y'] * _zoom;
				label.autoSize = TextFieldAutoSize.LEFT;
				label.text = labData['txt'];
				label.setTextFormat(_makeTextFormat(labData['size'] * _zoom * vZoom, uint(labData['color'])));
				addChild(label);
				_labels[labData['pack']] = label;
				_labelData[labData['pack']] = labData;
				
				if (labData['shadow_radius']) {
					updateShadow(labData['pack']);
				}
			}
		}
		
		private function doLoader(key: String, val: String): void {
			if (_images[key]) {
				var cavnas: Bitmap = _images[key];
				cavnas.bitmapData.fillRect(new Rectangle(0, 0, cavnas.width, cavnas.height), 0x00000000);
				if (val) {
					var time: uint = new Date().getTime();
					_keyVersion[key] = time;
					_root.doPreviewLoad();
					_imageManager.getImage(val, time, function (img: Image, curTime: uint): void {
						var w: Number = cavnas.width, h: Number = cavnas.height,
							bd: BitmapData = img.bitmapData,
							bw: Number = bd.width, bh: Number = bd.height,
							wz: Number = w / bw, hz: Number = h / bh, 
							z: Number = wz > hz ? hz : wz;
						cavnas.bitmapData.draw(img.bitmapData, new Matrix(z, 0, 0, z));
						_root.doPreviewLoaded();
					}, null);
				}
			}
			if (_imageData[key])
				_imageData[key]['def'] = val;
		}
		
		public function get view(): String {
			return _parentView;
		}
		
		/** 变更天气显示。 */
		public function changeWeather(pack: String): void {
			if (_images[pack]) {
				if (_current)
					_current.visible = false;
				var canvas: DisplayObject = _images[pack];
				canvas.visible = true;
				setChildIndex(canvas, _imagesLen - 1);
				_current = canvas;
			}
		}
		
		/** 更新内容. */
		public function updateText(pack: String, val: String): void {
			if (_labels[pack]) {
				var label: TextField = _labels[pack], format: TextFormat = label.getTextFormat();
				label.text = val;
				label.setTextFormat(format);
			}
		}
		
		/** 更新数据. */
		public function updateAt(pack: String, val: String): void {
			doLoader(pack, val);
			_root.setWeatherReady(check(), this);
		}
		public function updateSize(pack: String, size: int): void {
			if (_labels[pack]) {
				var labData: Object = _labelData[pack], vZoom: Number = labData['zoom'] || 1,
					label: TextField = _labels[pack], format: TextFormat = label.getTextFormat();
				format.size = size * _zoom * vZoom;
				label.setTextFormat(format);
				_labelData[pack]['size'] = size;
			}
			_root.setWeatherReady(check(), this);
		}
		public function updateColor(pack: String, color: uint): void {
			if (_labels[pack]) {
				var label: TextField = _labels[pack], format: TextFormat = label.getTextFormat();
				format.color = color;
				label.setTextFormat(format);
				_labelData[pack]['color'] = color;
			}
			_root.setWeatherReady(check(), this);
		}
		public function updateWeatherShadowX(pack: String, x: Number): void {
			if (_labels[pack] && _labelData[pack]) {
				var labData: Object = _labelData[pack];
				_labelData[pack]['shadow_dx'] = x;
				updateShadow(pack);
			}
			_root.setWeatherReady(check(), this);
		}
		public function updateWeatherShadowColor(pack: String, color: uint): void {
			if (_labels[pack] && _labelData[pack]) {
				_labelData[pack]['shadow_color'] = color;
				updateShadow(pack);
			}
			_root.setWeatherReady(check(), this);
		}
		public function updateWeatherShadowY(pack: String, y: int): void {
			if (_labels[pack] && _labelData[pack]) {
				var labData: Object = _labelData[pack];
				_labelData[pack]['shadow_dy'] = y;
				updateShadow(pack);
			}
			_root.setWeatherReady(check(), this);
		}
		public function updateWeatherShadowFuzzy(pack: String, fuzzy: int): void {
			if (_labels[pack] && _labelData[pack]) {
				_labelData[pack]['shadow_radius'] = fuzzy;
				updateShadow(pack);
			}
			_root.setWeatherReady(check(), this);
		}
		public function updateShadow(pack: String): void {
			if (_labels[pack]) {
				var labData: Object = _labelData[pack],
					color: uint = labData['shadow_color'],
					radius: Number = labData['shadow_radius'],
					vZoom: Number = labData['zoom'] || 1,
					dx: Number = labData['shadow_dx'], dy: Number = labData['shadow_dy'],
					distance: Number = Math.sqrt(dy * dy + dx * dx),
					angle: Number = Math.atan2(dy, dx) * 180 / Math.PI;
				if (radius) {
					var shadowFilter: DropShadowFilter = new DropShadowFilter(
						distance * _zoom * vZoom, angle, color, 1, 
						radius * _zoom, radius * _zoom);
					_labels[pack].filters = [shadowFilter];
				}
			}
			_root.setWeatherReady(check(), this);
		}
		
		private static function _makeTextFormat(size: int, color: uint): TextFormat {
			return new TextFormat('微软雅黑', size, color, false, false, false, null, null, TextFormatAlign.LEFT);
		}
		
		/** 检测是否定制完毕. */
		public function check(): Boolean {
			var pack: String;
			for (pack in _imageData) {
				if (!_imageData[pack]['def'])
					return false;
			}
			for (pack in _labelData) {
				if (!_labelData[pack]['size'] || !_labelData[pack]['color']) {
					return false;
				}
			}
			return true;
		}
		
		/** 获取全部的上传项. */
		override public function toString(): String {
			var arr: Array = [], pack: String;
			arr.push('"theme":"' + _modeName + '"');
			for (pack in _imageData) {
				arr.push('"' + pack + '":{"url":"' + _imageData[pack]['def'] + '"}');
			}
			for (pack in _labelData) {
				arr.push('"' + pack + '":{"size":"' + _labelData[pack]['size'] + 
					'","color":"#' + colorTo8(uint(_labelData[pack]['color']).toString(16)) +
					'","shadow_dx":"' + _labelData[pack]['shadow_dx'] + 
					'","shadow_dy":"' + _labelData[pack]['shadow_dy'] + 
					'","shadow_color":"#' + colorTo8(uint(_labelData[pack]['shadow_color']).toString(16)) + 
					'","shadow_radius":"' + _labelData[pack]['shadow_radius'] + 
					'"}');
			}
			return '{' + arr.join(',') + '}';
		}
		
		/** 把数字转换成8个字符长度. */
		private function colorTo8(color: String): String {
			var val: Array = color.split('');
			for (var checkI: int = val.length; checkI < 8; checkI ++)
				val.unshift(0);
			return val.join('');
		}
	}
}
