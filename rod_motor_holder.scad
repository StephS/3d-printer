include <inc/functions.scad>
include <configuration.scad>

module motor_plate(thickness=10, width=stepper_motor_width){
    difference(){
        union(){
            // Motor holding part
            difference(){
                union(){
                   nema17(places=[1,1,1,1], h=thickness);
                   translate([0, 0, thickness/2]) cube([width,width,thickness], center = true);
                }

                // motor screw holes
                translate([0, 0, thickness]) {
                    mirror([0,0,1]) translate([0,0,thickness-8])
                        nema17(places=[1,1,1,1], holes=true, h=thickness);
						
                }
					// center hole
					translate ([0, 0, thickness/2]) cylinder_poly(r=12,h=thickness+1, center = true);
            }
				translate([0, 0, -42]) nema17_motor();
        }
    }
}

wall_height=extrusion[0];

module z_motor_mount() {
union() {
	// bottom mounting extension
	difference() {
		union() {
			translate([-extrusion[0]/2, -extrusion[0]/2 -support_wall_thickness, motor_mount_thickness/2]) cube_fillet([extrusion[0],extrusion[0]*3,motor_mount_thickness], center = true, vertical = [0, 0, extrusion[0]/2, 0]);
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
		// alternate mounting
		// translate([-(z_screw_rod_separation-stepper_motor_padded/2), -support_wall_thickness-stepper_motor_padded/2, motor_mount_thickness/2]) cylinder(r=smooth_rod_diameter/2,h=motor_mount_thickness+1, center = true);
	}
	difference() {
		translate([-support_wall_thickness/2, extrusion[0]/2-support_wall_thickness, (motor_mount_thickness+wall_height)/2]) cube([support_wall_thickness,extrusion[0],motor_mount_thickness+wall_height], center = true);
		translate([-support_wall_thickness/2, extrusion[0]/2, motor_mount_thickness+wall_height/2]) rotate(a=[0,90,0]) cylinder(r=ex_screw_hole_diameter/2,h=support_wall_thickness+1, center = true);
	}
	// back wall
	difference() {
		translate([-extrusion[0]/2, extrusion[0]-support_wall_thickness/2, (motor_mount_thickness+wall_height)/2]) cube([extrusion[0],support_wall_thickness,motor_mount_thickness+wall_height], center = true);
		translate([-extrusion[0], extrusion[0]-support_wall_thickness/2, (motor_mount_thickness+wall_height)]) rotate(a=[180,0,180]) chamfer(x=extrusion[0]-support_wall_thickness,z=wall_height);
	}
	// extra support wall
	difference() {
		translate([-extrusion[0]/2, -support_wall_thickness/2, (motor_mount_thickness+wall_height)/2]) cube([extrusion[0],support_wall_thickness,motor_mount_thickness+wall_height], center = true);
		translate([-extrusion[0], -support_wall_thickness/2, (motor_mount_thickness+wall_height)]) rotate(a=[180,0,180]) chamfer(x=extrusion[0]-support_wall_thickness,z=wall_height);
	}
	difference() {
		translate ([stepper_motor_padded/2,-support_wall_thickness/2,(motor_mount_thickness+wall_height)/2]) cube([stepper_motor_padded,support_wall_thickness,motor_mount_thickness+wall_height], center = true);
		translate ([stepper_motor_padded,-support_wall_thickness/2,(motor_mount_thickness+wall_height)]) rotate(a=[180,0,0]) chamfer(x=stepper_motor_padded-extrusion[0],z=wall_height);
		translate ([extrusion[0]/2,-support_wall_thickness/2,motor_mount_thickness+wall_height/2]) rotate(a=[90,0,0]) cylinder(r=ex_screw_hole_diameter/2,h=support_wall_thickness+1, center = true);
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
			translate([(support_wall_thickness+ex_screw_head_height)/2,0,-extrusion[0]/2]) rotate(a=[0,90,0]) cylinder(r=ex_screw_hole_diameter/2,h=support_wall_thickness+ex_screw_head_height, center = true);
			translate([support_wall_thickness+(ex_screw_head_height)/2,0,-extrusion[0]/2]) rotate(a=[0,90,0]) cylinder(r=ex_screw_head_dia/2,h=ex_screw_head_height, center = true);
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

module smooth_rod_mount(height=21) {
	difference() {
		union() {
			translate([0, (-support_wall_thickness-height)/2, 0]) cube([smooth_rod_diameter+support_wall_thickness*2,support_wall_thickness+height,extrusion[0]], center = true);
			translate([0, -support_wall_thickness-height, 0]) cylinder(r=(smooth_rod_diameter/2+support_wall_thickness),h=extrusion[0], center = true);
			translate([0, (-support_wall_thickness)/2, 0]) cube_fillet([smooth_rod_diameter+support_wall_thickness*2+ex_screw_head_dia_padded*2,support_wall_thickness,extrusion[0]], center = true, vertical = [(support_wall_thickness-1)/2, (support_wall_thickness-1)/2, (support_wall_thickness-1)/2, (support_wall_thickness-1)/2], $fn=12);
		}
		translate([0, -support_wall_thickness-height, 0]) cylinder(r=smooth_rod_diameter/2,h=extrusion[0]+1, center = true);
		translate([(ex_screw_head_dia_padded+smooth_rod_diameter+support_wall_thickness*2)/2, (-support_wall_thickness)/2, 0]) rotate(a=[90,0,0]) cylinder(r=ex_screw_hole_diameter/2,h=support_wall_thickness+1, center = true);
		translate([-(ex_screw_head_dia_padded+smooth_rod_diameter+support_wall_thickness*2)/2, (-support_wall_thickness)/2, 0]) rotate(a=[90,0,0]) cylinder(r=ex_screw_hole_diameter/2,h=support_wall_thickness+1, center = true);
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
		translate([- end_x - (extrusion[0])/2, (-support_wall_thickness)/2, 0]) rotate(a=[90,0,0]) cylinder(r=ex_screw_hole_diameter/2,h=support_wall_thickness+1, center = true);
		translate([-(-end_x+ smooth_rod_diameter/2 + support_wall_thickness)/2, extrusion[0]/2, 0]) rotate(a=[0,90,0]) cylinder(r=ex_screw_hole_diameter/2,h=end_x+extrusion[0]+smooth_rod_diameter/2 + support_wall_thickness, center = true);
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
			translate([0, 0, motor_mount_thickness/2]) cube([extrusion[0],ex_screw_head_dia_padded+y_idler_bearing[0],motor_mount_thickness], center = true);
			translate([0, 0, ((pulley[8]+pulley_height_from_motor)-y_idler_bearing[1]/2-y_idler_washer_thickness)/2]) cylinder(r=extrusion[0]/2,h=(pulley[8]+pulley_height_from_motor)-y_idler_bearing[1]/2-y_idler_washer_thickness, center = true);
			translate([0, -y_idler_bearing[0]/2-ex_screw_head_dia_padded/2, motor_mount_thickness/2]) cylinder(r=extrusion[0]/2,h=motor_mount_thickness, center = true);
			translate([0, y_idler_bearing[0]/2+ex_screw_head_dia_padded/2, motor_mount_thickness/2]) cylinder(r=extrusion[0]/2,h=motor_mount_thickness, center = true);
		}		
		translate([0, 0, ((pulley[8]+pulley_height_from_motor)-y_idler_bearing[1]/2-y_idler_washer_thickness)/2]) cylinder(r=ex_screw_hole_diameter/2,h=(pulley[8]+pulley_height_from_motor)-y_idler_bearing[1]/2-y_idler_washer_thickness+1, center = true);
		translate([0, -y_idler_bearing[0]/2-extrusion[0]/2, motor_mount_thickness/2]) cylinder(r=ex_screw_hole_diameter/2,h=motor_mount_thickness+1, center = true);
		translate([0, y_idler_bearing[0]/2+extrusion[0]/2, motor_mount_thickness/2]) cylinder(r=ex_screw_hole_diameter/2,h=motor_mount_thickness+1, center = true);
	}
	% translate([0, 0,(pulley[8]+pulley_height_from_motor)]) y_idler();
}

//y_idler_mount();
//translate([0, 0, motor_mount_thickness]) rotate(a=[0,180,0]) y_motor_mount();

 translate([extrusion[0]+2, 0, 0]) z_motor_mount();
 translate([-extrusion[0]-2, 0, 0]) mirror([1,0,0]) z_motor_mount();

// Y rod mount (print 4)
//translate([0, 0, extrusion[0]/2]) smooth_rod_mount();

// Z rod mounts
//translate([-(smooth_rod_diameter/2 + support_wall_thickness+2), 0, extrusion[0]/2]) z_rod_mount();
//translate([smooth_rod_diameter/2 + support_wall_thickness+2, 0, extrusion[0]/2]) mirror([1,0,0]) z_rod_mount();





















