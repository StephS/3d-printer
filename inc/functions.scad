// PRUSA iteration3
// Functions used in many files
// GNU GPL v3
// Josef Pr?ša <josefprusa@me.com>
// Václav 'ax' H?la <axtheb@gmail.com>
// Vlnofka <>
// http://www.reprap.org/wiki/Prusa_Mendel
// http://github.com/prusajr/PrusaMendel

include <nuts_screws.scad>;

module chamfer(x=10,y=10,z=10) {
 rotate(a=[90,-90,0])
 linear_extrude(height = y, center = true, convexity = 2, twist = 0)
 polygon(points = [
[-1.00,-1.00]
,[-1.00,x]
,[0.00,x]
,[z,0.00]
,[z,-1.00]
]
,paths = [
[0,1,2,3,4]]
       );
}

/*
module nut(d,h,horizontal=true){
    cornerdiameter =  (d / 2) / cos (180 / 6);
    cylinder(h = h, r = cornerdiameter, $fn = 6);
    if(horizontal){
        for(i = [1:6]){
            rotate([0,0,60*i]) translate([-cornerdiameter-0.2,0,0]) rotate([0,0,-45]) cube([2,2,h]);
        }
    }
}
*/

function poly_sides(d) = max(round(2 * d),3)+1;
// Based on nophead research
module polyhole(d, d1, d2, h, center=false, $fn=0) {
    n = max((($fn>0) ? $fn : poly_sides(d)), (($fn>0) ? $fn : poly_sides(d1)), (($fn>0) ? $fn : poly_sides(d2)));
    cylinder(h = h, r = (d / 2), r1 = (d1 / 2), r2 = (d2 / 2), $fn = n, center=center);
}

// make it interchangeable between this and cylinder
module cylinder_poly(r, r1, r2, h, center=false, $fn=0){
    polyhole(d=r*2, d1=r1*2, d2=r2*2, h=h, center=center, $fn=$fn);
}

module fillet(radius, height=100, $fn=0) {
    //this creates acutal fillet
    translate([-radius, -radius, -height/2-0.01])
        difference() {
            cube([radius*2, radius*2, height+0.02]);
            cylinder(r=radius, h=height+0.02, $fn=$fn);
        }
}

module cube_fillet(size, radius=-1, vertical=[3,3,3,3], top=[0,0,0,0], bottom=[0,0,0,0], center=false, $fn=0){
    //
    if (use_fillets) {
        if (center) {
            cube_fillet_inside(size, radius, vertical, top, bottom, $fn);
        } else {
            translate([size[0]/2, size[1]/2, size[2]/2])
                cube_fillet_inside(size, radius, vertical, top, bottom, $fn);
        }
    } else {
        cube(size, center);
    }

}

module cube_negative_fillet(size, radius=-1, vertical=[3,3,3,3], top=[0,0,0,0], bottom=[0,0,0,0], $fn=0){

    j=[1,0,1,0];

    for (i=[0:3]) {
        if (radius > -1) {
            rotate([0, 0, 90*i]) translate([size[1-j[i]]/2, size[j[i]]/2, 0]) fillet(radius, size[2], $fn=$fn);
        } else {
            rotate([0, 0, 90*i]) translate([size[1-j[i]]/2, size[j[i]]/2, 0]) fillet(vertical[i], size[2], $fn=$fn);
        }
        rotate([90*i, -90, 0]) translate([size[2]/2, size[j[i]]/2, 0 ]) fillet(top[i], size[1-j[i]], $fn=$fn);
        rotate([90*(4-i), 90, 0]) translate([size[2]/2, size[j[i]]/2, 0]) fillet(bottom[i], size[1-j[i]], $fn=$fn);

    }
}

module cube_fillet_inside(size, radius=-1, vertical=[3,3,3,3], top=[0,0,0,0], bottom=[0,0,0,0], $fn=0){
    //makes CENTERED cube with round corners
    // if you give it radius, it will fillet vertical corners.
    //othervise use vertical, top, bottom arrays
    //when viewed from top, it starts in upper right corner (+x,+y quadrant) , goes counterclockwise
    //top/bottom fillet starts in direction of Y axis and goes CCW too


