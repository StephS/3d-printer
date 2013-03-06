include <inc/functions.scad>
include <configuration.scad>

wall_height=extrusion[0];

module z_motor_mount() {
union() {
	// bottom mounting extension
	difference() {
		union() {
			translate([-extrusion[0]/2, -extrusion[0]/2 -support_wall_thickness, motor_mount_thickness/2]) cube_fillet([extrusion[0],extrusion[0]*3,motor_mount_thickness], center = true, vertical = [0, 0, extrusion[0]/2, (extrusion[0]*3 > (extrusion[0]+stepper_motor_padded) ? ((extrusion[0]*3-(extrusion[0]+stepper_motor_padded)) > extrusion[0]/2 ? extrusion[0]/2 : (extrusion[0]*3-(extrusion[0]+stepper_motor_padded))) : 0 )]);
			translate ([stepper_motor_padded/2,-stepper_motor_padded/2-support_wall_thickness,0]) motor_plate(thickness=motor_mount_thickness, width=stepper_motor_padded);
			translate([(z_screw_rod_separation+stepper_motor_padded/2), -support_wall_thickness-stepper_motor_padded/2, motor_mount_thickness/2]) cylinder(r=smooth_rod_diameter/2+4,h=motor_mount_thickness, center = true);
		}
		translate([-extrusion[0]/2, extrusion[0]/2, motor_mount_thickness/2]) cylinder(r=ex_screw_hole_diameter/2,h=motor_mount_thickness+1, center = true);
		translate([-extrusion[0]/2, -support_wall_thickness-extrusion[0]*0.5, motor_mount_thickness/2]) cylinder(r=ex_screw_hole_diameter/2,h=motor_mount_thickness+1, center = true);
		translate([-extrusion[0]/2, -support_wall_thickness-extrusion[0]*1.5, motor_mount_thickness/2]) cylinder(r=ex_screw_hole_diameter/2,h=motor_mount_thickness+1, center = true);
		// because I'm lazy, we cut out again.
		translate ([stepper_motor_padded/2,-stepper_motor_padded/2-support_wall_thickness, motor_mount_thickness/2]) cylinder_poly(r=12,h=motor_mount_thickness+1, center = true);
		// smooth rod hole
		translate([(z_screw_rod_separation+stepper_motor_padded/2), -support_wall_thickness-stepper_motor_padded/2, motor_mount_thickness/2]) cylinder(r=smooth_rod_diameter/2,h=motor_mount_thickness+1, center = true);
		translate([0, 0, (extrusion[0]+motor_mount_thickness)/2]) cylinder(r=1.2, h=extrusion[0]+motor_mount_thickness+1, $fn=8, center=true);
		// alternate mounting
		// translate([-(z_screw_rod_separation-stepper_motor_padded/2), -support_wall_thickness-stepper_motor_padded/2, motor_mount_thickness/2]) cylinder(r=smooth_rod_diameter/2,h=motor_mount_thickness+1, center = true);
	}
	// back wall
	difference() {
		translate([-extrusion[0]/2, extrusion[0]-support_wall_thickness/2, (motor_mount_thickness+wall_height)/2]) cube([extrusion[0],support_wall_thickness,motor_mount_thickness+wall_height], center = true);
		translate([-extrusion[0], extrusion[0]-support_wall_thickness/2, (motor_mount_thickness+wall_height)]) rotate(a=[180,0,180]) chamfer(x=extrusion[0]-support_wall_thickness,z=wall_height);
	}
	// extra support wall
	difference() {
		union() {
			translate ([stepper_motor_padded/2,-support_wall_thickness/2,(motor_mount_thickness+wall_height)/2]) cube([stepper_motor_padded,support_wall_thickness,motor_mount_thickness+wall_height], center = true);
			translate([-extrusion[0]/2, -support_wall_thickness/2, (motor_mount_thickness+wall_height)/2]) cube([extrusion[0],support_wall_thickness,motor_mount_thickness+wall_height], center = true);
			translate([-support_wall_thickness/2, extrusion[0]/2-support_wall_thickness, (motor_mount_thickness+wall_height)/2]) cube([support_wall_thickness,extrusion[0],motor_mount_thickness+wall_height], center = true);
		}
		translate([-support_wall_thickness/2, extrusion[0]/2, motor_mount_thickness+wall_height/2]) rotate(a=[0,90,0]) cylinder(r=ex_screw_hole_diameter/2,h=support_wall_thickness+1, center = true);
		translate([-extrusion[0], -support_wall_thickness/2, (motor_mount_thickness+wall_height)]) rotate(a=[180,0,180]) chamfer(x=extrusion[0]-support_wall_thickness,z=wall_height);
		translate ([stepper_motor_padded,-support_wall_thickness/2,(motor_mount_thickness+wall_height)]) rotate(a=[180,0,0]) chamfer(x=stepper_motor_padded-extrusion[0],z=wall_height);
		translate ([extrusion[0]/2,-support_wall_thickness/2,motor_mount_thickness+wall_height/2]) rotate(a=[90,0,0]) cylinder(r=ex_screw_hole_diameter/2,h=support_wall_thickness+1, center = true);
		translate([0, 0, (extrusion[0]+motor_mount_thickness)/2]) cylinder(r=1.2, h=extrusion[0]+motor_mount_thickness+1, $fn=8, center=true);
	}
}
}

