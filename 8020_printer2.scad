include <configuration.scad>
use <rod_motor_holder.scad>
use <extrusion.scad>

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

// y axis smooth rod mount
translate(v = [y_rod_separation/2,y_length/2 + extrusion_width/2,extrusion_width*2]) rotate(a=[-90,0,0]) smooth_rod_mount(height=y_rod_height);
mirror([1,0,0]) translate(v = [y_rod_separation/2,y_length/2 + extrusion_width/2,extrusion_width*2]) rotate(a=[-90,0,0]) smooth_rod_mount(height=y_rod_height);
mirror([0,1,0]) {
	translate(v = [y_rod_separation/2,y_length/2 + extrusion_width/2,extrusion_width*2]) rotate(a=[-90,0,0]) smooth_rod_mount(height=y_rod_height);
	mirror([1,0,0]) translate(v = [y_rod_separation/2,y_length/2 + extrusion_width/2,extrusion_width*2]) rotate(a=[-90,0,0]) smooth_rod_mount(height=y_rod_height);
}

translate(v = [0,y_length/2,extrusion_width*2]) rotate(a=[0,0,-90]) y_motor_mount();
translate(v = [0,-y_length/2-extrusion_width/2,extrusion_width*2]) rotate(a=[0,0,-90]) y_idler_mount();

// y axis smooth rod
translate(v = [y_rod_separation/2,0,5+y_rod_height+extrusion_width*2]) rotate(a=[90,0,0]) color("DimGray") cylinder(r=smooth_rod_diameter/2,h=y_length+extrusion_width*2, center = true);
mirror([1,0,0]) translate(v = [y_rod_separation/2,0,5+y_rod_height+extrusion_width*2]) rotate(a=[90,0,0]) color("DimGray") cylinder(r=smooth_rod_diameter/2,h=y_length+extrusion_width*2, center = true);
echo("Y axis smooth rod length = ", y_length+extrusion_width*2);