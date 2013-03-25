// PRUSA iteration3
// X ends
// GNU GPL v3
// Josef Pr?ša <josefprusa@me.com>
// Václav 'ax' H?la <axtheb@gmail.com>
// http://www.reprap.org/wiki/Prusa_Mendel
// http://github.com/prusajr/PrusaMendel

include <inc/drivetrain.scad>
include <configuration.scad>
use <bushing.scad>
use <inc/bearing-guide.scad>

//height and width of the x blocks depend on x smooth rod radius
x_box_height = 52 + 2 * bushing_xy[0];
x_box_width = (bushing_xy[0] <= 4) ? 17.5 : bushing_xy[0] * 2 + 9.5;
x_box_x_axis_center = (-10 - bushing_xy[0]);
x_box_x_axis = (x_box_x_axis_center+x_box_width/2);

module x_end_motor(){
	pulley_hole_dia=hole_fit(pulley[7],8)+0.2;
	pulley_hole_dia_w_belt=pulley_hole_dia+belt[3]*2;
	
    mirror([0, 1, 0]) {
        translate([0, -z_delta - 2.5, 0]) difference(){
            union(){
				translate([0, +z_delta + 2.5, 0]) {
					x_end_base(vfillet=[3, 3, 0, 0], tfillet=[5, 3, 3, 3], thru=false, len=40 + z_delta, offset=-( z_delta));
					translate([x_box_x_axis_center, -16.5, 51.25/2]) cube_fillet([x_box_width, 13.5, 51.25],vertical=[0, 0, 3+0.01, 9+0.01], top=[0, 3, 3, 3], center=true);
				}
                intersection() {
                    translate([-15, -34, 30]) cube([20, 60, x_box_height], center = true);
                    union() {
                        //translate([-10 - bushing_xy[0]+1/4, -14 + z_delta / 2, 24]) cube_fillet([x_box_width+1/2, 13 + z_delta, 55], center = true, vertical=[0, 0, 3, 1.5], top=[0, 3, 6, 3], $fn=16);
                        translate([x_box_x_axis-11/2, -32, 0]) intersection(){
                            translate([0, .25, 1]) cube_fillet([11, 42.5, 28], vertical=[0, 0, 5, 5], center = true);
                            translate([-11/2, 30.25*2-42+5.5/2, -30.25]) rotate([45, 0, 0]) cube_fillet([11, 60, 60], radius=2);
                        }
                    }
                }
                translate([x_box_x_axis, -32, 30.25]) rotate([90, 0, 0])  rotate([0, -90, 0]) motor_plate(thickness=11, head_drop=screw_head_height(screw_M3_socket_head), vertical=[5.5,5.5,5.5,5.5], $fn=8); //nema17(places=[1, 0, 1, 1], h=11);
            }

            // motor screw holes
            translate([x_box_x_axis, -21-11, 30.25]){
                // belt hole
                translate([-x_box_width/2, 11, 0]) cube([11, 31, 23], center = true);
                // pulley hole (make sure the belt can slip around the flange)
                translate([-x_box_width/2, 0, 0]) rotate([90, 0, 0])  rotate([0, -90, 0]) rotate([0,0, 180/8]) cylinder(h=11, r=pulley_hole_dia_w_belt/2, $fn=8, center=true);
                // pulley hole 2
                translate([-2, 0, 0]) rotate([90, 0, 0])  rotate([0, -90, 0]) rotate([0,0, 180/8]) cylinder(h=20, r=pulley_hole_dia/2, $fn=8);
                
                //motor mounting holes
                translate([-x_box_width, 0, 0]) rotate([0, 90, 0]) nema17(places=[1, 1, 0, 1], holes=true, head_drop=x_box_width-11+3, $fn=8, h=10);
            }
        }
        // support wall
        translate([x_box_x_axis-11 +single_wall_width/2, -21-13-.5, 30.25]) {
    	    cube([single_wall_width, pulley_hole_dia_w_belt/2*cos(180/8)*0.83, 36],center=true);
    	    if ( (pulley_hole_dia_w_belt/2*cos(180/8)-1.75)/2+(pulley_hole_dia_w_belt/2*cos(180/8)*0.83)/4 +(pulley_hole_dia_w_belt*cos(180/8)-23)/4 < 11.5)
    	    translate([0, (pulley_hole_dia_w_belt/2*cos(180/8)-1.75)/2+(pulley_hole_dia_w_belt/2*cos(180/8)*0.83)/4 +(pulley_hole_dia_w_belt*cos(180/8)-23)/4, 0]) cube([single_wall_width, pulley_hole_dia_w_belt/2*cos(180/8)-1.75 -(pulley_hole_dia_w_belt/2*cos(180/8)*0.83)/2 -(pulley_hole_dia_w_belt*cos(180/8)-23)/2, 28],center=true);
		}
        //smooth rod caps
        //translate([x_box_x_axis_center-(x_box_width-6)/2, -10, 0]) cube([x_box_width-6, 2, 15]);
        //translate([x_box_x_axis_center-(x_box_width-6)/2, -10, 45]) cube([x_box_width-6, 2, 10]);
    }
}

