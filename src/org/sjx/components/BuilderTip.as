package org.sjx.components {
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import org.sjx.utils.TextFormats;
	
	public class BuilderTip extends Sprite {
		
		private var labes: Array;
		
		public function BuilderTip() {
			labes = [];
		}
		
		public function update(txts: Array): void {
			for (var i: int = 0, lab: TextField; lab = labes[i]; i ++) {
				this.removeChild(lab);
			}
			labes = [];
			var w: int = -(SchoolCompete.BUILDER_TIP_WIDTH >> 1),
				y: int = SchoolCompete.BUILDER_TIP_HEAD_HEIGHT + SchoolCompete.BUILDER_TIP_ROUND;
			for (var i: int = txts.length, s: String; i > 0; i --) {
				s = txts[txts.length - i];
				var lab: TextField = new TextField();
				lab.x = w;
				lab.y = -(y + i * SchoolCompete.BUILDER_TIP_ROW_HEIGHT);
				lab.width = SchoolCompete.BUILDER_TIP_WIDTH;
				lab.height = SchoolCompete.BUILDER_TIP_ROW_HEIGHT;
				lab.text = s;
				lab.setTextFormat(TextFormats.BUILDER_ERROR_FORMAT);
				addChild(lab);
				labes.push(lab);
			}
			_draw(txts);
		}
		
		private function _draw(txts: Array): void {
			var g: Graphics = this.graphics, r: int = SchoolCompete.BUILDER_TIP_ROUND,
				headW: int = SchoolCompete.BUILDER_TIP_HEAD_WIDTH >> 1, 
				headH: int = SchoolCompete.BUILDER_TIP_HEAD_HEIGHT, 
				w: int = SchoolCompete.BUILDER_TIP_WIDTH >> 1, wm: int = w + r,
				hm: int = txts.length * SchoolCompete.BUILDER_TIP_ROW_HEIGHT + r * 2;
trace ('headW : ' + headW + ' , headH : ' + headH + ' , r : ' + r + ' , w : ' + w + ' , wm : ' + wm + ' , hm : ' + hm);			
			g.clear();
			g.beginFill(0xFFFFFF, 1);
			g.lineStyle(3, 0x000000, 0.17);
			g.moveTo(0, 0);
			g.lineTo(headW, -headH);
			g.lineTo(w, -headH);
			g.curveTo(wm, -headH, wm, -(headH + r));
			g.lineTo(wm, -(headH + hm - r));
			g.curveTo(wm, -(headH + hm), w, -(headH + hm));
			g.lineTo(-w, -(headH + hm));
			g.curveTo(-wm, -(headH + hm), -wm, -(headH + hm - r));
			g.lineTo(-wm, -(headH + r));
			g.curveTo(-wm, -headH, -w, -headH);
			g.lineTo(-headW, -headH);
			g.lineTo(0, 0);
			g.endFill();
		}
	}
}