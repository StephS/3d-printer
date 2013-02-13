// PRUSA iteration3
// Configuration file
// GNU GPL v3
// Josef Pr?ša <josefprusa@me.com>
// Václav 'ax' H?la <axtheb@gmail.com>
// http://www.reprap.org/wiki/Prusa_Mendel
// http://github.com/prusajr/PrusaMendel

// PLEASE SELECT ONE OF THE CONFIGURATIONS BELOW
// BY UN-COMMENTING IT

// Uncomment for metric settings
// METRIC METRIC METRIC METRIC METRIC METRIC METRIC METRIC 


// functions
include <functions.scad>
include <metric.scad>

// Custom settings here, tailor to your supplies and print settings

inch = 25.4;

// Select your belt type ******************************************************

//T2.5
//belt_tooth_distance = 2.5;
//belt_tooth_ratio = 0.5;
//belt_tooth_height = 0.7;
//belt_height = 1.3;
//belt_base_height = belt_height - belt_tooth_height;

//T5 (strongly discouraged)
//belt_tooth_distance = 5;
//belt_tooth_ratio = 0.75;

//HTD3
//belt_tooth_distance = 3;
//belt_tooth_ratio = 0.75;

//MXL
//belt_tooth_distance = 2.032;
//belt_tooth_ratio = 0.64;

//GT2
//belt_tooth_distance = 2;
//belt_tooth_ratio = 0.5;
//belt_tooth_height = 0.76;
//belt_height = 1.52;
//belt_base_height = belt_height - belt_tooth_height;

//GT2-3mm
belt_tooth_distance = 3;
belt_tooth_ratio = 0.5;
belt_tooth_height = 1.14;
belt_height = 2.41;
belt_base_height = belt_height - belt_tooth_height;
belt_width = 6;


// Stepper motor dimensions
stepper_motor_width=42;
stepper_motor_padded=stepper_motor_width+2;

z_screw_rod_separation=17;

// Screws used to mount to the extrusion
ex_screw_head_height=3.5;
ex_screw_head_dia=14;
ex_screw_diameter=6.35;
ex_screw_hole_diameter=ex_screw_diameter+0.15;
ex_screw_head_dia_padded=ex_screw_head_dia+1;

// Thickness of the mounts (do not change unless you check for clearances)
support_wall_thickness=5;
motor_mount_thickness=10;

smooth_rod_diameter=8;

// extrusion parameters
extrusion_width = inch;
extrusion_slot = 6.5;
extrusion_thin_wall=2.21;
extrusion_wall_width=9.46;
extrusion_center_channel=9.02;

// extrusion lengths
y_length_in = 16;
x_width_in = 12;
z_height_in = 14;
top_x_width_in=x_width_in;

y_length = y_length_in * inch;
x_width = x_width_in * inch;
z_height = z_height_in * inch;
top_x_width = top_x_width_in * inch + (extrusion_width*2);
echo ("top and bottom extrusion lengths = ", top_x_width/inch);

// values for GT3 16 groove pulley
pulley_height=20.6;
pulley_hub_height=6.3;
pulley_belt_height=11.1;
pulley_setscrew_height=3.5;
pulley_setscrew_diameter=5;
pulley_diameter=14.5;
pulley_hub_diameter=17.5;
pulley_outer_diameter=21;
pulley_belt_center=(pulley_height-pulley_hub_height)/2+pulley_hub_height;
// the motor has a cylinder on it that raises the base of the shaft 2mm, this value must be greater than 2mm
pulley_height_from_motor=3;

// LM8UU dimensions
LM8UU_dia = 15.2;
LM8UU_length = 24;
// The thickness of the mount for the LM8UU is 2mm ( using lm8uu-holder-slim_v1-1 )
LM8UU_height = LM8UU_dia/2+2;

//y_rod_separation=100;
y_rod_separation=148;
// this is where the bottom of the Y rod will be.
y_rod_height=support_wall_thickness+7;
y_belt_center=(y_rod_height+smooth_rod_diameter/2+LM8UU_height)-(pulley_belt_center + pulley_height_from_motor);

// test pulley height
//echo("Y clearance from bed bottom to frame", y_rod_height+smooth_rod_diameter/2+LM8UU_height);
//echo("Y pulley center", y_rod_height+smooth_rod_diameter/2+LM8UU_height);
//Check to be sure the pulley doesn't hit the Y bed
echo("Y pulley height", pulley_height + pulley_height_from_motor);
echo("Y bed height", y_rod_height+smooth_rod_diameter/2+LM8UU_height);

// This is where the center of the belt clamp will be, as compared to the Y platform bottom.
echo("Y Belt Clamp height", y_belt_center);

// this setting is for the Prusa i2 bed
y_belt_clamp_hole_distance=18;

//Bearing version
// 0 = default lm8uu
// 1 = lme8uu
bearing_type = 0;

// Select idler bearing size **************************************************
// Size for 1/4" R4RS bearing
y_idler_size=15.875;
y_idler_size_inner_r=6.35/2;
y_idler_width=4.9784;

y_idler_washer_thickness=1.5875;

// Size for 6mm 626RS bearing
// y_idler_size=19;
// y_idler_size_inner_r=6/2;
// y_idler_width=6;

// 0 = 608 [standard skate bearings]
// 1 = 624 [roughly same diameter as pulley, makes belt parallel so its prettier]

idler_bearing = 0;

//Layer height * width over thickness. Used for idler sleeve
single_wall_width = 0.3*2.2;

// END of custom settings


// You are not supposed to change this
xaxis_rod_distance = 45;
carriage_l = 74;
carriage_hole_to_side = 5;
carriage_hole_height = 4;

//calculated from settings

idler_size = (idler_bearing == 0) ? 22 : 13;

//use 4.5 for 608, 2.5 for 624
idler_size_inner_r = (idler_bearing == 0) ? 4.5 : 2.5;

idler_width = (idler_bearing == 0) ? 9 : 5;


///counted stuff
m3_nut_diameter_bigger = ((m3_nut_diameter  / 2) / cos (180 / 6))*2;

// These constants define the geometry of the complete-printer.scad

//x_smooth_rod_length=325;
//y_smooth_rod_length=405;
//z_smooth_rod_length=235;

x_smooth_rod_length=450; // 492 for 16mm thickness; 484 for 12mm thickness
y_smooth_rod_length=470;
z_smooth_rod_length=405;  
bed_x_size=225;
bed_y_size=225;