    if (radius == 0) {
        cube(size, center=true);
    } else {
        difference() {
            cube(size, center=true);
            cube_negative_fillet(size, radius, vertical, top, bottom, $fn);
        }
    }
}


module nema17(places=[1,1,1,1], size=15.5, h=10, holes=false, shadow=false, head_drop=5, $fn=24){
    for (i=[0:3]) {
        if (places[i] == 1) {
            rotate([0, 0, 90*i]) translate([size, size, 0]) {
                if (holes) {
                    rotate([0, 0, -90*i]) screw_hole(type=screw_M3_socket_head, head_drop=head_drop, $fn=$fn, h=h);
                } else {
                    rotate([0, 0, -90*i]) cylinder(h=h, r=5.5, $fn=$fn);
                }
            }
        }
    }
    if (shadow != false) {
        %translate ([0, 0, shadow+3+42]) mirror([0,0,1]) nema17_motor();
    }
}

module nema17_motor(height=42, color=true) {
	union() {
        % translate ([0, 0, height/2]) cube([42,42,height], center = true);
	//flange
        % translate ([0, 0, height+1]) cylinder(r=11,h=2, center = true, $fn=20);
	//shaft
        % translate ([0, 0, height+7]) cylinder(r=2.5,h=14, center = true);
	}
}

module motor_plate(thickness=10, width=stepper_motor_width, head_drop=5){
	difference(){
		union(){
            // Motor holding part
            difference(){
				union(){
					nema17(places=[1,1,1,1], h=thickness);
					translate([0, 0, thickness/2]) cube([width,width,thickness], center = true);
				}

                // motor screw holes
				translate([0, 0, thickness]) mirror([0,0,1]) nema17(places=[1,1,1,1], holes=true, head_drop=head_drop, h=thickness, $fn=0);
						
				// center hole
				translate ([0, 0, thickness/2]) cylinder_poly(r=12,h=thickness+1, center = true);
            }
				translate([0, 0, -42]) nema17_motor();
        }
    }
}

module belt_pulley()
{
	difference() {
		union() {
			translate ([0, 0, pulley[1]/2]) cylinder(r=pulley[6]/2,h=pulley[1], center = true);
			translate ([0, 0, (pulley[0]-pulley[1]-pulley[2])/2/2+pulley[1]]) cylinder(r=pulley[7]/2,h=(pulley[0]-pulley[1]-pulley[2])/2, center = true);
			translate ([0, 0, pulley[1]+(pulley[0]-pulley[1]-pulley[2])/2+pulley[2]/2]) cylinder(r=pulley[5]/2,h=pulley[2], center = true);
			translate ([0, 0, pulley[1]+(pulley[0]-pulley[1]-pulley[2])/2+pulley[2]+(pulley[0]-pulley[1]-pulley[2])/2/2]) cylinder(r=pulley[7]/2,h=(pulley[0]-pulley[1]-pulley[2])/2, center = true);
		}
		translate ([0, 0, pulley[0]/2]) cylinder(r=2.5,h=pulley[0]+1, center = true);
	}
}

//radius of the idler assembly (to surface that touches belt, ignoring guide walls)
function idler_assy_r_inner(idler_bearing) = (idler_bearing[0] / 2) + 4 * single_wall_width * idler_bearing[3];
//radius of the idler assembly (to smooth side of belt)
function idler_assy_r_outer(idler_bearing) = (idler_bearing[0] / 2) + (idler_bearing[3] ? (5.5 * idler_bearing[3]) : 3);


module idler_assy(idler_bearing = [22, 7, 8, 1], idler_width=x_idler_width) {

    translate([0,0,-1]) cylinder(h = 120, r=idler_bearing[2]/2 + 1, $fn=7, center=true);
    //bearing shadow
    %cylinder(h = idler_bearing[1], r=idler_bearing[0]/2, center=true);

    cylinder(h = idler_width + 1, r=idler_assy_r_outer(idler_bearing), center=true);
}
