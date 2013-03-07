include <inc/functions.scad>
include <configuration.scad>

wall_height=extrusion[0];

module y_rod_mount(height=21) {
	difference() {
		union() {
			translate([0, (-support_wall_thickness-height)/2, 0]) cube([smooth_rod_diameter+support_wall_thickness*2,support_wall_thickness+height,extrusion[0]], center = true);
			translate([0, -support_wall_thickness-height, 0]) cylinder(r=(smooth_rod_diameter/2+support_wall_thickness),h=extrusion[0], center = true);
			translate([0, (-support_wall_thickness)/2, 0]) cube_fillet([smooth_rod_diameter+support_wall_thickness*2+screw_head_top_dia(v_screw_hole(ex_screw))*2,support_wall_thickness,extrusion[0]], center = true, vertical = [(support_wall_thickness-1)/2, (support_wall_thickness-1)/2, (support_wall_thickness-1)/2, (support_wall_thickness-1)/2], $fn=12);
		}
		translate([0, -support_wall_thickness-height, 0]) cylinder(r=smooth_rod_diameter/2,h=extrusion[0]+1, center = true);
		translate([(screw_head_top_dia(v_screw_hole(ex_screw))+smooth_rod_diameter+support_wall_thickness*2)/2, (-support_wall_thickness), 0]) rotate(a=[-90,0,0]) screw_hole(type=ex_screw,h=support_wall_thickness+1, $fn=8);
		translate([-(screw_head_top_dia(v_screw_hole(ex_screw))+smooth_rod_diameter+support_wall_thickness*2)/2, (-support_wall_thickness), 0]) rotate(a=[-90,0,0]) screw_hole(type=ex_screw,h=support_wall_thickness+1, $fn=8);
	}
}

end_x=(stepper_motor_padded/2 + z_screw_rod_separation - extrusion[0]);
xtest= -end_x - extrusion[0];
module z_rod_mount(height=stepper_motor_padded/2) {
	difference() {
		union() {
			translate([0, (-support_wall_thickness-height)/2, 0]) cube([smooth_rod_diameter+support_wall_thickness*2,support_wall_thickness+height,extrusion[0]], center = true);
			translate([0, -support_wall_thickness-height, 0]) cylinder(r=smooth_rod_diameter/2 + support_wall_thickness,h=extrusion[0], center = true);
			translate([(-end_x+ smooth_rod_diameter/2 + support_wall_thickness)/2 -extrusion[0]/2, (-support_wall_thickness)/2, 0]) cube_fillet([end_x+extrusion[0]+smooth_rod_diameter/2 + support_wall_thickness,support_wall_thickness,extrusion[0]], center = true, vertical = [ 0, (support_wall_thickness-1)/2, 0, 0], $fn=12);
			
			translate([(-end_x+ smooth_rod_diameter/2 + support_wall_thickness)/2,extrusion[0]/2,0]) cube_fillet([end_x + smooth_rod_diameter/2 + support_wall_thickness,extrusion[0],extrusion[0]], center=true, vertical = [ (support_wall_thickness-1)/2, (support_wall_thickness-1)/2, 0, 0], $fn=12);
			translate([-((end_x + extrusion[0]) - (support_wall_thickness + smooth_rod_diameter/2))/2 - smooth_rod_diameter/2 - support_wall_thickness, -(height)/2 -support_wall_thickness,support_wall_thickness/2-extrusion[0]/2]) cube([((end_x + extrusion[0]) -(support_wall_thickness + smooth_rod_diameter/2)),height,support_wall_thickness], center = true);
		}
		translate([0, -support_wall_thickness-height, 0]) cylinder(r=smooth_rod_diameter/2,h=extrusion[0]+1, center = true);
		translate([- end_x - (extrusion[0])/2, (-support_wall_thickness), 0]) rotate(a=[-90,0,0]) screw_hole(type=ex_screw,h=support_wall_thickness+1, $fn=8);
		translate([-end_x, 0, 0]) cylinder(r=1.2, h=extrusion[0]+1, $fn=8, center=true);
		
		translate([(smooth_rod_diameter/2 + support_wall_thickness), extrusion[0]/2, 0]) rotate(a=[0,-90,0]) screw_hole(type=ex_screw, h=end_x+smooth_rod_diameter/2 + support_wall_thickness+1, $fn=8);
		translate([-((end_x + extrusion[0]) - (support_wall_thickness + smooth_rod_diameter/2)) - smooth_rod_diameter/2 - support_wall_thickness, -(height) -support_wall_thickness,support_wall_thickness/2-extrusion[0]/2]) rotate(a=[90,0,180]) chamfer(x=((end_x + extrusion[0]) -(support_wall_thickness + smooth_rod_diameter/2)),z=height);
	}
}

