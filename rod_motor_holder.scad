include <functions.scad>
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

module nema17(places=[1,1,1,1], size=15.5, h=10, holes=false, $fn=24){
    for (i=[0:3]) {
        if (places[i] == 1) {
            rotate([0, 0, 90*i]) translate([size, size, 0]) {
                if (holes) {
                    #rotate([0, 0, -90*i])  translate([0,0,-10]) screw(r=1.7, slant=false, head_drop=13, $fn=$fn, h=h+13);
                } else {
                    rotate([0, 0, -90*i]) cylinder(h=h, r=5.5, $fn=$fn);
                }
            }
        }
    }
}

module nema17_motor(height=42, color=true) {
		union() {
        % translate ([0, 0, height/2]) cube([42,42,height], center = true);
    //flange
        % translate ([0, 0, height+1]) cylinder(r=11,h=2, center = true, $fn=20);
    //shaft
        % translate ([0, 0, height+7]) cylinder(r=2.5,h=14, center = true);
		}
}

module belt_pulley()
{
	difference() {
		union() {
			translate ([0, 0, pulley_hub_height/2]) cylinder(r=pulley_hub_diameter/2,h=pulley_hub_height, center = true);
			translate ([0, 0, (pulley_height-pulley_hub_height-pulley_belt_height)/2/2+pulley_hub_height]) cylinder(r=pulley_outer_diameter/2,h=(pulley_height-pulley_hub_height-pulley_belt_height)/2, center = true);
			translate ([0, 0, pulley_hub_height+(pulley_height-pulley_hub_height-pulley_belt_height)/2+pulley_belt_height/2]) cylinder(r=pulley_diameter/2,h=pulley_belt_height, center = true);
			translate ([0, 0, pulley_hub_height+(pulley_height-pulley_hub_height-pulley_belt_height)/2+pulley_belt_height+(pulley_height-pulley_hub_height-pulley_belt_height)/2/2]) cylinder(r=pulley_outer_diameter/2,h=(pulley_height-pulley_hub_height-pulley_belt_height)/2, center = true);
		}
		translate ([0, 0, pulley_height/2]) cylinder(r=2.5,h=pulley_height+1, center = true);
	}
}

module chamfer(x=10,y=10,z=10) {
 
 rotate(a=[90,-90,0])
 linear_extrude(height = y, center = true, convexity = 2, twist = 0)
 polygon(points = [
[-1.00,-1.00]
,[-1.00,x]
,[0.00,x]
,[z,0.00]
,[z,-1.00]
]
,paths = [
[0,1,2,3,4]]
       );
}

wall_height=extrusion_width;

