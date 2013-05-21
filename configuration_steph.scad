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
include <inc/conf_bearing.scad>;
include <inc/conf_extrusion.scad>;
include <inc/belts_pulleys.scad>;
include <inc/nuts_screws.scad>;
include <printer_conf.scad>;

// Custom settings here, tailor to your supplies and print settings

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
// GT2 40 groove pulley conf_pulley_40_GT2
pulley = conf_pulley_17_GT2_3mm;

// the motor has a cylinder on it that raises the base of the shaft 2mm, this value must be greater than 2mm
pulley_height_from_motor=6;

// Stepper motor dimensions
stepper_motor_height=42;
stepper_motor_width=42;
stepper_motor_padded=stepper_motor_width+2;

// distance between the center of the Z Lead screw and the center of the Z smooth rod. Default for Prusa i3 is 17
z_screw_rod_separation=17;

// Screws used to mount to the extrusion

// Thickness of the mounts (do not change unless you check for clearances)
support_wall_thickness=5;
motor_mount_thickness=10;

// Choose screws configuration ***************************************
// screw used for the Y idler bearing. make sure it matches the ID of the bearing.
y_bearing_screw = screw_M4_button_head;
y_bearing_nut = nut_M4;

// Y carriage settings
y_carriage_screw = screw_M4_button_head;
y_carriage_hole_spacing = 30.5;
y_bushing_mount_height=15-conf_b_lm12uu[1];

// screw used to mount parts to the extrusion
ex_screw=screw_8020_1_4_flange_head;
ex_nut=nut_jam_inch_1_4;

// extrusion parameters
// 10 series 8020 (inch) conf_ex_8020_10s
// 15 series 8020 (inch) conf_ex_8020_15s
// 20 series 8020 conf_ex_8020_20s
// 25 series 8020 conf_ex_8020_25s
// 30 series 8020 conf_ex_8020_30s
// Misumi 2020 conf_ex_misumi_2020
extrusion = conf_ex_8020_10s;

// extrusion lengths
// You can delete these and just specify in millimeters below
y_length_in = 18;
x_width_in = 14.25;
z_height_in = 14.25;
top_x_width_in=x_width_in;

y_length = y_length_in * inch;
x_width = x_width_in * inch;
z_height = z_height_in * inch;

// Smooth rod length is automatically calculated by extrusion length (can do vice-versa)
// the width of the X axis smooth rod block is 50, we have 2, so add in 100
x_smooth_rod_length=(x_width+100);
y_smooth_rod_length=(y_length+extrusion[0]*2);
z_smooth_rod_length=(z_height+extrusion[0]);


// Choose bearing/bushing configuration ***************************************
// conf_b_* are in inc/conf_bushing.scad

bushing_x = conf_b_lm8uu;
bushing_y = conf_b_lm12uu;
bushing_z = conf_b_lm8uu;
// for longer bearings use one shorter in x-carriage to make place for belt attachment
// by default use same as xy
bushing_x_carriage = bushing_x;

x_smooth_rod_diameter=bushing_x[0]*2;
y_smooth_rod_diameter=bushing_y[0]*2;
z_smooth_rod_diameter=bushing_z[0]*2;

top_x_width = top_x_width_in * inch + z_smooth_rod_diameter + support_wall_thickness*2+stepper_motor_padded+z_screw_rod_separation*2+screw_head_top_dia(v_screw_hole(ex_screw, $fn=8))*2;

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
//y_rod_separation=100; // for Prusa i3 mounting compatability
y_rod_separation=140;
y_clamp_separation=100;

// this is where the bottom of the Y rod will be.
y_rod_height=23-y_smooth_rod_diameter/2;

// LM8UU dimensions
// LM8UU_length = conf_b[2];
// The thickness of the mount for the LM8UU is 2mm ( using lm8uu-holder-slim_v1-1 )
y_bushing_height = bushing_y[1]+y_bushing_mount_height;
y_belt_center=(y_rod_height+y_smooth_rod_diameter/2+y_bushing_height)-(pulley[8] + pulley_height_from_motor);

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
x_delta = ((bushing_x[1] <= 7.7) ? 0 : bushing_x[1] - 7.7) * 0.9;
y_delta = ((bushing_y[1] <= 7.7) ? 0 : bushing_y[1] - 7.7) * 0.9;
z_delta = (bushing_z[1] <= 7.7) ? 0 : bushing_z[1] - 7.7;

// Don't change these calculations. They are for calculating the Brace position.
brace_offset=(extrusion[0]*2-extrusion[0]*cos(30));
z_extrusion_pos=y_length/2+((-bushing_x[0]+0.5-(extrusion[0]/2+support_wall_thickness+stepper_motor_padded/2))-24-3.5+(50.5-(7.4444+32.0111+0.25)));
brace_pos=z_extrusion_pos-extrusion[0]*2;

echo("X axis extrusion length = ", x_width, " inch=", (x_width)/inch);
echo("top support X axis extrusion length = ", top_x_width, " inch=", (top_x_width)/inch);
echo("Y axis extrusion length = ", y_length, " inch=", (y_length)/inch);
echo("Z axis extrusion length = ", z_height, " inch=", (z_height)/inch);
echo("Z axis Brace length = ", (brace_pos+brace_offset-1-extrusion[0]/2)/cos(60), " inch=", (brace_pos+brace_offset-1-extrusion[0]/2)/cos(60)/inch);
echo("X axis smooth rod length = ", x_smooth_rod_length, " inch=", x_smooth_rod_length/inch);
echo("Y axis smooth rod length = ", y_smooth_rod_length, " inch=", y_smooth_rod_length/inch);
echo("Z axis smooth rod length = ", z_smooth_rod_length, " inch=", z_smooth_rod_length/inch);

echo("Drill locations:");
echo("For Z axis extrusion mount, drill Y axis extrusion at ", z_extrusion_pos, "inch=", z_extrusion_pos/inch, " from end." );
echo("For X axis top extrusion mount, drill top X axis extrusion at ", ((top_x_width-x_width)/2+extrusion[0]/2), "inch=", ((top_x_width-x_width)/2+extrusion[0]/2)/inch, "from both ends.");

//Check to be sure the pulley doesn't hit the Y bed
if ((y_rod_height+y_smooth_rod_diameter/2+y_bushing_height)-(pulley[0] + pulley_height_from_motor) < 2) echo ("Warning! Bed is too close to the pulley. Please change y_rod_height.");
echo("Distance between bed and Y pulley:", (y_rod_height+y_smooth_rod_diameter/2+y_bushing_height)-(pulley[0] + pulley_height_from_motor));

// These constants define the geometry of the complete-printer.scad

bed_x_size=225;
bed_y_size=225;