module y_idler() {
	difference(){
		cylinder(r=y_idler_bearing[0]/2,h=y_idler_bearing[1], center = true);
		cylinder(r=y_idler_bearing[2]/2,h=y_idler_bearing[1]+1, center = true);
	}
	
}

module y_idler_mount() {
	difference() {
		union() {
			translate([0, 0, motor_mount_thickness/2]) cube([extrusion[0],screw_head_top_dia(v_screw_hole(ex_screw))+y_idler_bearing[0],motor_mount_thickness], center = true);
			translate([0, 0, ((pulley[8]+pulley_height_from_motor)-y_idler_bearing[1]/2-y_idler_washer_thickness)/2]) cylinder(r=extrusion[0]/2,h=(pulley[8]+pulley_height_from_motor)-y_idler_bearing[1]/2-y_idler_washer_thickness, center = true);
			translate([0, -y_idler_bearing[0]/2-screw_head_top_dia(v_screw_hole(ex_screw))/2, motor_mount_thickness/2]) cylinder(r=extrusion[0]/2,h=motor_mount_thickness, center = true);
			translate([0, y_idler_bearing[0]/2+screw_head_top_dia(v_screw_hole(ex_screw))/2, motor_mount_thickness/2]) cylinder(r=extrusion[0]/2,h=motor_mount_thickness, center = true);
		}		
		translate([0, 0, ((pulley[8]+pulley_height_from_motor)-y_idler_bearing[1]/2-y_idler_washer_thickness)]) rotate([180, 0, 0]) screw_hole(type=ex_screw, h=(pulley[8]+pulley_height_from_motor)-y_idler_bearing[1]/2-y_idler_washer_thickness+1);
		translate([0, -y_idler_bearing[0]/2-extrusion[0]/2, motor_mount_thickness]) rotate([180, 0, 0]) screw_hole(type=ex_screw,h=motor_mount_thickness+1);
		translate([0, y_idler_bearing[0]/2+extrusion[0]/2, motor_mount_thickness]) rotate([180, 0, 0]) screw_hole(type=ex_screw,h=motor_mount_thickness+1);
	}
	% translate([0, 0,(pulley[8]+pulley_height_from_motor)]) y_idler();
}

translate([-(screw_head_top_dia(v_screw_hole(ex_screw))+y_idler_bearing[0]+extrusion[0])/2 -smooth_rod_diameter/2-support_wall_thickness -4, extrusion[0]/2 + 10 +support_wall_thickness*2, 0]) rotate(a=[0,0,90]) y_idler_mount();

// Y rod mount (print 4)
translate([0, 2, extrusion[0]/2]) rotate(a=[0,0,180]) y_rod_mount();
translate([((smooth_rod_diameter+support_wall_thickness*2+screw_head_top_dia(v_screw_hole(ex_screw))) > (end_x  + smooth_rod_diameter + support_wall_thickness*2+2) ? (smooth_rod_diameter+support_wall_thickness*2+screw_head_top_dia(v_screw_hole(ex_screw))) : (end_x  + smooth_rod_diameter + support_wall_thickness*2+2)) + 4, 6+support_wall_thickness*2, extrusion[0]/2]) y_rod_mount();
translate([-(((smooth_rod_diameter+support_wall_thickness*2+screw_head_top_dia(v_screw_hole(ex_screw))) > (end_x  + smooth_rod_diameter + support_wall_thickness*2+2) ? (smooth_rod_diameter+support_wall_thickness*2+screw_head_top_dia(v_screw_hole(ex_screw))) : (end_x  + smooth_rod_diameter + support_wall_thickness*2+2)) + 4), 6+support_wall_thickness*2, extrusion[0]/2]) y_rod_mount();
translate([smooth_rod_diameter+support_wall_thickness*2+screw_head_top_dia(v_screw_hole(ex_screw))+4, 10+support_wall_thickness*2, extrusion[0]/2]) rotate(a=[0,0,180]) y_rod_mount();


// Z rod mounts
translate([-(smooth_rod_diameter/2 + support_wall_thickness+2), -extrusion[0]-2, extrusion[0]/2]) z_rod_mount();
translate([smooth_rod_diameter/2 + support_wall_thickness+2, -extrusion[0]-2, extrusion[0]/2]) mirror([1,0,0]) z_rod_mount();
