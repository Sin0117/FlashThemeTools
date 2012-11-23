package org.sjx.components {
	import com.qihoo.themefactory.sjx.components.FocusSprite;
	import com.qihoo.themefactory.sjx.components.LoaderSprite;
	import com.qihoo.themefactory.sjx.components.ThemeView;
	import com.qihoo.themefactory.sjx.ctrl.ViewManager;
	import com.qihoo.themefactory.sjx.utils.Utils;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	import org.osmf.net.StreamingURLResource;
	import org.sjx.components.Preview;
	
	/** 主题编辑。 */
	public class Editer extends Sprite {
		// 区域尺寸
		public static const WIDTH: int = 240;
		public static const HEIGHT: int = 400;
		
		private var _manager: ViewManager;
		private var _managerInitTimer: Timer;
		
		private var _focus: FocusSprite;
		private var _root: Preview;
		private var _lock: LoaderSprite;
		
		private var _mask: Shape;
			
		public function Editer(r: Preview) {
			_root = r;
			
			var wz: Number = WIDTH / Utils._width, hz: Number = HEIGHT / Utils._height;
			r.zoom = wz < hz ? wz : hz;
		}
		
		/** 获取当前显示视图. */
		public function findShowView(): ThemeView {
			for (var i: int = 0, n: int = this.numChildren; i < n; i ++) {
				if (this.getChildAt(i) is ThemeView) {
					return ThemeView(this.getChildAt(i));
				}
			}
			return null;
		}
		/** 设置当前屏. */
		public function set view(v: String): void {
			_manager.show(v);
		}
		/** 设置源数据. */
		public function render(terminal: Object): void {
			_manager = new ViewManager(_root, terminal);
			view = _root.view;
		}
		/** 更新内容. */
		public function update(json: Object): void {
			for (var key: String in json)
				_manager.setImage(key, json[key]);
		}
		/** 内容项发生改变. */
		public function change(key: String, src: String): void {
			_manager.setImage(key, src);
		}
		/** 内容项获取焦点. */
		public function focus(v: String, k: String): void {
			_focus.change(_manager.focus(k, v));
		}
	}
}
