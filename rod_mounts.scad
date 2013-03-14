include <inc/functions.scad>
include <configuration.scad>

wall_height=extrusion[0];
rod_mount_distance_from_center=screw_head_top_dia(v_screw_hole(ex_screw, $fn=8))+smooth_rod_diameter/2+support_wall_thickness;

module y_rod_mount(height=21) {
	difference() {
		union() {
			translate([0, (-support_wall_thickness-height)/2, 0]) cube([smooth_rod_diameter+support_wall_thickness*2,support_wall_thickness+height,extrusion[0]], center = true);
			translate([0, -support_wall_thickness-height, 0]) cylinder(r=(smooth_rod_diameter/2+support_wall_thickness),h=extrusion[0], center = true);
			translate([0, (-support_wall_thickness)/2, 0]) cube_fillet([rod_mount_distance_from_center*2,support_wall_thickness,extrusion[0]], center = true, vertical = [(support_wall_thickness-1)/2, (support_wall_thickness-1)/2, (support_wall_thickness-1)/2, (support_wall_thickness-1)/2], $fn=12);
		}
		translate([0, -support_wall_thickness-height, 0]) cylinder(r=smooth_rod_diameter/2,h=extrusion[0]+1, center = true);
		translate([(screw_head_top_dia(v_screw_hole(ex_screw, $fn=8))+smooth_rod_diameter+support_wall_thickness*2)/2, (-support_wall_thickness), 0]) rotate(a=[-90,0,0]) screw_hole(type=ex_screw,h=support_wall_thickness+1, $fn=8);
		translate([-(screw_head_top_dia(v_screw_hole(ex_screw, $fn=8))+smooth_rod_diameter+support_wall_thickness*2)/2, (-support_wall_thickness), 0]) rotate(a=[-90,0,0]) screw_hole(type=ex_screw,h=support_wall_thickness+1, $fn=8);
	}
}

module z_rod_mount(height=stepper_motor_padded/2) {
	difference() {
		union() {
			translate([0, (-support_wall_thickness-height)/2, 0]) cube([smooth_rod_diameter+support_wall_thickness*2,support_wall_thickness+height,extrusion[0]], center = true);
			translate([0, -support_wall_thickness-height, 0]) cylinder(r=(smooth_rod_diameter/2+support_wall_thickness),h=extrusion[0], center = true);
			translate([0, (-support_wall_thickness)/2, 0]) cube_fillet([rod_mount_distance_from_center*2,support_wall_thickness,extrusion[0]], center = true, vertical = [(support_wall_thickness-1)/2, (support_wall_thickness-1)/2, (support_wall_thickness-1)/2, (support_wall_thickness-1)/2], $fn=12);
			translate([0, (-height)/2-support_wall_thickness, -extrusion[0]/2+support_wall_thickness/2]) cube([rod_mount_distance_from_center*2-support_wall_thickness,height,support_wall_thickness], center = true);
		}
		translate([0, -support_wall_thickness-height, 0]) cylinder(r=smooth_rod_diameter/2,h=extrusion[0]+1, center = true);
		translate([(screw_head_top_dia(v_screw_hole(ex_screw, $fn=8))+smooth_rod_diameter+support_wall_thickness*2)/2, (-support_wall_thickness), 0]) rotate(a=[-90,0,0]) screw_hole(type=ex_screw,h=support_wall_thickness+1, $fn=8);
		translate([-(screw_head_top_dia(v_screw_hole(ex_screw, $fn=8))+smooth_rod_diameter+support_wall_thickness*2)/2, (-support_wall_thickness), 0]) rotate(a=[-90,0,0]) screw_hole(type=ex_screw,h=support_wall_thickness+1, $fn=8);
		
		translate([-rod_mount_distance_from_center+support_wall_thickness/2,-height-support_wall_thickness,-extrusion[0]/2+support_wall_thickness/2]) rotate(a=[90,0,180]) chamfer(x=rod_mount_distance_from_center-support_wall_thickness/2-support_wall_thickness-smooth_rod_diameter/2, z=height);
		translate([rod_mount_distance_from_center-support_wall_thickness/2,-height-support_wall_thickness,-extrusion[0]/2+support_wall_thickness/2]) rotate(a=[-90,0,0]) chamfer(x=rod_mount_distance_from_center-support_wall_thickness/2-support_wall_thickness-smooth_rod_diameter/2, z=height);
	}
}

