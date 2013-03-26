include <configuration.scad>
use <extrusion.scad>

ex_allowance=0.3;
ex_corner_square_width = (extrusion[0]-extrusion[2])/2;
ex_wall_width=(extrusion[0]-extrusion[1])/2;

module ex_clip_base(length=extrusion[0]){
	translate([0,0,((extrusion[0]-extrusion[4])/2-extrusion[3]-ex_allowance)/2]) difference() {
		union() {
			cube([length,extrusion[0]-ex_corner_square_width*2-ex_allowance,(extrusion[0]-extrusion[4])/2-extrusion[3]-ex_allowance], center=true);
			translate([0,0,((extrusion[0]-extrusion[4])/2-extrusion[3]-ex_allowance)/2+extrusion[3]/2]) cube([length,extrusion[0]-ex_wall_width*2-ex_allowance,extrusion[3]+0.01], center=true);
		}
		
		translate([0,0,-(extrusion[4]/2+(extrusion[0]-extrusion[4])/4-extrusion[3]/2)])
			rotate([0,90,0]) {
				rotate([0, 0, 45]) translate([(extrusion[3]+4)/2-extrusion[3]/2-ex_allowance,0,0]) cube([extrusion[3]+4,(extrusion[0]-(sin(45)*extrusion[3]))/cos(45),length+0.02], center = true);
				rotate([0, 0, -45]) translate([(extrusion[3]+4)/2-extrusion[3]/2-ex_allowance,0,0]) cube([extrusion[3]+4,(extrusion[0]-(sin(45)*extrusion[3]))/cos(45),length+0.02], center = true);
			}

	}
}
//%translate([0,0,-(extrusion[4]/2+(extrusion[0]-extrusion[4])/4-extrusion[3]/2)]) rotate([0,90,0]) extrusion(length= extrusion[0]);
module ex_end_clip() {
	difference() {
		union() {
			ex_clip_base(length=extrusion[0]);
			translate([(extrusion[0]+ex_allowance)/2-(extrusion[0]-extrusion[4])/4,0,(extrusion[0]-extrusion[4])/1.5]) cube_fillet ([(extrusion[0]-extrusion[4])/2-ex_allowance,extrusion[0]-ex_wall_width*2-ex_allowance,(extrusion[0]-extrusion[4])/2],vertical=[0,2,2,0], top=[2,2,2,0], center=true);
			translate([-(extrusion[0]+ex_allowance)/2+(extrusion[0]-extrusion[4])/4,0,(extrusion[0]-extrusion[4])/1.5]) cube_fillet ([(extrusion[0]-extrusion[4])/2-ex_allowance,extrusion[0]-ex_wall_width*2-ex_allowance,(extrusion[0]-extrusion[4])/2],vertical=[2,0,0,2], top=[2,0,2,2], center=true);
		}
		screw_hole(type=ex_screw,head_drop=((extrusion[0]-extrusion[4])/2-extrusion[3]-ex_allowance)+0.02, h=extrusion[0], hole_support=true, $fn=12);
	}
}

module ex_nut_clip() {
	difference() {
		union() {
			ex_clip_base(length=extrusion[0]);
		}
		translate([0,0,-0.01]) nut_hole(type=ex_nut, h=((extrusion[0]-extrusion[4])/2-extrusion[3]-ex_allowance)+0.02);
		translate([0,0,((extrusion[0]-extrusion[4])/2-extrusion[3]-ex_allowance)+layer_height+0.01]) rod_hole(d=nut_dia(ex_nut), h=extrusion[0]);
		//#screw_hole(type=ex_screw,head_drop=((extrusion[0]-extrusion[4])/2-extrusion[3]-ex_allowance)+0.01, h=extrusion[0], hole_support=true, $fn=12);
	}
}

module ex_drill_guide() {
	difference() {
		union() {
			translate([extrusion[0]/4-extrusion[4]/4,0,0]) ex_clip_base(length=extrusion[0]/2+extrusion[4]/2+0.02);
			translate([extrusion[0]/4-extrusion[4]/4,0,extrusion[0]/4+ex_allowance]) cube([extrusion[0]/2+extrusion[4]/2+0.02,extrusion[0]-ex_wall_width*2-ex_allowance,extrusion[0]/2-ex_allowance],center=true);
			translate([extrusion[0]/2,-extrusion[0]/2,0]) cube([3,extrusion[0],extrusion[0]/2]);
		}
		translate([0,0,-0.01]) rod_hole(d=screw_dia(ex_screw)*0.9, h=extrusion[0]);
		//#screw_hole(type=ex_screw,head_drop=((extrusion[0]-extrusion[4])/2-extrusion[3]-ex_allowance)+0.01, h=extrusion[0], hole_support=true, $fn=12);
	}
}

ex_end_clip();

translate([0,extrusion[0]-extrusion[4],0]) ex_nut_clip();
translate([0,-(extrusion[0]),0]) ex_drill_guide();