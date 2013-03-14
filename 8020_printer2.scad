include <configuration.scad>
use <motor_mounts.scad>
use <rod_mounts.scad>
use <extrusion.scad>
use <x-end.scad>
use <x-carriage.scad>
use <bushing.scad>
use <extrusion_bracket.scad>
use <extras/gregs-wade-v3.scad>

brace_offset=(extrusion[0]*2-extrusion[0]/sin(45));
brace_pos=y_length/2+((-bushing_xy[0]+0.5-(extrusion[0]/2+support_wall_thickness+stepper_motor_padded/2))-24-3.5+(50.5-(7.4444+32.0111+0.25)))-extrusion[0]*2;

// feet
translate(v = [x_width/2 - extrusion[0]/2,y_length/2 + extrusion[0]/2,extrusion[0]/2]) extrusion(length= extrusion[0]);
translate(v = [-(x_width/2 - extrusion[0]/2),(y_length/2 + extrusion[0]/2),extrusion[0]/2]) extrusion(length= extrusion[0]);
translate(v = [-(x_width/2 - extrusion[0]/2),-(y_length/2 + extrusion[0]/2),extrusion[0]/2]) extrusion(length= extrusion[0]);
translate(v = [(x_width/2 - extrusion[0]/2),-(y_length/2 + extrusion[0]/2),extrusion[0]/2]) extrusion(length= extrusion[0]);

