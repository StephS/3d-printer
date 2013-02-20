// PRUSA iteration3
// Bushing/bearing housings
// GNU GPL v3
// Josef Pr?ša <josefprusa@me.com>
// Václav 'ax' H?la <axtheb@gmail.com>
// http://www.reprap.org/wiki/Prusa_Mendel
// http://github.com/prusajr/PrusaMendel

include <configuration.scad>

// ensure that the part length is at least the length of bushing barrel plus add
function adjust_bushing_len(conf_b, h, add=layer_height*2) = ((conf_b[2]+add) > h) ? conf_b[2]+add : h;

//distance from the flat side of bushing holder to rod center
function bushing_foot_len(conf_b, h=10.5, add=4*single_wall_width) = ((conf_b[1]+add) > h) ? conf_b[1]+add : h;

function bushing_outer_radius(conf_b) = conf_b[1] + 4*single_wall_width;

// basic building blocks, housings for 1 bushing/bearing
// at [0,0] there is center of the smooth rod, pointing in Z

module linear_bushing_negative_single(conf_b=bushing_xy, h=0){
    // barrel with the dimensions of a bushing/bearing
    // to be substracted as needed
    translate([0, 0, -0.01])  cylinder(r = conf_b[1], h = adjust_bushing_len(conf_b, h) + 0.02);
}

module linear_bearing_negative_single(conf_b=bushing_xy, h=0){
    // as above but moved by 3 layers up
    translate([0, 0, -0.01+3*layer_height])  cylinder(r = conf_b[1], h = adjust_bushing_len(conf_b, h) + 0.02);
}

module linear_bushing_single(conf_b=bushing_xy, h=0) {
    // This is the printed barrel around bushing
    // with foot pointing to -x
    translate([-bushing_foot_len(conf_b), -7, 0]) cube([bushing_foot_len(conf_b), 14, adjust_bushing_len(conf_b, h)]);
    cylinder(r=bushing_outer_radius(conf_b), h=adjust_bushing_len(conf_b, h));
}

module linear_bushing_negative(conf_b=bushing_xy, h=0){
    // return simple negative stretched all along and a smooth rod
    translate([0,0,-0.1]) cylinder(r = conf_b[0] + single_wall_width, h=adjust_bushing_len(conf_b, h)+0.2);
    linear_bushing_negative_single(conf_b, h=adjust_bushing_len(conf_b, h));
}

module linear_bearing_negative(conf_b = bushing_xy, h = 0){
    //same as linear_bushing_negative, but with z direction constrained parts
    translate([0,0,-0.1]) cylinder(r = conf_b[0] + single_wall_width, h=adjust_bushing_len(conf_b, h, 8*layer_height)+0.2);
    //lower bearing
    linear_bearing_negative_single(conf_b);
    if (h > 2*conf_b[2] + 9*layer_height){
        translate([0,0,h]) mirror([0,0,1]) linear_bearing_negative_single(conf_b);
    }
}

module linear_negative_preclean(conf_b = bushing_xy) {
    // makes sure there is nothing interfering
    // to be substracted before linear()
    cylinder(r = conf_b[1] + single_wall_width, h=300, center=true);
}

module linear_bushing_sloped(conf_b=bushing_xy, h= 100){
    // cut the bushing at angle, so it can be printed upside down
    intersection(){
        linear_bushing_single(conf_b, h = h);
        // hardcoded, may need fixing for different barelled bushings
        // atm there is only one and I am too lazy
        translate([0, 0, -2]) rotate([0,-50,0]) cube([30, 40, 80], center=true);
    }
}

module linear_bushing(conf_b=bushing_xy, h=0){
    // this is the function to be used for type 1 linears (barrel holder)
    // It has bushing on bottom and for parts longer than 3x the barel length on top too
    difference() {
        union() {
            translate([-bushing_foot_len(conf_b), -7, 0]) cube([2, 14, adjust_bushing_len(conf_b, h)]);
            linear_bushing_single(conf_b);
            if (h>3*conf_b[2]) {
                translate([0,0,h]) mirror([0,0,1]) linear_bushing_sloped(conf_b);
            }
        }
        linear_bushing_negative(conf_b, h);
    }
}