module z_motor_mount() {
union() {
	// bottom mounting extension
	difference() {
		union() {
			translate([-extrusion_width/2, -extrusion_width/2 -support_wall_thickness, motor_mount_thickness/2]) cube([extrusion_width,extrusion_width*3,motor_mount_thickness], center = true);
			translate ([stepper_motor_padded/2,-stepper_motor_padded/2-support_wall_thickness,0]) motor_plate(thickness=motor_mount_thickness, width=stepper_motor_padded);
			translate([(z_screw_rod_separation+stepper_motor_padded/2), -support_wall_thickness-stepper_motor_padded/2, motor_mount_thickness/2]) cylinder(r=smooth_rod_diameter/2+4,h=motor_mount_thickness, center = true);
		}
		translate([-extrusion_width/2, extrusion_width/2, motor_mount_thickness/2]) cylinder(r=ex_screw_hole_diameter/2,h=motor_mount_thickness+1, center = true);
		translate([-extrusion_width/2, -support_wall_thickness-extrusion_width*0.5, motor_mount_thickness/2]) cylinder(r=ex_screw_hole_diameter/2,h=motor_mount_thickness+1, center = true);
		translate([-extrusion_width/2, -support_wall_thickness-extrusion_width*1.5, motor_mount_thickness/2]) cylinder(r=ex_screw_hole_diameter/2,h=motor_mount_thickness+1, center = true);
		// because I'm lazy, we cut out again.
		translate ([stepper_motor_padded/2,-stepper_motor_padded/2-support_wall_thickness, motor_mount_thickness/2]) cylinder_poly(r=12,h=motor_mount_thickness+1, center = true);
		// smooth rod hole
		translate([(z_screw_rod_separation+stepper_motor_padded/2), -support_wall_thickness-stepper_motor_padded/2, motor_mount_thickness/2]) cylinder(r=smooth_rod_diameter/2,h=motor_mount_thickness+1, center = true);
		// alternate mounting
		// translate([-(z_screw_rod_separation-stepper_motor_padded/2), -support_wall_thickness-stepper_motor_padded/2, motor_mount_thickness/2]) cylinder(r=smooth_rod_diameter/2,h=motor_mount_thickness+1, center = true);
	}
	difference() {
		translate([-support_wall_thickness/2, extrusion_width/2-support_wall_thickness, (motor_mount_thickness+wall_height)/2]) cube([support_wall_thickness,extrusion_width,motor_mount_thickness+wall_height], center = true);
		translate([-support_wall_thickness/2, extrusion_width/2, motor_mount_thickness+wall_height/2]) rotate(a=[0,90,0]) cylinder(r=ex_screw_hole_diameter/2,h=support_wall_thickness+1, center = true);
	}
	// back wall
	difference() {
		translate([-extrusion_width/2, extrusion_width-support_wall_thickness/2, (motor_mount_thickness+wall_height)/2]) cube([extrusion_width,support_wall_thickness,motor_mount_thickness+wall_height], center = true);
		translate([-extrusion_width, extrusion_width-support_wall_thickness/2, (motor_mount_thickness+wall_height)]) rotate(a=[180,0,180]) chamfer(x=extrusion_width-support_wall_thickness,z=wall_height);
	}
	// extra support wall
	difference() {
		translate([-extrusion_width/2, -support_wall_thickness/2, (motor_mount_thickness+wall_height)/2]) cube([extrusion_width,support_wall_thickness,motor_mount_thickness+wall_height], center = true);
		translate([-extrusion_width, -support_wall_thickness/2, (motor_mount_thickness+wall_height)]) rotate(a=[180,0,180]) chamfer(x=extrusion_width-support_wall_thickness,z=wall_height);
	}
	difference() {
		translate ([stepper_motor_padded/2,-support_wall_thickness/2,(motor_mount_thickness+wall_height)/2]) cube([stepper_motor_padded,support_wall_thickness,motor_mount_thickness+wall_height], center = true);
		translate ([stepper_motor_padded,-support_wall_thickness/2,(motor_mount_thickness+wall_height)]) rotate(a=[180,0,0]) chamfer(x=stepper_motor_padded-extrusion_width,z=wall_height);
		translate ([extrusion_width/2,-support_wall_thickness/2,motor_mount_thickness+wall_height/2]) rotate(a=[90,0,0]) cylinder(r=ex_screw_hole_diameter/2,h=support_wall_thickness+1, center = true);
	}
}
}