module x_end_base(vfillet=[3, 3, 3, 3], tfillet=[5, 3, 5, 3], thru=true, len=40, offset=0){

    difference(){
        union(){
            translate([-10 - bushing_xy[0], -10 + len / 2 + offset, 30]) cube_fillet([x_box_width, len, x_box_height], center=true, vertical=vfillet, top=tfillet);

            translate([z_delta, 0, 4 - bushing_xy[0]]) {
                //rotate([0, 0, 0]) translate([0, -9.5, 0]) 
                render(convexity = 5) linear(bushing_z, x_box_height);
                // Nut trap
                translate([-2, 18, 5]) cube_fillet([20, 14, 10], center = true, vertical=[8, 0, 0, 5], $fn=4);
                //}
            }
        }
        // here are bushings/bearings
        translate([z_delta, 0, 4 - bushing_xy[0]]) linear_negative(bushing_z, x_box_height);

        // belt hole
        translate([-5.5 - 10 + 1.5, 22 - 9 + offset, 30]) cube([max(x_idler_width + 2, 11), len+15, 27], center = true);

        translate([x_box_x_axis_center, offset, 0]) {
            if(thru == true){
                translate([0, -11+ 0.1, 6]) rotate([-90, 0, 0]) pushfit_rod(bushing_xy[0] * 2 + 0.1, 50);
                translate([0, -11+ 0.1, xaxis_rod_distance+6]) rotate([-90, 0, 0]) pushfit_rod(bushing_xy[0] * 2 + 0.1, 50);
            } else {
                translate([0, -7+ 0.1, 6]) rotate([-90, 0, 0]) pushfit_rod(bushing_xy[0] * 2 + 0.1, 50);
                translate([0, -7+ 0.1, xaxis_rod_distance+6]) rotate([-90, 0, 0]) pushfit_rod(bushing_xy[0] * 2 + 0.1, 50);
            }
        }
        translate([0, 0, 5 - bushing_xy[0]]) {  // m5 nut insert
            translate([z_delta, 17, 0]) rotate([0, 0, 45]){

                cylinder_poly(h = 40, r=hole_fit(2.65*2, $fn=poly_sides(2.65*2))/2, center=true);
                //nut slid in
                translate([0, 0, 2]) nut_slot_hole(type=nut_M5, h=9.2);
            }
        }
    }
    //threaded rod
    //translate([0, 17, 0]) %cylinder(h = 70, r=2.5+0.2);
}

module x_end_idler(){
    difference() {
        x_end_base(len=45);
        // idler hole
        translate([-14, 26, 29]) rotate([0, 90, 0]) {
            idler_assy(x_idler_bearing);
            translate([0,20,0])
                cube([idler_assy_r_outer(x_idler_bearing) * 2, 40, x_idler_width + 1], center=true);
            if (x_idler_bearing[3]) {
                %translate([0, 0, -(x_idler_width / 2)]) bearing_guide_outer(x_idler_bearing);
                %translate([0, 0, x_idler_width / 2]) mirror([0, 0, 1]) bearing_guide_inner(x_idler_bearing);
            }
        }
    }
}

module pushfit_rod(diameter, length){
    cylinder(h = length, r=hole_fit( dia=diameter,$fn=30)/2, $fn=30);
    translate([0, -diameter/4, length/2]) cube([diameter, diameter/2, length], center = true);

    translate([0, -diameter/2-1.2, length/2]) cube([diameter, 1, length], center = true);
}

/*
module x_end_idler(){
    difference() {
        x_end_base(len=45 + z_delta / 3, offset=-10 - z_delta / 3);
        // idler hole
        translate([-20, -15 - z_delta / 2, 30]) {
            rotate([0, 90, 0]) rotate([0, 0, 180/8])  cylinder(r=m4_diameter / 2, h=33, center=true, $fn=8);
            translate([15 - 2 * single_wall_width, 0, 0]) rotate([90, 0, 90]) nut_hole(type=nut_M4);

        }
        translate([-6 - x_box_width, 11, 21.5]) cube([x_box_width + 1, 11, 17.5]);
    }
        //%translate([-14, -9, 22]) x_tensioner();
}
*/

/*
module x_tensioner(len=62, idler_height=16) {
        idlermount(len=len, rod=m4_diameter / 2, idler_height=idler_height, narrow_len=46, narrow_width=x_idler_width + 2 - single_wall_width);
}
*/

//translate([-40, 0, 4 - bushing_xy[0]]) x_tensioner();
mirror([0, 0, 0]) x_end_idler(thru=true);
translate([50, 0, 0]) x_end_motor();

if (x_idler_bearing[3] == 1) {
    translate([-25, -20 - x_idler_bearing[0] / 2, 0]) {
        render() bearing_guide_inner();
        translate([x_idler_bearing[0]+10, 0, 0])
            render()bearing_guide_outer();
    }
}
