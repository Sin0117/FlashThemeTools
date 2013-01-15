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
				color: '#000000',
				fontSize: '13px',
				fontFamily: '微软雅黑',
				leading: '2px'
			});
			
			_label = new TextField();
			_label.wordWrap = true;
			_label.styleSheet = _htmlFormat;
			_label.width = SchoolCompete.TIP_WIDTH - 24;
			_label.height = SchoolCompete.TIP_HEIGHT - 32;
			_label.x = 12;
			_label.y = SchoolCompete.TIP_HEAD_HEIGHT + 12;
			addChild(_label);
			
			_centerX = SchoolCompete.TIP_WIDTH >> 1;
			draw();
		}
		
		public function update(tip: String): void {
			_label.htmlText = tip;
			_label.styleSheet = _htmlFormat;
		}
		
		public function pos(): void {
			_curX = this.x + SchoolCompete.UPLOAD_ITEM_WIDTH * 0.5 >> 0;
			if (this.x < _centerX) {
				this.x = SchoolCompete.UPLOAD_ITEM_PADDING_H;
			} else {
				if (SchoolCompete.UPLOAD_WIDTH - this.x < SchoolCompete.TIP_WIDTH * 0.5) {
					this.x = SchoolCompete.UPLOAD_WIDTH - SchoolCompete.UPLOAD_ITEM_PADDING_H * 2 - SchoolCompete.TIP_WIDTH;
				} else {
					this.x -= SchoolCompete.TIP_WIDTH - SchoolCompete.UPLOAD_ITEM_WIDTH >> 1;
				}
			}
			_curX -= this.x;
			draw();
		}
		
		private function draw(): void {
			var g: Graphics = this.graphics, r: int = SchoolCompete.TIP_ROUND,
				headW: int = SchoolCompete.TIP_HEAD_WIDTH >> 1, headH: int = SchoolCompete.TIP_HEAD_HEIGHT, 
				w: int = SchoolCompete.TIP_WIDTH, h: int = SchoolCompete.TIP_HEIGHT;
			g.clear();
			g.beginFill(0xFFFFFF, 1);
			g.lineStyle(3, 0x000000, 0.17);
			g.moveTo(_curX, 0);
			g.lineTo(_curX + headW, headH);
			g.lineTo(w - r, headH);
			g.curveTo(w, headH, w, headH + r);
			g.lineTo(w, h - r);
			g.curveTo(w, h, w - r, h);
			g.lineTo(r, h);
			g.curveTo(0.2, h, 0, h - r);
			g.lineTo(-0.2, headH + r);
			g.curveTo(0.2, headH, r, headH);
			g.lineTo(_curX - headW, headH);
			g.lineTo(_curX, 0);
			g.endFill();
		}
	}
}