module y_motor_mount() {
	union() {
		translate ([stepper_motor_padded/2+support_wall_thickness+ex_screw_head_height,0,0]) {
			difference() {
				motor_plate(thickness=motor_mount_thickness, width=stepper_motor_padded);
				translate([stepper_motor_padded/2-stepper_motor_padded/4,0,motor_mount_thickness/2+pulley_height_from_motor]) rotate(a=[0,90,0]) rotate(a=[0,0,22.5]) cylinder(r=pulley_setscrew_diameter/2,h=stepper_motor_padded/2+1, center = true, $fn=8);
				translate([stepper_motor_padded/2-stepper_motor_padded/4,0,motor_mount_thickness-0.5]) rotate(a=[0,90,0]) rotate(a=[0,0,22.5]) cylinder(r=pulley_setscrew_diameter/2,h=stepper_motor_padded/2+1, center = true, $fn=8);
			}
			//pulley
			% translate ([0, 0, pulley_height_from_motor]) belt_pulley();
		}
		difference() {
			translate([(support_wall_thickness+ex_screw_head_height)/2,0,-extrusion_width/2+motor_mount_thickness/2]) cube([support_wall_thickness+ex_screw_head_height,stepper_motor_padded,motor_mount_thickness+extrusion_width], center = true);
			translate([(support_wall_thickness+ex_screw_head_height)/2,0,-extrusion_width/2]) rotate(a=[0,90,0]) cylinder(r=ex_screw_hole_diameter/2,h=support_wall_thickness+ex_screw_head_height, center = true);
			translate([support_wall_thickness+(ex_screw_head_height)/2,0,-extrusion_width/2]) rotate(a=[0,90,0]) cylinder(r=ex_screw_head_dia/2,h=ex_screw_head_height, center = true);
		}
		difference() {
			translate ([(stepper_motor_padded+support_wall_thickness+ex_screw_head_height)/2,support_wall_thickness/2+stepper_motor_padded/2,-extrusion_width/2+motor_mount_thickness/2]) cube([stepper_motor_padded+support_wall_thickness+ex_screw_head_height,support_wall_thickness,motor_mount_thickness+extrusion_width], center = true);
			translate ([stepper_motor_padded+support_wall_thickness+ex_screw_head_height,support_wall_thickness/2+stepper_motor_padded/2,-extrusion_width]) rotate(a=[0,0,0]) chamfer(x=stepper_motor_padded,z=extrusion_width);
		}			
		difference() {
			translate ([(stepper_motor_padded+support_wall_thickness+ex_screw_head_height)/2,-support_wall_thickness/2 -stepper_motor_padded/2,-extrusion_width/2+motor_mount_thickness/2]) cube([stepper_motor_padded+support_wall_thickness+ex_screw_head_height,support_wall_thickness,motor_mount_thickness+extrusion_width], center = true);
			translate ([stepper_motor_padded+support_wall_thickness+ex_screw_head_height,-support_wall_thickness/2 -stepper_motor_padded/2,-extrusion_width]) rotate(a=[0,0,0]) chamfer(x=stepper_motor_padded,z=extrusion_width);
		}
		difference() {
			translate([-extrusion_width/2, 0, motor_mount_thickness/2]) cube([extrusion_width,extrusion_width*2,motor_mount_thickness], center = true);
			translate([-extrusion_width/2, -extrusion_width/2, motor_mount_thickness/2]) cylinder(r=ex_screw_hole_diameter/2,h=motor_mount_thickness+1, center = true);
			translate([-extrusion_width/2, extrusion_width/2, motor_mount_thickness/2]) cylinder(r=ex_screw_hole_diameter/2,h=motor_mount_thickness+1, center = true);
		}
	}
}

module smooth_rod_mount(height=21) {
	difference() {
		union() {
			translate([0, (-support_wall_thickness-height)/2, 0]) cube([smooth_rod_diameter+support_wall_thickness*2,support_wall_thickness+height,extrusion_width], center = true);
			translate([0, -support_wall_thickness-height, 0]) cylinder(r=(smooth_rod_diameter/2+support_wall_thickness),h=extrusion_width, center = true);
			translate([0, (-support_wall_thickness)/2, 0]) cube([smooth_rod_diameter+support_wall_thickness*2+ex_screw_head_dia_padded*2,support_wall_thickness,extrusion_width], center = true);
		}
		translate([0, -support_wall_thickness-height, 0]) cylinder(r=smooth_rod_diameter/2,h=extrusion_width+1, center = true);
		translate([(ex_screw_head_dia_padded+smooth_rod_diameter+support_wall_thickness*2)/2, (-support_wall_thickness)/2, 0]) rotate(a=[90,0,0]) cylinder(r=ex_screw_hole_diameter/2,h=support_wall_thickness+1, center = true);
		translate([-(ex_screw_head_dia_padded+smooth_rod_diameter+support_wall_thickness*2)/2, (-support_wall_thickness)/2, 0]) rotate(a=[90,0,0]) cylinder(r=ex_screw_hole_diameter/2,h=support_wall_thickness+1, center = true);
	}
}

