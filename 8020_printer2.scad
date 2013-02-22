include <configuration.scad>
use <rod_motor_holder.scad>
use <extrusion.scad>
use <x-end.scad>
use <x-carriage.scad>
use <bushing.scad>

// Y length bars
translate(v = [x_width/2 - extrusion_width/2,0,extrusion_width*1.5]) rotate(a=[90,0,0]) extrusion(length= y_length);
translate(v = [-(x_width/2 - extrusion_width/2),0,extrusion_width*1.5]) rotate(a=[90,0,0]) extrusion(length= y_length);

// X Width bars
translate(v = [0,y_length/2 + extrusion_width/2,extrusion_width*1.5]) rotate(a=[0,90,0]) extrusion(length= x_width);
translate(v = [0,-(y_length/2 + extrusion_width/2),extrusion_width*1.5]) rotate(a=[0,90,0]) extrusion(length= x_width);
echo("Max platform width = ", x_width, x_width-extrusion_width*2);

translate(v = [top_x_width/2 - extrusion_width/2,0,z_height/2 + extrusion_width]) extrusion(length= z_height);
translate(v = [-(top_x_width/2 - extrusion_width/2),0,z_height/2 + extrusion_width]) extrusion(length= z_height);
//top and bottom z bars
translate(v = [0,0,z_height + extrusion_width*1.5]) rotate(a=[0,90,0]) extrusion(length= top_x_width);
translate(v = [0,0,extrusion_width/2]) rotate(a=[0,90,0]) extrusion(length= top_x_width);

// feet
translate(v = [x_width/2 - extrusion_width/2,y_length/2 + extrusion_width/2,extrusion_width/2]) extrusion(length= extrusion_width);
translate(v = [-(x_width/2 - extrusion_width/2),(y_length/2 + extrusion_width/2),extrusion_width/2]) extrusion(length= extrusion_width);
translate(v = [-(x_width/2 - extrusion_width/2),-(y_length/2 + extrusion_width/2),extrusion_width/2]) extrusion(length= extrusion_width);
translate(v = [(x_width/2 - extrusion_width/2),-(y_length/2 + extrusion_width/2),extrusion_width/2]) extrusion(length= extrusion_width);

translate(v = [x_width/2,-extrusion_width/2,extrusion_width*2]) z_motor_mount();
mirror([1,0,0]) translate(v = [x_width/2,-extrusion_width/2,extrusion_width*2]) z_motor_mount();

// z axis smooth rod mount
translate(v = [x_width/2 +(z_screw_rod_separation+stepper_motor_padded/2),-extrusion_width/2,z_height + extrusion_width*1.5]) z_rod_mount();
mirror([1,0,0]) translate(v = [x_width/2 +(z_screw_rod_separation+stepper_motor_padded/2),-extrusion_width/2,z_height + extrusion_width*1.5]) z_rod_mount();

// z axis smooth rod
translate([x_width/2 +(z_screw_rod_separation+stepper_motor_padded/2), -support_wall_thickness-stepper_motor_padded/2-extrusion_width/2, z_height/2+extrusion_width*2]) color("DimGray") cylinder(r=smooth_rod_diameter/2,h=z_height, center = true);
mirror([1,0,0]) translate([x_width/2 +(z_screw_rod_separation+stepper_motor_padded/2), -support_wall_thickness-stepper_motor_padded/2-extrusion_width/2, z_height/2+extrusion_width*2]) color("DimGray") cylinder(r=smooth_rod_diameter/2,h=z_height, center = true);
echo("Z axis smooth rod length = ", z_height);

// z axis screw
translate([x_width/2 +(stepper_motor_padded/2), -support_wall_thickness-stepper_motor_padded/2-extrusion_width/2, z_height/2+extrusion_width*2]) color("DimGray") cylinder(r=5/2,h=z_height, center = true);
mirror([1,0,0]) translate([x_width/2 +(stepper_motor_padded/2), -support_wall_thickness-stepper_motor_padded/2-extrusion_width/2, z_height/2+extrusion_width*2]) color("DimGray") cylinder(r=5/2,h=z_height, center = true);