module linear_bearing(conf_b=bushing_xy, h=0){
    difference() {
        union() {
            difference(){
                union(){
                    //main block
                    //translate([-bushing_foot_len(conf_b), -7, 0]) cube([4, 14, adjust_bushing_len(conf_b, h, 9*layer_height)]);   <- removed for duplicity:)
                    translate([0,0,0]) cylinder(h = adjust_bushing_len(conf_b, h, 9*layer_height), r=bushing_outer_radius(conf_b), $fn=60);
                }
                //smooth entry cut
                translate([12,0,-1]) rotate([0,0,45]) cube([20, 20, 200], center=true);
            }
            intersection(){
                translate([0, -(bushing_outer_radius(conf_b)), 0]) cube([100, 2*bushing_outer_radius(conf_b) , 200]);
                union() {
                    // upper clamp for long holders
                    if (h > 2*conf_b[2] + 9*layer_height || conf_b[2] > 45){
                        //translate ([0,0, max(h, conf_b[2]) - 8 ]) bearing_clamp(conf_b, 2*(bushing_outer_radius(conf_b)));
                        translate ([0,0, h-(conf_b[2]+9*layer_height)]) bearing_clamp2(conf_b, w1=2*bushing_outer_radius(conf_b), w2=2*bushing_outer_radius(conf_b)-4*single_wall_width, h=conf_b[2]+9*layer_height);
                        translate ([0,0, (conf_b[2]+9*layer_height)]) bearing_clamp_brick2(conf_b, w1=2*bushing_outer_radius(conf_b), w2=2*bushing_outer_radius(conf_b)-4*single_wall_width, h=h-((conf_b[2]+9*layer_height)*2));
                    }
                    //lower clamp
						bearing_clamp2(conf_b, w1=2*bushing_outer_radius(conf_b), w2=2*bushing_outer_radius(conf_b)-4*single_wall_width, h=conf_b[2]+9*layer_height);
                    //translate ([0, 0, 10]) bearing_clamp(conf_b, 2*(bushing_outer_radius(conf_b)));
                }
            }
        }
        //main axis
        translate([0,0,-2]) cylinder(h = adjust_bushing_len(conf_b, h)+10, r=conf_b[1]);
        //main cut
        translate([0, -conf_b[1]+1, -1]) cube([30, 2*conf_b[1]-2, 200]);
    }
    difference() {
        translate([-bushing_foot_len(conf_b), -7, 0]) cube([4, 14, adjust_bushing_len(conf_b, h, 9*layer_height)]);
        linear_negative(conf_b, h);
    }
}

// this should be more parametric
module firm_foot(conf_b){
    difference(){
        union() {
            translate([8.5/2,0,0]) cube_fillet([8.5, 42 + xy_delta * 2, 20], top=[11, 0, 11, 0], center=true);
        }
        translate([9, 14.5 + xy_delta, 0]) rotate([0, -90, 0]) screw(head_drop=1);
        translate([9,-14.5 - xy_delta, 0]) rotate([0,-90,0]) screw(head_drop=1);
    }
}

module y_bearing(conf_b=bushing_xy){

    difference() {
        union() {
            difference() {
                union() {
                    translate([-bushing_foot_len(conf_b), 0, 10]) firm_foot();
                    if (bushing_xy[2] > 45) {
                        translate([-bushing_foot_len(conf_b), 0, adjust_bushing_len(bushing_xy, 45) - 8]) mirror([0, 0, 1]) firm_foot();
                    }
                }
                linear_negative_preclean();
            }
            linear();
        }
        //linear_negative(bushing_xy, 20);
    }
}