translate([0,0, extrusion[0]*2]) {
	// Y length bars
	translate(v = [x_width/2 - extrusion[0]/2,0,-extrusion[0]/2]) rotate(a=[90,0,0]) extrusion(length= y_length);
	translate(v = [-(x_width/2 - extrusion[0]/2),0,-extrusion[0]/2]) rotate(a=[90,0,0]) extrusion(length= y_length);

	// X Width bars
	translate(v = [0,y_length/2 + extrusion[0]/2,-extrusion[0]/2]) rotate(a=[0,90,0]) extrusion(length= x_width);
	translate(v = [0,-(y_length/2 + extrusion[0]/2),-extrusion[0]/2]) rotate(a=[0,90,0]) extrusion(length= x_width);
	echo("Max platform width = ", x_width-extrusion[0]*2);

	translate([0, -((-bushing_xy[0]+0.5-(extrusion[0]/2+support_wall_thickness+stepper_motor_padded/2))-24-3.5+(50.5-(7.4444+32.0111+0.25))), 0]) {
		// Z vertical bars
		translate([x_width/2,0,0]) {
			translate([-extrusion[0]/2,0,(z_height-extrusion[0])/2]) extrusion(length= z_height-extrusion[0]);
			
			// Z motor mount
			translate(v = [0,-extrusion[0]/2, 0]) z_motor_mount();
	
			// z axis smooth rod mount
			translate(v = [(z_screw_rod_separation+stepper_motor_padded/2),-extrusion[0]/2,z_height -extrusion[0]/2]) z_rod_mount();
		
			// z axis smooth rod
			translate([(z_screw_rod_separation+stepper_motor_padded/2), -support_wall_thickness-stepper_motor_padded/2-extrusion[0]/2, z_height/2]) color("DimGray") cylinder(r=smooth_rod_diameter/2,h=z_height, center = true);
			echo("Z axis smooth rod length = ", z_height, " inch=", (z_height)/inch);
		
			// z axis screw
			translate([(stepper_motor_padded/2), -support_wall_thickness-stepper_motor_padded/2-extrusion[0]/2, z_height/2]) color("DimGray") cylinder(r=5/2,h=z_height, center = true);
		
			// Braces
			translate(v = [0, extrusion[0]/2,brace_pos-extrusion[0]/2]) rotate(a=[90,0,90]) top_brace_bracket();
			translate(v = [0,brace_pos, 0]) mirror([0, 0, 1]) rotate(a=[0,90,0]) top_brace_bracket();
			
			translate(v = [0,(brace_pos+brace_offset), support_wall_thickness])
			rotate(a=[45,0,0])
			translate([-extrusion[0]/2, extrusion[0]/2, (brace_pos+brace_offset-support_wall_thickness-extrusion[0]/2)/sin(45)/2]) extrusion(length= (brace_pos+brace_offset-support_wall_thickness-extrusion[0]/2)/sin(45));
		}
	
		//top z bar
		translate(v = [0,0,z_height -extrusion[0]/2]) rotate(a=[0,90,0]) extrusion(length= top_x_width);
		
		// X axis ends
		translate([0, -support_wall_thickness-stepper_motor_padded/2-extrusion[0]/2, z_height/2]) {
			translate([(x_width/2 +(z_screw_rod_separation+stepper_motor_padded/2)), 0, 52 + 2 * bushing_xy[0]-3]) rotate([180, 0, -90]) x_end_idler(thru=true);
			translate([-(x_width/2 +(z_screw_rod_separation+stepper_motor_padded/2)),0 ,52 + 2 * bushing_xy[0]-3]) rotate([180, 0, -90]) x_end_motor();
	
			// x axis smooth rod
			// the width of the rod block is 50, we have 2, so add in 100
			translate([0, 10 + bushing_xy[0], 0]) {
				translate([+4, 0, 6]) rotate([0, -90, 0]) color("DimGray") cylinder(h = x_width+100, r=bushing_xy[0], $fn=30, center=true);
				translate([+4, 0, xaxis_rod_distance+6]) rotate([0, -90, 0]) color("DimGray") cylinder(h = x_width+100, r=bushing_xy[0], $fn=30, center=true);
				//X axis carriage
				translate([0, 0, 6]) rotate([0,90,0]) x_carriage();
				//translate([-(50.5-(7.4444+32.0111+0.25))+3.5, -10.5-38, 0]) rotate([90,0,180]) wade();
			}
		}
	}

	mirror([1, 0, 0]) translate([0, -((-bushing_xy[0]+0.5-(extrusion[0]/2+support_wall_thickness+stepper_motor_padded/2))-24-3.5+(50.5-(7.4444+32.0111+0.25))), 0]) {
		translate([x_width/2,0,0]) {
			// Z vertical bar
			translate([-extrusion[0]/2,0,(z_height-extrusion[0])/2]) extrusion(length= z_height-extrusion[0]);
			
			// Z motor mount
			translate(v = [0,-extrusion[0]/2, 0]) z_motor_mount();
	
			// z axis smooth rod mount
			translate(v = [(z_screw_rod_separation+stepper_motor_padded/2),-extrusion[0]/2,z_height -extrusion[0]/2]) z_rod_mount();
		
			// z axis smooth rod
			translate([(z_screw_rod_separation+stepper_motor_padded/2), -support_wall_thickness-stepper_motor_padded/2-extrusion[0]/2, z_height/2]) color("DimGray") cylinder(r=smooth_rod_diameter/2,h=z_height, center = true);
		
			// z axis screw
			translate([(stepper_motor_padded/2), -support_wall_thickness-stepper_motor_padded/2-extrusion[0]/2, z_height/2]) color("DimGray") cylinder(r=5/2,h=z_height, center = true);
		
			// Braces
			translate(v = [0, extrusion[0]/2,brace_pos-extrusion[0]/2]) rotate(a=[90,0,90]) top_brace_bracket();
			translate(v = [0,brace_pos, 0]) mirror([0, 0, 1]) rotate(a=[0,90,0]) top_brace_bracket();
			
			translate(v = [0,(brace_pos+brace_offset), support_wall_thickness])
			rotate(a=[45,0,0])
			translate([-extrusion[0]/2, extrusion[0]/2, (brace_pos+brace_offset-support_wall_thickness-extrusion[0]/2)/sin(45)/2]) extrusion(length= (brace_pos+brace_offset-support_wall_thickness-extrusion[0]/2)/sin(45));
		}

	}
	
	echo("top X axis extrusion length = ", top_x_width, " inch=", (top_x_width)/inch);
	echo("X axis smooth rod length = ", x_width+100, " inch=", (x_width+100)/inch);
	echo("Z axis Brace length = ", (brace_pos+brace_offset-support_wall_thickness-extrusion[0]/2)/sin(45), " inch=", (brace_pos+brace_offset-support_wall_thickness-extrusion[0]/2)/sin(45)/inch);
	echo("Z axis extrusion length = ", (z_height-extrusion[0]), " inch=", (z_height-extrusion[0])/inch);

	// Y axis
	translate(v = [y_rod_separation/2, 0, 0]) {
		// y axis smooth rod mounts
		translate(v = [0, y_length/2 + extrusion[0]/2, 0]) rotate(a=[-90,0,0]) y_rod_mount(height=y_rod_height);
		translate(v = [0, -(y_length/2 + extrusion[0]/2), 0]) rotate(a=[-90,0,0]) y_rod_mount(height=y_rod_height);
		// Y axis Bed bearing clamps
		translate(v = [0, y_clamp_separation/2, 5+y_rod_height]) rotate([0,90,90]) y_bearing();
		translate(v = [0, -y_clamp_separation/2, 5+y_rod_height]) rotate([0,90,90]) y_bearing();
		// y axis smooth rod
		translate(v = [0, 0, 5+y_rod_height]) rotate(a=[90,0,0]) color("DimGray") cylinder(r=smooth_rod_diameter/2,h=y_length+extrusion[0]*2, center = true);
	}
	mirror([1, 0, 0]) {
		translate(v = [y_rod_separation/2, 0, 0]) {
			// y axis smooth rod mounts
			translate(v = [0, y_length/2 + extrusion[0]/2, 0]) rotate(a=[-90,0,0]) y_rod_mount(height=y_rod_height);
			translate(v = [0, -(y_length/2 + extrusion[0]/2), 0]) rotate(a=[-90,0,0]) y_rod_mount(height=y_rod_height);
			// Y axis Bed bearing clamps
			translate(v = [0, y_clamp_separation/2, 5+y_rod_height]) rotate([0,90,90]) y_bearing();
			translate(v = [0, -y_clamp_separation/2, 5+y_rod_height]) rotate([0,90,90]) y_bearing();
			// y axis smooth rod
			translate(v = [0, 0, 5+y_rod_height]) rotate(a=[90,0,0]) color("DimGray") cylinder(r=smooth_rod_diameter/2,h=y_length+extrusion[0]*2, center = true);
		}
	}
}

// Motor and idler mounts
translate(v = [0,y_length/2,extrusion[0]*2]) rotate(a=[0,0,-90]) y_motor_mount();
translate(v = [0,-y_length/2-extrusion[0]/2,extrusion[0]*2]) rotate(a=[0,0,-90]) y_idler_mount();

echo("Y axis smooth rod length = ", y_length+extrusion[0]*2, " inch=", (y_length+extrusion[0]*2)/inch);