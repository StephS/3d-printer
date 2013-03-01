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
include <inc/functions.scad>
include <inc/metric.scad>;
include <inc/conf_bushing.scad>;
include <inc/conf_extrusion.scad>;
include <inc/belts_pulleys.scad>;

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

belt = conf_belt_GT2_3mm;
belt_width = 7;

// Select your pulley type ******************************************************
// GT2-3mm 17 groove pulley conf_pulley_17_GT2_3mm
// GT2 36 groove pulley conf_pulley_36_GT2

pulley = conf_pulley_17_GT2_3mm;
// the motor has a cylinder on it that raises the base of the shaft 2mm, this value must be greater than 2mm
pulley_height_from_motor=3;

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
extrusion = conf_ex_8020_10s;

// extrusion lengths
y_length_in = 16;
x_width_in = 12;
z_height_in = 14;
top_x_width_in=x_width_in;

y_length = y_length_in * inch;
x_width = x_width_in * inch;
z_height = z_height_in * inch;
top_x_width = top_x_width_in * inch + (extrusion[0]*2);
echo ("top and bottom extrusion lengths = ", top_x_width/inch);

// Choose bearing/bushing configuration ***************************************
// conf_b_* are in inc/conf_bushing.scad

bushing_xy = conf_b_lm8uu;
bushing_z = conf_b_lm8uu;
// for longer bearings use one shorter in x-carriage to make place for belt attachment
// by default use same as xy
bushing_carriage = bushing_xy;

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

y_idler_washer_thickness=1.5875;

x_idler_bearing = bearing_624_double;
y_idler_bearing = bearing_R4RS;

// Fillets ********************************************************************
// mostly cosmetic, except z axis.
// 0 = no fillets
// 1 = fillet

use_fillets = 1;

//set to 0 for single plate (affects z axis)
i_am_box = 1;

//if you do your own plate and can move bottom Z screws 5mm up set this to 0 to
//get stronger motor mount. Only for i_am_box = 0
i_want_to_use_single_plate_dxf_and_make_my_z_weaker = 1;

//radius of long threaded rod on Y frame
//Use 5.4 for M10 or 4.4 for M8
y_threaded_rod_long_r = 5.4;

// Thickness of the XZ plate board. Leave at 12 for single plate
board_thickness = 12;

// END of custom settings

// *******************
// Distance between Y rods
//y_rod_separation=100;
y_rod_separation=140;
y_clamp_separation=100;

// this is where the bottom of the Y rod will be.
y_rod_height=support_wall_thickness+7;
y_belt_center=(y_rod_height+smooth_rod_diameter/2+LM8UU_height)-(pulley[8] + pulley_height_from_motor);

// this setting is for the Prusa i2 bed
y_belt_clamp_hole_distance=18;
// *******************

// You are not supposed to change this
board_to_xz_distance = 26;
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

// Nuts and bolts

// m8_diameter = 0;
// m8_nut_diameter = 0;

// m4_diameter = 0;
// m4_nut_diameter = 0;

// m3_diameter = 0;
// m3_nut_diameter = 0;

// Bushing holder

// bushing_core_diameter = smooth_bar_diameter;
// bushing_material_thickness = 0;

///counted stuff
m3_nut_diameter_bigger = ((m3_nut_diameter  / 2) / cos (180 / 6))*2;



// These constants define the geometry of the complete-printer.scad

//x_smooth_rod_length=325;
//y_smooth_rod_length=405;
//z_smooth_rod_length=235;
bed_x_size=225;
bed_y_size=225;

x_smooth_rod_length=460+board_thickness*2; // 492 for 16mm thickness; 484 for 12mm thickness
y_smooth_rod_length=470;
z_smooth_rod_length=405;
