// PRUSA iteration3
// Y belt holder
// GNU GPL v3
// Josef Pr?sa <josefprusa@me.com>
// Václav 'ax' H?la <axtheb@gmail.com>
// http://www.reprap.org/wiki/Prusa_Mendel
// http://github.com/prusajr/PrusaMendel

include <configuration.scad>
module i3_belt_clamp() {
	
	difference(){
		union(){
			translate([5, 0, (y_belt_center-(belt_width+1)/2)/2]) cube_fillet([10, 35, y_belt_center-(belt_width+1)/2], center = true, radius=3, $fn=12);
			translate([22.5, 0, (y_belt_center-(belt_width+1)/2)/2]) cube_fillet([45, 14, y_belt_center-(belt_width+1)/2], center = true, radius=3, $fn=12);           
			
			translate([17.5, (14/2-(belt[2]+0.1))/2+(belt[2]+0.1), (belt_width+1)/2 + (y_belt_center-(belt_width+1)/2)]) cube([35, 14/2-(belt[2]+0.1), (belt_width+1)], center = true);
			translate([17.5, -(14/2-(belt[4]+0.05))/2-(belt[4]+0.05), (belt_width+1)/2 + (y_belt_center-(belt_width+1)/2)]) cube([35, 14/2-(belt[4]+0.05), (belt_width+1)], center = true);
			
			translate([0, (belt[2]+0.1)/2, y_belt_center]) {
				for (i = [0 : 35/belt[0]-1+((35%belt[0])/(35%belt[0]+1))]) {
					translate([1+i*belt[0], 0, 0]) cube([belt[0]*belt[1], (belt[2]+0.1), belt_width+1], center = true);
				}
			}
		}
	translate([17.5, (14/2-(belt[2]+0.1))/2+(belt[2]+0.1), (belt_width+1)/2 + (y_belt_center-(belt_width+1)/2)]) cube([belt[3]*3, 14/2+(belt[2]+0.1), belt_width+1], center = true);
	translate([5, -12, (y_belt_center-(belt_width+1)/2)]) rotate([0, 180, 0]) screw_hole(type=y_bearing_screw);
	translate([5, 12, (y_belt_center-(belt_width+1)/2)]) rotate([0, 180, 0]) screw_hole(type=y_bearing_screw);
	translate([40, 0, (y_belt_center-(belt_width+1)/2)]) rotate([0, 180, 0]) screw_hole(type=y_bearing_screw);
	}
}

module i2_belt_clamp() {
	difference(){
		union(){
			translate([0, 0, (y_belt_center-(belt_width+1)/2)/2]) cube_fillet([12, y_belt_clamp_hole_distance+10, y_belt_center-(belt_width+1)/2], center = true, radius=3, $fn=12);
			translate([0, -(y_belt_clamp_hole_distance/2-(belt[4]+0.05)-5)/2-(belt[4]+0.05), (belt_width+1)/2+(y_belt_center-(belt_width+1)/2)]) cube([12, y_belt_clamp_hole_distance/2-(belt[4]+0.05)-5, (belt_width+1)], center = true);
			translate([0, +(y_belt_clamp_hole_distance/2-(belt[4]+0.05)-5)/2+(belt[2]+0.05), (belt_width+1)/2+(y_belt_center-(belt_width+1)/2)]) cube([12, y_belt_clamp_hole_distance/2-(belt[2]+0.05)-5, (belt_width+1)], center = true);
			
			translate([-5, (belt[2]+0.1)/2, (belt_width+1)/2+(y_belt_center-(belt_width+1)/2)]) {
				for (i = [0 : 12/belt[0]-1+((12%belt[0])/(12%belt[0]+1))]) {
					translate([1+i*belt[0], 0, 0]) cube([belt[0]*belt[1], (belt[2]+0.1), (belt_width+1)], center = true);
				}
			}
		}
	translate([(belt_width+1)/2 + (y_belt_center-(belt_width+1)/2), (14/2-(belt[2]+0.1))/2+(belt[2]+0.1), 17.5]) cube([belt_width+1, 14/2+(belt[2]+0.1), belt[3]*3], center = true);
	translate([0, -y_belt_clamp_hole_distance/2, y_belt_center-(belt_width+1)/2]) rotate([0, 180, 0]) screw_hole(type=y_bearing_screw);
	translate([0, y_belt_clamp_hole_distance/2, y_belt_center-(belt_width+1)/2]) rotate([0, 180, 0]) screw_hole(type=y_bearing_screw);
	}
}

i3_belt_clamp();
translate([55, 0, 0]) i2_belt_clamp();