module y_idler_mount() {
	difference() {
		union() {
			translate([0, 0, motor_mount_thickness/2]) cube([extrusion[0],screw_head_top_dia(v_screw_hole(ex_screw))+y_idler_bearing[0],motor_mount_thickness], center = true);
			
			//#translate([0, 0, pulley[8]+pulley_height_from_motor-y_idler_bearing[1]/2]) cylinder(r=extrusion[0]/2,h=pulley[8]+pulley_height_from_motor-y_idler_bearing[1], center = true);
			translate([0, 0, motor_mount_thickness]) {
				cylinder(r=extrusion[0]/2,h=((pulley[8] + pulley_height_from_motor)-motor_mount_thickness-y_idler_bearing[1]/2)*0.75);
			
				translate([0, 0, ((pulley[8] + pulley_height_from_motor)-motor_mount_thickness-y_idler_bearing[1]/2)*0.75]) cylinder(r=y_idler_bearing[0]/2.75, h=((pulley[8] + pulley_height_from_motor)-motor_mount_thickness-y_idler_bearing[1]/2)*0.25);
			}
			//echo("pulley height from motor", pulley_height_from_motor);
			//echo("y belt center", y_belt_center-y_idler_bearing[1]/2);
			
			translate([0, -y_idler_bearing[0]/2-screw_head_top_dia(v_screw_hole(ex_screw))/2, motor_mount_thickness/2]) cylinder(r=extrusion[0]/2,h=motor_mount_thickness, center = true);
			translate([0, y_idler_bearing[0]/2+screw_head_top_dia(v_screw_hole(ex_screw))/2, motor_mount_thickness/2]) cylinder(r=extrusion[0]/2,h=motor_mount_thickness, center = true);
		}		
		translate([0, 0, (pulley[8] + pulley_height_from_motor+y_idler_bearing[1]/2)]) rotate([180, 0, 0]) screw_hole(type=ex_screw, h=(pulley[8] + pulley_height_from_motor+y_idler_bearing[1]/2));
		translate([0, -y_idler_bearing[0]/2-extrusion[0]/2, motor_mount_thickness]) rotate([180, 0, 0]) screw_hole(type=ex_screw,h=motor_mount_thickness+1);
		translate([0, y_idler_bearing[0]/2+extrusion[0]/2, motor_mount_thickness]) rotate([180, 0, 0]) screw_hole(type=ex_screw,h=motor_mount_thickness+1);
	}
	//% translate([0, 0, (pulley[8] + pulley_height_from_motor+y_idler_bearing[1]/2)]) rotate([180, 0, 0]) screw(type=ex_screw, h=(pulley[8] + pulley_height_from_motor+y_idler_bearing[1]/2));
	% translate([0, 0,(pulley[8]+pulley_height_from_motor)]) idler(y_idler_bearing, center=true);
	//% translate([0, 0,(pulley[8]+pulley_height_from_motor-y_idler_bearing[1]/2-washer_thickness(y_idler_washer))]) washer(type=y_idler_washer, $fn=0);
}

translate([-rod_mount_distance_from_center-extrusion[0]/2 -4, extrusion[0]/2 + 10 +support_wall_thickness*2, 0]) rotate(a=[0,0,0]) y_idler_mount();

translate([0, 0, extrusion[0]/2]) {
	// Y rod mount (print 4)
	translate([0, 2, 0]) rotate(a=[0,0,180]) y_rod_mount();
	translate([smooth_rod_diameter+support_wall_thickness*2+screw_head_top_dia(v_screw_hole(ex_screw))+4, 10+support_wall_thickness*2, 0]) rotate(a=[0,0,180]) y_rod_mount();


	// Z rod mounts
	translate([-rod_mount_distance_from_center-2, -2, 0]) z_rod_mount();
	translate([rod_mount_distance_from_center+2, -2, 0]) mirror([1,0,0]) z_rod_mount();

}