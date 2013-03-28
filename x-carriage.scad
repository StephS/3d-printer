// PRUSA iteration3
// X carriage
// GNU GPL v3
// Josef Pr?ša <josefprusa@me.com>
// Václav 'ax' H?la <axtheb@gmail.com>
// http://www.reprap.org/wiki/Prusa_Mendel
// http://github.com/prusajr/PrusaMendel

include <configuration.scad>
use <bushing.scad>
// mounting plate
use <extras/groovemount.scad>



carriage_l = 86;
carriage_hole_to_side = 3;
carriage_hole_height = 4;

bushing_carriage_len = adjust_bushing_len(bushing_x_carriage, 21, layer_height * 9);

x_beltclamp_space = (carriage_l - bushing_carriage_len) - 2;

x_beltclamp_len = (x_beltclamp_space > 30 ? x_beltclamp_space/2 : x_beltclamp_space) - 4;


module x_carriage(){
    mirror([1,0,0]) {
        difference() {
            union() {
                //upper bearing
                rotate([0,0,180]) {
                    difference(){
                        linear(bushing_x_carriage);
                        translate([-15, -9/2, -0.1]) cube([3, 9, bushing_x_carriage[2] + 5]);
                    }
                }
                translate([6.5, -10, 0]) cube_fillet([4.5, 20, bushing_carriage_len], vertical = [2,2,3,0]);

                //lower bearing
                translate([xaxis_rod_distance,0,0]) {
                    linear(bushing_x, carriage_l);
                }
                translate([xaxis_rod_distance - 11.5, -10, 0]) cube_fillet([5, 20, carriage_l], radius=2);

                // main plate
                translate([14,-10.5,0]) cube_fillet([xaxis_rod_distance - 20,6.5,carriage_l], radius=2);
                translate([6.5,-10.5,0]) cube_fillet([12, 6.5, bushing_carriage_len], radius=2);

                //reduce springiness
                translate([9,6*single_wall_width+1,0]) cube([xaxis_rod_distance - 18, 5, bushing_carriage_len]);

                //space around screws
                translate([20,0,carriage_hole_to_side]) {
                    rotate([90,0,0]) cylinder(r=(carriage_hole_to_side > 5 ? 5 : carriage_hole_to_side), h=12, center=true);
                }
                translate([20, 0, 30 + carriage_hole_to_side]) {
                    rotate([90,0,0]) cylinder(r=(carriage_hole_to_side > 5 ? 5 : carriage_hole_to_side), h=12, center=true);
                }
                translate([20, 0, 50 + carriage_hole_to_side]) {
                    rotate([90,0,0]) cylinder(r=(carriage_hole_to_side > 5 ? 5 : carriage_hole_to_side), h=12, center=true);
                }
                if (carriage_l > 80 + carriage_hole_to_side) {
                    translate([20, 0, 80 + carriage_hole_to_side]) {
                        rotate([90,0,0]) cylinder(r=(carriage_hole_to_side > 5 ? 5 : carriage_hole_to_side), h=12, center=true);
                    }
                }


                translate([45/2,0,0]){

                    // belt dummy
                    %translate([0,0,carriage_l/2]) cube([20,6,carriage_l], center = true);

                    //belt flat side. replaced by x_beltclamp
                    //difference() {
                    // translate([-13.5,0,carriage_l/2]) cube_fillet([7,14,carriage_l], vertical = [3,3,0,0], center = true);
                    // translate([-45/2,0,0]) bushing_negative();
                    //}

                    difference(){
                        translate([-3.0,0,carriage_l/2]) cube_fillet([11,14,carriage_l], vertical = [2,2,0,0], center = true);
                        translate([-3.5,0,(carriage_l+38)/2]) cube([13,10,8], center = true);
                        translate([-8.5, 0, 0]) cube([2, 10, bushing_carriage_len * 2 + 3], center = true);
                        intersection() {
                            for (i = [0 : x_beltclamp_space / belt[0]])
                            {
                                translate([-8.5, 0, (belt[0]*belt[1])/2+ carriage_l - i * belt[0]]) cube([belt[2]*2+0.1, 10, belt[0]*belt[1]], center = true);
                            }
                            translate([0, 0, carriage_l/2]) cube([20, 10, carriage_l], center = true);
                        }
                    }

                }
            }
            //upper bearing
            rotate([0,0,180]) {
                linear_negative(bushing_x_carriage);
            }

            //lower bearing
            translate([xaxis_rod_distance,0,0]) {
                linear_negative(bushing_x, carriage_l);
            }
            // extruder mounts

            translate([20,-1,carriage_hole_to_side]) {
                rotate([90,0,0]) translate([0,0,-11]) screw_hole(type=screw_M3_socket_head, h=20.5, $fn=8);
                translate([0,11+0.01,0]) rotate([90,60,0]) nut_hole(type=nut_M3, h=13-10+nut_thickness(v_nut_hole(nut_M3)));
            }
            translate([20,-1,carriage_hole_to_side+30]) {
                rotate([90,0,0]) translate([0,0,-11]) screw_hole(type=screw_M3_socket_head, h=20.5, $fn=8);
                translate([0,11+0.01,0]) rotate([90,60,0]) nut_hole(type=nut_M3, h=13-10+nut_thickness(v_nut_hole(nut_M3)));
            }
            translate([20,-1,carriage_hole_to_side+30+20]) {
                rotate([90,0,0]) translate([0,0,-11]) screw_hole(type=screw_M3_socket_head, h=20.5, $fn=8);
                translate([0,11+0.01,0]) rotate([90,60,0]) nut_hole(type=nut_M3, h=13-10+nut_thickness(v_nut_hole(nut_M3)));
            }
            translate([20,-1,carriage_hole_to_side+30+20+30]) {
                rotate([90,0,0]) translate([0,0,-11]) screw_hole(type=screw_M3_socket_head, h=20.5, $fn=8);
                translate([0,11+0.01,0]) rotate([90,60,0]) nut_hole(type=nut_M3, h=13-10+nut_thickness(v_nut_hole(nut_M3)));
            }

            // belt clamp mounts
            translate([20, -10.5, 70 + carriage_hole_to_side]) belt_clamp_nut();
            translate([20, -10.5, 40 + carriage_hole_to_side]) belt_clamp_nut();

        }
    }
}