// X axis ends
translate([0, -support_wall_thickness-stepper_motor_padded/2-extrusion_width/2, z_height/2+extrusion_width*2]) {
	translate([(x_width/2 +(z_screw_rod_separation+stepper_motor_padded/2)), 0, 52 + 2 * bushing_xy[0]-3]) rotate([180, 0, -90]) x_end_idler(thru=true);
	translate([-(x_width/2 +(z_screw_rod_separation+stepper_motor_padded/2)),0 ,52 + 2 * bushing_xy[0]-3]) rotate([180, 0, -90]) x_end_motor();
	
	// x axis smooth rod
	// the width of the rod block is 50, we have 2, so add in 100
	translate([0, 10 + bushing_xy[0], 0]) {
		translate([+4, 0, 6]) rotate([0, -90, 0]) color("DimGray") cylinder(h = x_width+100, r=bushing_xy[0], $fn=30, center=true);
		translate([+4, 0, xaxis_rod_distance+6]) rotate([0, -90, 0]) color("DimGray") cylinder(h = x_width+100, r=bushing_xy[0], $fn=30, center=true);
		//X axis carriage
		translate([0, 0, 6]) rotate([0,90,0]) x_carriage();
	}
}
echo("X axis smooth rod length = ", x_width+100);


translate(v = [y_rod_separation/2, 0, extrusion_width*2]) {
	// y axis smooth rod mounts
	translate(v = [0, y_length/2 + extrusion_width/2, 0]) rotate(a=[-90,0,0]) smooth_rod_mount(height=y_rod_height);
	translate(v = [0, -(y_length/2 + extrusion_width/2), 0]) rotate(a=[-90,0,0]) smooth_rod_mount(height=y_rod_height);
	// Y axis Bed bearing clamps
	translate(v = [0, y_clamp_separation/2, 5+y_rod_height]) rotate([0,90,90]) y_bearing();
	translate(v = [0, -y_clamp_separation/2, 5+y_rod_height]) rotate([0,90,90]) y_bearing();
	// y axis smooth rod
	translate(v = [0, 0, 5+y_rod_height]) rotate(a=[90,0,0]) color("DimGray") cylinder(r=smooth_rod_diameter/2,h=y_length+extrusion_width*2, center = true);
}
mirror([1, 0, 0]) {
translate(v = [y_rod_separation/2, 0, extrusion_width*2]) {
	// y axis smooth rod mounts
	translate(v = [0, y_length/2 + extrusion_width/2, 0]) rotate(a=[-90,0,0]) smooth_rod_mount(height=y_rod_height);
	translate(v = [0, -(y_length/2 + extrusion_width/2), 0]) rotate(a=[-90,0,0]) smooth_rod_mount(height=y_rod_height);
	// Y axis Bed bearing clamps
	translate(v = [0, y_clamp_separation/2, 5+y_rod_height]) rotate([0,90,90]) y_bearing();
	translate(v = [0, -y_clamp_separation/2, 5+y_rod_height]) rotate([0,90,90]) y_bearing();
	// y axis smooth rod
	translate(v = [0, 0, 5+y_rod_height]) rotate(a=[90,0,0]) color("DimGray") cylinder(r=smooth_rod_diameter/2,h=y_length+extrusion_width*2, center = true);
}
}

// Motor and idler mounts
translate(v = [0,y_length/2,extrusion_width*2]) rotate(a=[0,0,-90]) y_motor_mount();
translate(v = [0,-y_length/2-extrusion_width/2,extrusion_width*2]) rotate(a=[0,0,-90]) y_idler_mount();

echo("Y axis smooth rod length = ", y_length+extrusion_width*2);