module bearing_clamp_brick(conf_b, h){
    translate([-(m4_nut_diameter/2+conf_b[1]), 0, 0])
        #cube([m4_nut_diameter + 2 * conf_b[1], m4_nut_diameter + 1, h], center = true);
}

module bearing_clamp(conf_b=bushing_xy, h=0){
    // inspired by John Ridley and Jonas Kühling
    rotate([90, 0, 0]) {
        difference(){
            union(){
                translate([m3_diameter / 2 + conf_b[1] + 0.3, 0, 0])
                    cylinder(h=h, r = m4_nut_diameter / 2 + 0.5, center = true);
                translate([m3_diameter / 2 + conf_b[1] + 0.3, 0, 0]) {
                    bearing_clamp_brick(conf_b, h);
                    rotate([0,0,35])
                        bearing_clamp_brick(conf_b, h);
                }
            }
            translate([m3_diameter / 2 + conf_b[1] + 0.3, 0, 0]) {
                cylinder(r=m3_diameter / 2, h=h+2, center=true);
                %cylinder(r=m3_diameter / 2, h=h+2, center=true);
            }
        }
    }
}

module bearing_clamp_brick2(conf_b=bushing_xy, w1=0, w2=0, h=bushing_xy[2]+9*layer_height){
	difference() {
	translate([(conf_b[1]+m3_nut_diameter+0.3)/2,0,h/2]) cube([conf_b[1]+m3_nut_diameter+0.3,w1, h],center=true);
	translate([(conf_b[1]+m3_nut_diameter+0.3),((w2)/2),-0.5]) rotate([0,0,90-atan(((w1-w2)/2)/(conf_b[1]+m3_nut_diameter+0.3))]) cube([(w1-w2)/2, sqrt( pow((conf_b[1]+m3_nut_diameter+0.3), 2) + pow((w1-w2)/2, 2)), h+1]);
	translate([(conf_b[1]+m3_nut_diameter+0.3),-(w2/2),-0.5]) mirror([0,1,0]) rotate([0,0,90-atan(((w1-w2)/2)/(conf_b[1]+m3_nut_diameter+0.3))]) cube([(w1-w2)/2, sqrt( pow((conf_b[1]+m3_nut_diameter+0.3), 2) + pow((w1-w2)/2, 2)), h+1]);
	}
}

// w1 is outside dimensions, w2 is beveled dimensions
module bearing_clamp2(conf_b=bushing_xy, w1=0, w2=0, h=bushing_xy[2]+9*layer_height){
	difference() {
		bearing_clamp_brick2(conf_b,w1,w2,h);
		
            translate([m3_diameter / 2 + conf_b[1] + 0.3, 0, h/2]) rotate([90,0,0]) %cylinder(r=m3_diameter / 2, h=w1+2, center=true);

		// nut trap
		translate([m3_diameter / 2 + conf_b[1] + 0.3, -(w2/2), h/2])
			rotate([90,0,0])
				cylinder(r=m3_nut_diameter_horizontal/2, h=((w1-w2)/2)+1,$fn=6);
	
		// screw head hole
		translate([m3_diameter / 2 + conf_b[1] + 0.3, (w2/2), h/2])
			rotate([-90,0,0])
				cylinder(r=m3_washer_diameter/2, h=((w1-w2)/2)+1,$fn=20);

	}
}


module linear_negative(conf_b = bushing_xy, h = 0){
    //selects right negative based on type
    if (conf_b[3] == 0) {
        linear_bearing_negative(conf_b, h);
    } else {
        linear_bushing_negative(conf_b, h);
    }
}

module linear(conf_b = bushing_xy, h = 0){
    //selects right negative based on type
    if (conf_b[3] == 0) {
        linear_bearing(conf_b, h);
    } else {
        linear_bushing(conf_b, h);
    }
    %linear_negative(conf_b, h);
}

    y_bearing();
    //translate([0,52,0]) bearing_clamp2(w1=30,w2=20 );
    
    //translate([0,52,0]) linear();