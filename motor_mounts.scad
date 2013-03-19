include <inc/functions.scad>
include <inc/drivetrain.scad>
include <configuration.scad>

wall_height=extrusion[0];

module z_motor_mount() {
union() {
	// bottom mounting extension
	difference() {
		union() {
			translate([-extrusion[0]/2, -extrusion[0] -support_wall_thickness, motor_mount_thickness/2]) cube_fillet([extrusion[0],extrusion[0]*2,motor_mount_thickness], center = true, vertical = [0, 0, extrusion[0]/2, (extrusion[0]*3 > (extrusion[0]+stepper_motor_padded) ? ((extrusion[0]*3-(extrusion[0]+stepper_motor_padded)) > extrusion[0]/2 ? extrusion[0]/2 : (extrusion[0]*3-(extrusion[0]+stepper_motor_padded))) : 0 )]);
			translate ([stepper_motor_padded/2,-stepper_motor_padded/2-support_wall_thickness,0]) motor_plate(thickness=motor_mount_thickness, width=stepper_motor_padded, head_drop=screw_head_height(screw_M3_socket_head));
			difference() {
				translate([(z_screw_rod_separation+stepper_motor_padded/2), -support_wall_thickness-stepper_motor_padded/2, motor_mount_thickness/2]) cylinder(r=smooth_rod_diameter/2+4,h=motor_mount_thickness, center = true);
				// we cut out for the center
				translate ([stepper_motor_padded/2,-stepper_motor_padded/2-support_wall_thickness, motor_mount_thickness/2]) cylinder_slot(r=11.5,h=motor_mount_thickness+1, center = true);
			}
		}
		translate([-extrusion[0]/2, extrusion[0]/2, motor_mount_thickness]) rotate(a=[180,0,0]) screw_hole(type=ex_screw, h=motor_mount_thickness+1);
		translate([-extrusion[0]/2, -support_wall_thickness-extrusion[0]*0.5, motor_mount_thickness]) rotate(a=[180,0,0]) screw_hole(type=ex_screw, h=motor_mount_thickness+1);
		translate([-extrusion[0]/2, -support_wall_thickness-extrusion[0]*1.5, motor_mount_thickness]) rotate(a=[180,0,0]) screw_hole(type=ex_screw, h=motor_mount_thickness+1);
				
		// smooth rod hole
		translate([(z_screw_rod_separation+stepper_motor_padded/2), -support_wall_thickness-stepper_motor_padded/2, motor_mount_thickness/2]) rod_hole(d=smooth_rod_diameter, h=motor_mount_thickness+1, allowance=0.05, center = true);
		//cylinder_poly(r=hole_fit(dia=smooth_rod_diameter, $fn=poly_sides(smooth_rod_diameter))/2,h=motor_mount_thickness+1, center = true);
		translate([0, 0, (extrusion[0]+motor_mount_thickness)/2]) cylinder(r=1.2, h=extrusion[0]+motor_mount_thickness+1, $fn=8, center=true);
		// alternate mounting
		// translate([-(z_screw_rod_separation-stepper_motor_padded/2), -support_wall_thickness-stepper_motor_padded/2, motor_mount_thickness/2]) cylinder(r=smooth_rod_diameter/2,h=motor_mount_thickness+1, center = true);
	}
	// extra support wall
	difference() {
		union() {
			translate ([stepper_motor_padded/2,-support_wall_thickness/2,(motor_mount_thickness+wall_height)/2]) cube([stepper_motor_padded,support_wall_thickness,motor_mount_thickness+wall_height], center = true);
			
			translate([-extrusion[0]/2, -support_wall_thickness/2, (motor_mount_thickness+wall_height)/2]) cube([extrusion[0],support_wall_thickness,motor_mount_thickness+wall_height], center = true);
			translate([-support_wall_thickness/2, -extrusion[0]/2, (motor_mount_thickness+wall_height)/2]) cube([support_wall_thickness,extrusion[0],motor_mount_thickness+wall_height], center = true);
			translate([-extrusion[0]+support_wall_thickness/2, -extrusion[0]/2, (motor_mount_thickness+wall_height)/2]) cube([support_wall_thickness,extrusion[0],motor_mount_thickness+wall_height], center = true);
		}
		translate ([stepper_motor_padded,-support_wall_thickness/2,(motor_mount_thickness+wall_height)]) rotate(a=[180,0,0]) chamfer(x=stepper_motor_padded,z=wall_height);
		
		translate([-support_wall_thickness/2, -extrusion[0], (motor_mount_thickness+wall_height)]) rotate(a=[180,0,-90]) chamfer(x=extrusion[0]-support_wall_thickness,z=wall_height);
		translate([-extrusion[0]+support_wall_thickness/2, -extrusion[0], (motor_mount_thickness+wall_height)]) rotate(a=[180,0,-90]) chamfer(x=extrusion[0]-support_wall_thickness,z=wall_height);
		translate ([-extrusion[0]/2, -support_wall_thickness,motor_mount_thickness+wall_height/2]) rotate(a=[-90,0,0]) screw_hole(type=ex_screw, h=support_wall_thickness+1, $fn=8);
		//translate([0, 0, (extrusion[0]+motor_mount_thickness)/2]) cylinder(r=1.2, h=extrusion[0]+motor_mount_thickness+1, $fn=8, center=true);
	}
}
}

