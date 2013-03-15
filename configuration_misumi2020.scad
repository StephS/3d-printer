// PRUSA iteration3
// Configuration file
// GNU GPL v3
// Josef Pr?sa <josefprusa@me.com>
// Václav 'ax' H?la <axtheb@gmail.com>
// http://www.reprap.org/wiki/Prusa_Mendel
// http://github.com/prusajr/PrusaMendel

// PLEASE SELECT ONE OF THE CONFIGURATIONS BELOW
// BY UN-COMMENTING IT

// functions
include <inc/functions.scad>;
include <inc/metric.scad>;
include <inc/conf_bushing.scad>;
include <inc/conf_extrusion.scad>;
include <inc/belts_pulleys.scad>;
include <inc/nuts_screws.scad>;

// Custom settings here, tailor to your supplies and print settings

layer_height = 0.3;
width_over_thickness = 2.2;
inch = 25.4;

// Select your belt type ******************************************************
//T2.5 conf_belt_T2_5
//T5 (strongly discouraged) conf_belt_T5
//HTD3 conf_belt_HTD3
//MXL conf_belt_MXL
//GT2 conf_belt_GT2
//GT2-3mm conf_belt_GT2_3mm

belt = conf_belt_GT2;
belt_width = 7;

// Select your pulley type ******************************************************
// GT2-3mm 17 groove pulley conf_pulley_17_GT2_3mm
// GT2 36 groove pulley conf_pulley_36_GT2
// GT2 40 groove pulley conf_pulley_40_GT2
pulley = conf_pulley_36_GT2;

// the motor has a cylinder on it that raises the base of the shaft 2mm, this value must be greater than 2mm
pulley_height_from_motor=4;

// Stepper motor dimensions
stepper_motor_height=42;
stepper_motor_width=42;
stepper_motor_padded=stepper_motor_width+2;

z_screw_rod_separation=17;

// Screws used to mount to the extrusion

// Thickness of the mounts (do not change unless you check for clearances)
support_wall_thickness=5;
motor_mount_thickness=10;

smooth_rod_diameter=8;

// Choose screws configuration ***************************************
// screw used for the Y idler bearing. make sure it matches the ID of the bearing.
y_bearing_screw = screw_M4_button_head;
y_bearing_nut = nut_M4;
// screw used to mount parts to the extrusion
ex_screw=screw_M5_button_head;

// extrusion parameters
// 10 series 8020 (inch) conf_ex_8020_10s
// 15 series 8020 (inch) conf_ex_8020_15s
// 20 series 8020 conf_ex_8020_20s
// 25 series 8020 conf_ex_8020_25s
// 30 series 8020 conf_ex_8020_30s
// Misumi 2020 conf_ex_misumi_2020
extrusion = conf_ex_misumi_2020;

// extrusion lengths
// You can delete these and just specify in millimeters below
y_length_in = 16;
x_width_in = 12;
z_height_in = 14;
top_x_width_in=x_width_in;

y_length = y_length_in * inch;
x_width = x_width_in * inch;
z_height = z_height_in * inch;
top_x_width = top_x_width_in * inch + smooth_rod_diameter + support_wall_thickness*2+stepper_motor_padded+z_screw_rod_separation*2+screw_head_top_dia(v_screw_hole(ex_screw, $fn=8))*2;
//echo ("top and bottom extrusion lengths = ", top_x_width/inch);

// Choose bearing/bushing configuration ***************************************
// conf_b_* are in inc/conf_bushing.scad

bushing_xy = conf_b_lm8uu;
bushing_z = conf_b_lm8uu;
// for longer bearings use one shorter in x-carriage to make place for belt attachment
// by default use same as xy
bushing_carriage = bushing_xy;

//z_smooth_rod_location=(extrusion[0]/2+support_wall_thickness+stepper_motor_padded/2);
//carriage_mount = -bushing_xy[0]+0.5-z_smooth_rod_location;

// LM8UU dimensions
LM8UU_dia = 15.2;
LM8UU_length = 24;
// The thickness of the mount for the LM8UU is 2mm ( using lm8uu-holder-slim_v1-1 )
LM8UU_height = LM8UU_dia/2+2;

//Check to be sure the pulley doesn't hit the Y bed
echo("Y pulley height", pulley[0] + pulley_height_from_motor);
echo("Y bed height", y_rod_height+smooth_rod_diameter/2+LM8UU_height);

// Select idler bearing size **************************************************
// [outer_diameter, width, inner_diameter, uses_guide]
// 608 [standard skate bearings] with bearing guide
bearing_608 = [22, 7, 8, 1];
//608 bearings with fender washers
bearing_608_washers = [22, 10, 8, 0];
// 624 [roughly same diameter as pulley, makes belt parallel so its prettier]
bearing_624 = [16, 5, 4, 1];
// two 624 - for use without bearing guides. My favourite [ax]
bearing_624_double = [16, 10, 4, 0];
// Size for 1/4" R4RS bearing
bearing_R4RS = [15.875, 4.9784, 6.35, 0];
// Size for 6mm 626RS bearing
bearing_626RS = [19, 6, 6, 0];

//y_idler_washer=washer_inch_1_4;

x_idler_bearing = bearing_624_double;
y_idler_bearing = bearing_624_double;

// Fillets ********************************************************************
// mostly cosmetic, except z axis.
// 0 = no fillets
// 1 = fillet

use_fillets = 1;

// END of custom settings

// *******************
// Distance between Y rods
//y_rod_separation=100;
y_rod_separation=140;
y_clamp_separation=100;

// this is where the bottom of the Y rod will be.
y_rod_height=support_wall_thickness+10;

y_belt_center=(y_rod_height+smooth_rod_diameter/2+LM8UU_height)-(pulley[8] + pulley_height_from_motor);

// this setting is for the Prusa i2 bed
y_belt_clamp_hole_distance=18;
// *******************

// You are not supposed to change this
xaxis_rod_distance = 45;

//calculated from settings
single_wall_width = width_over_thickness * layer_height;

x_idler_width = (x_idler_bearing[1] > 7 ? x_idler_bearing[1] : 7) + 2.5 * x_idler_bearing[3] ;
y_idler_width = (y_idler_bearing[1] > 7 ? y_idler_bearing[1] : 7) + 2.5 * y_idler_bearing[3] ;

//deltas are used to enlarge parts for bigger bearings 
xy_delta = ((bushing_xy[1] <= 7.7) ? 0 : bushing_xy[1] - 7.7) * 0.9;
z_delta = (bushing_z[1] <= 7.7) ? 0 : bushing_z[1] - 7.7;

// CHANGE ONLY THE STUFF YOU KNOW
// IT WILL REPLACE DEFAULT SETTING

// RODS

// threaded_rod_diameter = 0;
// threaded_rod_diameter_horizontal = 0;
// smooth_bar_diameter = 0;
// smooth_bar_diameter_horizontal = 0;


// These constants define the geometry of the complete-printer.scad

//x_smooth_rod_length=325;
//y_smooth_rod_length=405;
//z_smooth_rod_length=235;
bed_x_size=225;
bed_y_size=225;