module y_motor_mount() {
	union() {
		translate ([stepper_motor_padded/2+support_wall_thickness+ex_screw_head_height,0,0]) {
			difference() {
				motor_plate(thickness=motor_mount_thickness, width=stepper_motor_padded);
				translate([stepper_motor_padded/2-stepper_motor_padded/4,0,motor_mount_thickness/2+pulley_height_from_motor]) rotate(a=[0,90,0]) rotate(a=[0,0,22.5]) cylinder(r=pulley[4]/2+1,h=stepper_motor_padded/2+1, center = true, $fn=8);
				translate([stepper_motor_padded/2-stepper_motor_padded/4,0,motor_mount_thickness-0.5]) rotate(a=[0,90,0]) rotate(a=[0,0,22.5]) cylinder(r=pulley[4]/2+1,h=stepper_motor_padded/2+1, center = true, $fn=8);
			}
			//pulley
			% translate ([0, 0, pulley_height_from_motor]) belt_pulley();
		}
		difference() {
			translate([(support_wall_thickness+ex_screw_head_height)/2,0,-extrusion[0]/2+motor_mount_thickness/2]) cube([support_wall_thickness+ex_screw_head_height,stepper_motor_padded,motor_mount_thickness+extrusion[0]], center = true);
			translate([(support_wall_thickness+ex_screw_head_height)/2,0,-extrusion[0]/2]) rotate(a=[0,90,0]) cylinder(r=ex_screw_hole_diameter/2,h=support_wall_thickness+ex_screw_head_height+1, center = true);
			translate([support_wall_thickness+(ex_screw_head_height)/2+1,0,-extrusion[0]/2]) rotate(a=[0,90,0]) cylinder(r=ex_screw_head_dia/2,h=ex_screw_head_height+1, center = true);
		}
		difference() {
			translate ([(stepper_motor_padded+support_wall_thickness+ex_screw_head_height)/2,support_wall_thickness/2+stepper_motor_padded/2,-extrusion[0]/2+motor_mount_thickness/2]) cube([stepper_motor_padded+support_wall_thickness+ex_screw_head_height,support_wall_thickness,motor_mount_thickness+extrusion[0]], center = true);
			translate ([stepper_motor_padded+support_wall_thickness+ex_screw_head_height,support_wall_thickness/2+stepper_motor_padded/2,-extrusion[0]]) rotate(a=[0,0,0]) chamfer(x=stepper_motor_padded,z=extrusion[0]);
		}			
		difference() {
			translate ([(stepper_motor_padded+support_wall_thickness+ex_screw_head_height)/2,-support_wall_thickness/2 -stepper_motor_padded/2,-extrusion[0]/2+motor_mount_thickness/2]) cube([stepper_motor_padded+support_wall_thickness+ex_screw_head_height,support_wall_thickness,motor_mount_thickness+extrusion[0]], center = true);
			translate ([stepper_motor_padded+support_wall_thickness+ex_screw_head_height,-support_wall_thickness/2 -stepper_motor_padded/2,-extrusion[0]]) rotate(a=[0,0,0]) chamfer(x=stepper_motor_padded,z=extrusion[0]);
		}
		difference() {
			translate([-extrusion[0]/2, 0, motor_mount_thickness/2]) cube_fillet([extrusion[0],extrusion[0]*2,motor_mount_thickness], center = true, vertical = [0, extrusion[0]/2, extrusion[0]/2, 0]);
			translate([-extrusion[0]/2, -extrusion[0]/2, motor_mount_thickness/2]) cylinder(r=ex_screw_hole_diameter/2,h=motor_mount_thickness+1, center = true);
			translate([-extrusion[0]/2, extrusion[0]/2, motor_mount_thickness/2]) cylinder(r=ex_screw_hole_diameter/2,h=motor_mount_thickness+1, center = true);
		}
	}
}

translate([stepper_motor_padded/2, ((extrusion[0]*2) > stepper_motor_padded ? (extrusion[0]*2) : stepper_motor_padded )/2 + extrusion[0] + support_wall_thickness, motor_mount_thickness]) rotate(a=[0,180,0]) y_motor_mount();

translate([extrusion[0]+2, 0, 0]) z_motor_mount();
translate([-extrusion[0]-2, 0, 0]) mirror([1,0,0]) z_motor_mount();





