module y_motor_mount() {
	union() {
		translate ([stepper_motor_padded/2+support_wall_thickness+screw_head_height(v_screw_hole(ex_screw))+1,0,0]) {
			difference() {
				motor_plate(thickness=motor_mount_thickness, width=stepper_motor_padded, slot_length=7, vertical=[5.5,0,0,5.5], hole_support=true);
				translate([stepper_motor_padded/2-stepper_motor_padded/4,0,motor_mount_thickness/2+pulley_height_from_motor]) rotate(a=[0,90,0]) rotate(a=[0,0,22.5]) cylinder(r=pulley[4]/2+1,h=stepper_motor_padded/2+1, center = true, $fn=8);
				translate([stepper_motor_padded/2-stepper_motor_padded/4+3.5,0,motor_mount_thickness-0.5]) rotate(a=[0,90,0]) rotate(a=[0,0,22.5]) cylinder(r=pulley[4]/2+1,h=stepper_motor_padded/2+8, center = true, $fn=8);
			}
			//pulley
			% translate ([0, 0, pulley_height_from_motor]) belt_pulley();
		}
		difference() {
			translate([(support_wall_thickness+screw_head_height(v_screw_hole(ex_screw, $fn=8))+1)/2,0,-extrusion[0]/2+motor_mount_thickness/2]) cube([support_wall_thickness+screw_head_height(v_screw_hole(ex_screw, $fn=8))+1,stepper_motor_padded,motor_mount_thickness+extrusion[0]], center = true);
			
			translate([support_wall_thickness+(screw_head_height(v_screw_hole(ex_screw, $fn=8))+1),0,-extrusion[0]/2]) rotate(a=[0,-90,0]) screw_hole(type=ex_screw,h=support_wall_thickness+1, head_drop=screw_head_height(v_screw_hole(ex_screw, $fn=8))+1, $fn=8);
		}
		difference() {
			translate ([(stepper_motor_padded+support_wall_thickness+screw_head_height(v_screw_hole(ex_screw))+1)/2,support_wall_thickness/2+stepper_motor_padded/2,-extrusion[0]/2+motor_mount_thickness/2]) cube([stepper_motor_padded+support_wall_thickness+screw_head_height(v_screw_hole(ex_screw))+1,support_wall_thickness,motor_mount_thickness+extrusion[0]], center = true);
			translate ([stepper_motor_padded+support_wall_thickness+screw_head_height(v_screw_hole(ex_screw))+1,support_wall_thickness/2+stepper_motor_padded/2,-extrusion[0]]) rotate(a=[0,0,0]) chamfer(x=stepper_motor_padded,z=extrusion[0]);
		}			
		difference() {
			translate ([(stepper_motor_padded+support_wall_thickness+screw_head_height(v_screw_hole(ex_screw))+1)/2,-support_wall_thickness/2 -stepper_motor_padded/2,-extrusion[0]/2+motor_mount_thickness/2]) cube([stepper_motor_padded+support_wall_thickness+screw_head_height(v_screw_hole(ex_screw))+1,support_wall_thickness,motor_mount_thickness+extrusion[0]], center = true);
			translate ([stepper_motor_padded+support_wall_thickness+screw_head_height(v_screw_hole(ex_screw))+1,-support_wall_thickness/2 -stepper_motor_padded/2,-extrusion[0]]) rotate(a=[0,0,0]) chamfer(x=stepper_motor_padded,z=extrusion[0]);
		}
		difference() {
			translate([-extrusion[0]/2, 0, motor_mount_thickness/2]) cube_fillet([extrusion[0],extrusion[0]*2,motor_mount_thickness], center = true, vertical = [0, extrusion[0]/2, extrusion[0]/2, 0]);
			translate([-extrusion[0]/2, -extrusion[0]/2, motor_mount_thickness]) rotate(a=[180,0,0]) screw_hole(type=ex_screw, h=motor_mount_thickness+1);
			translate([-extrusion[0]/2, extrusion[0]/2, motor_mount_thickness]) rotate(a=[180,0,0]) screw_hole(type=ex_screw, h=motor_mount_thickness+1);
		}
	}
}

module z_motor_mount_left() {
	mirror([1,0,0]) z_motor_mount();
}

module print_y_motor_mount() {
	translate ([0,0, motor_mount_thickness]) rotate(a=[0,180,0]) y_motor_mount();
}

translate([stepper_motor_padded/2, ((extrusion[0]*2) > stepper_motor_padded ? (extrusion[0]*2) : stepper_motor_padded )/2 + support_wall_thickness, 0]) print_y_motor_mount();

translate([extrusion[0]+2, 0, 0]) z_motor_mount();
translate([-extrusion[0]-2, 0, 0]) z_motor_mount_left();


















