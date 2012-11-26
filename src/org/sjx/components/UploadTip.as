package org.sjx.components {
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	
	public class UploadTip extends Sprite {
		
		private var _htmlFormat: StyleSheet;
		private var _label: TextField;
		
		private var _centerX: int;
		
		private var _curX: int;
		
		public function UploadTip() {
			_htmlFormat = new StyleSheet();
			_htmlFormat.setStyle(".item", {
				color: '#333333',
				fontSize: '12px',
				fontFamily: '微软雅黑',
				leading: '4px'
			});
			
			_label = new TextField();
			_label.wordWrap = true;
			_label.styleSheet = _htmlFormat;
			_label.width = SchoolCompete.TIP_WIDTH - 16;
			_label.height = SchoolCompete.TIP_HEIGHT - 16;
			_label.x = 8;
			_label.y = 8;
			addChild(_label);
			
			_centerX = SchoolCompete.TIP_WIDTH >> 1;
			draw();
		}
		
		public function update(tip: String): void {
			_label.htmlText = tip;
			_label.styleSheet = _htmlFormat;
		}
		
		public function pos(): void {
			_curX = this.x;
			if (this.x < _centerX) {
				this.x = UploadItem.PADDING_H;
			} else {
				if (SchoolCompete.UPLOAD_WIDTH - this.x < UploadItem.PADDING_H) {
					this.x = SchoolCompete.UPLOAD_WIDTH - UploadItem.PADDING_H - SchoolCompete.TIP_WIDTH;
				} else {
					this.x -= SchoolCompete.TIP_WIDTH - UploadItem.WIDTH >> 1;
				}
			}
			draw();
		}
		
		private function draw(): void {
			var g: Graphics = this.graphics;
			g.clear();
			g.beginFill(0xFFFFFF, 1);
			g.lineStyle(2, 0xc7df99, 1);
			g.drawRoundRect(0, 0, SchoolCompete.TIP_WIDTH, SchoolCompete.TIP_HEIGHT, 8);
			g.endFill();
		}
	}
}