module belt_clamp_nut() {
	translate([0,nut_outer_dia(v_nut_hole(nut_M3))/2,0]) rotate([0, -90, 0]) rotate([0, 0, -90])
		nut_slot_hole(type=nut_M3, h=nut_outer_dia(v_nut_hole(nut_M3))/2); //cube([2.5,m3_nut_diameter_bigger,m3_nut_diameter+0.3]);
    //#translate([0,0,m3_nut_diameter/-2]) cube([2.5,m3_nut_diameter_bigger,m3_nut_diameter+0.3]);
    translate([-6,nut_outer_dia(v_nut_hole(nut_M3))/2,0]){
        rotate([0, 90,0]) screw_hole(type=screw_M3_socket_head, h=10, $fn=8); //cylinder(r=3.5/2,h=20,$fn=32, center=true);
        //rotate([0,-90,0]) cylinder(r=3.5/2,h=30,$fn=32);
    }
}
module x_beltclamp(){
    translate([1,0,0]) difference(){
        cube_fillet([x_beltclamp_len, 17, 7]);
        translate([carriage_l-32-30,nut_outer_dia(v_nut_hole(nut_M3)),0]/2){
            //cylinder(r=3.4/2,h=30);
            translate([0,0,7]) mirror([0,0,1]) screw_hole(type=screw_M3_socket_head, h=10, head_drop=3);

        }
    }
}

x_carriage();
translate([carriage_l/-2-10,14,0]) x_beltclamp();
translate([carriage_l/-2+17,14,0]) x_beltclamp();

//%translate([-13,-10,carriage_l]) rotate([90,90,90]) x_beltclamp();
//%translate([-13,-10,carriage_l-30]) rotate([90,90,90]) x_beltclamp();