end_x=(stepper_motor_padded/2 + z_screw_rod_separation - extrusion_width);
xtest= -end_x - extrusion_width;
module z_rod_mount(height=stepper_motor_padded/2) {
	difference() {
		union() {
			translate([0, (-support_wall_thickness-height)/2, 0]) cube([smooth_rod_diameter+support_wall_thickness*2,support_wall_thickness+height,extrusion_width], center = true);
			translate([0, -support_wall_thickness-height, 0]) cylinder(r=smooth_rod_diameter/2 + support_wall_thickness,h=extrusion_width, center = true);
			translate([(-end_x+ smooth_rod_diameter/2 + support_wall_thickness)/2 -extrusion_width/2, (-support_wall_thickness)/2, 0]) cube([end_x+extrusion_width+smooth_rod_diameter/2 + support_wall_thickness,support_wall_thickness,extrusion_width], center = true);
			
			translate([(-end_x+ smooth_rod_diameter/2 + support_wall_thickness)/2,extrusion_width/2,0]) cube ([end_x + smooth_rod_diameter/2 + support_wall_thickness,extrusion_width,extrusion_width], center=true);
			//translate([-(end_x+extrusion_width+smooth_rod_diameter/2 + support_wall_thickness)/2 -(support_wall_thickness + smooth_rod_diameter/2),-support_wall_thickness-(height+smooth_rod_diameter/2+support_wall_thickness)/2,support_wall_thickness/2-extrusion_width/2]) cube([(end_x+extrusion_width+smooth_rod_diameter/2 + support_wall_thickness) -support_wall_thickness -smooth_rod_diameter/2,(height+smooth_rod_diameter/2+support_wall_thickness),support_wall_thickness], center = true);
			translate([-((end_x + extrusion_width) - (support_wall_thickness + smooth_rod_diameter/2))/2 - smooth_rod_diameter/2 - support_wall_thickness, -(height)/2 -support_wall_thickness,support_wall_thickness/2-extrusion_width/2]) cube([((end_x + extrusion_width) -(support_wall_thickness + smooth_rod_diameter/2)),height,support_wall_thickness], center = true);
		}
		translate([0, -support_wall_thickness-height, 0]) cylinder(r=smooth_rod_diameter/2,h=extrusion_width+1, center = true);
		translate([- end_x - (extrusion_width)/2, (-support_wall_thickness)/2, 0]) rotate(a=[90,0,0]) cylinder(r=ex_screw_hole_diameter/2,h=support_wall_thickness+1, center = true);
		translate([-(-end_x+ smooth_rod_diameter/2 + support_wall_thickness)/2, extrusion_width/2, 0]) rotate(a=[0,90,0]) cylinder(r=ex_screw_hole_diameter/2,h=end_x+extrusion_width+smooth_rod_diameter/2 + support_wall_thickness, center = true);
		translate([-((end_x + extrusion_width) - (support_wall_thickness + smooth_rod_diameter/2)) - smooth_rod_diameter/2 - support_wall_thickness, -(height) -support_wall_thickness,support_wall_thickness/2-extrusion_width/2]) rotate(a=[90,0,180]) chamfer(x=((end_x + extrusion_width) -(support_wall_thickness + smooth_rod_diameter/2)),z=height);
	}
}

module y_idler() {
	difference(){
		cylinder(r=y_idler_size/2,h=y_idler_width, center = true);
		cylinder(r=y_idler_size_inner_r/2,h=y_idler_width+1, center = true);
	}
	
}

module y_idler_mount() {
	difference() {
		union() {
			translate([0, 0, motor_mount_thickness/2]) cube([extrusion_width,ex_screw_head_dia_padded+idler_size,motor_mount_thickness], center = true);
			translate([0, 0, ((pulley_belt_center+pulley_height_from_motor)-y_idler_width/2-y_idler_washer_thickness)/2]) cylinder(r=extrusion_width/2,h=(pulley_belt_center+pulley_height_from_motor)-y_idler_width/2-y_idler_washer_thickness, center = true);
			translate([0, -idler_size/2-ex_screw_head_dia_padded/2, motor_mount_thickness/2]) cylinder(r=extrusion_width/2,h=motor_mount_thickness, center = true);
			translate([0, idler_size/2+ex_screw_head_dia_padded/2, motor_mount_thickness/2]) cylinder(r=extrusion_width/2,h=motor_mount_thickness, center = true);
		}		
		translate([0, 0, ((pulley_belt_center+pulley_height_from_motor)-y_idler_width/2-y_idler_washer_thickness)/2]) cylinder(r=ex_screw_hole_diameter/2,h=(pulley_belt_center+pulley_height_from_motor)-y_idler_width/2-y_idler_washer_thickness+1, center = true);
		translate([0, -idler_size/2-extrusion_width/2, motor_mount_thickness/2]) cylinder(r=ex_screw_hole_diameter/2,h=motor_mount_thickness+1, center = true);
		translate([0, idler_size/2+extrusion_width/2, motor_mount_thickness/2]) cylinder(r=ex_screw_hole_diameter/2,h=motor_mount_thickness+1, center = true);
	}
	% translate([0, 0,(pulley_belt_center+pulley_height_from_motor)]) y_idler();
}

y_idler_mount();
//y_motor_mount();
//z_motor_mount();
//smooth_rod_mount();
//translate([0, 0, 0]) z_rod_mount();






















