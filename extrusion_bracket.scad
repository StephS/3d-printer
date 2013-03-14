include <inc/functions.scad>
include <configuration.scad>

module corner_bracket(length=2) {
	difference() {
		union () {
			translate([0, -extrusion[0]/2, 0]) cube([extrusion[0]*length+support_wall_thickness,extrusion[0],support_wall_thickness]);
			translate([0, -extrusion[0]/2, 0]) cube([support_wall_thickness, extrusion[0], extrusion[0]*length+support_wall_thickness]);
			translate([support_wall_thickness, -extrusion[0]/2, 0]) cube([extrusion[0]*length, support_wall_thickness, extrusion[0]*length+support_wall_thickness]);
			translate([support_wall_thickness, extrusion[0]/2-support_wall_thickness, 0]) cube([extrusion[0]*length, support_wall_thickness, extrusion[0]*length+support_wall_thickness]);
		}
		translate([support_wall_thickness, 0, support_wall_thickness]) {
			translate([extrusion[0]*length, extrusion[0]/2-support_wall_thickness/2, extrusion[0]*length]) rotate(a=[180,0,0]) chamfer(x=extrusion[0]*length,z=extrusion[0]*length);
			translate([extrusion[0]*length, -extrusion[0]/2+support_wall_thickness/2, extrusion[0]*length]) rotate(a=[180,0,0]) chamfer(x=extrusion[0]*length,z=extrusion[0]*length);
			
			for (i = [0 : length-1]) {
				translate([extrusion[0]/2+extrusion[0]*i, 0, 0]) rotate(a=[180,0,0]) screw_hole(type=ex_screw, h=support_wall_thickness+1, $fn=8);
				translate([0, 0, extrusion[0]/2+extrusion[0]*i]) rotate(a=[0,-90,0]) screw_hole(type=ex_screw, h=support_wall_thickness+1, $fn=8);
			}
		}
		rotate(a=[90, 0, 0]) cylinder(h=extrusion[0]+2, r=1, $fn=4, center=true);
	}
}

module top_brace_bracket() {
	difference() {
		union () {
			translate([0, 0, 0]) cube([extrusion[0]+support_wall_thickness, extrusion[0]*2, support_wall_thickness]);
			translate([-extrusion[0], 0, 0]) cube_fillet([extrusion[0], extrusion[0]*2, support_wall_thickness], vertical = [ 0, extrusion[0]/2, extrusion[0]/2, 0]);
			translate([support_wall_thickness, extrusion[0]*2-extrusion[0]/sin(45), 0]) rotate(a=[0,0,-45]) cube_fillet([extrusion[0]*2, extrusion[0], support_wall_thickness], vertical = [extrusion[0]/2, 0, 0, extrusion[0]/2]);
		}
		translate([support_wall_thickness, 0, 0]) {
			translate([extrusion[0], extrusion[0]*2, support_wall_thickness/2]) rotate(a=[90,0,0]) chamfer(x=extrusion[0],z=extrusion[0]);
			translate([0, extrusion[0]*2-extrusion[0]/sin(45), 0]) rotate(a=[0,0,-45]) {
				translate([ extrusion[0]/2, extrusion[0]/2, 0]) screw_hole(type=ex_screw, h=support_wall_thickness+1);
				translate([ extrusion[0]+extrusion[0]/2, extrusion[0]/2, 0]) screw_hole(type=ex_screw, h=support_wall_thickness+1);
			}
		}
		translate([ -extrusion[0]/2, extrusion[0]/2, 0]) {
			screw_hole(type=ex_screw, h=support_wall_thickness+1);
			translate([ 0, extrusion[0], 0]) screw_hole(type=ex_screw, h=support_wall_thickness+1);
		}
	}
}

module print_corner_bracket(length=2) {
	rotate(a=[0,45+90,0]) translate([-(extrusion[0]*length/2+support_wall_thickness), 0, -(extrusion[0]*length/2+support_wall_thickness)]) corner_bracket(length=length);	
}
//translate([0, 0, sin(45)*(extrusion[0]*2+support_wall_thickness*2)]) rotate(a=[0,45+90,0]) corner_bracket();

translate([0,-extrusion[0]/2-4, 0]) print_corner_bracket(length=2);
//bottom_brace_bracket();
translate([-4,extrusion[0], 0]) rotate(a=[0,0,90]) top_brace_bracket();

//rotate(a=[90,0,0]) 
//mirror([0, 0, 1]) rotate(a=[0,90,0]) top_brace_bracket();
//rotate(a=[0,0,90]) bottom_brace_bracket();