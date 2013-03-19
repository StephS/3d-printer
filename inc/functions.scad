// PRUSA iteration3
// Functions used in many files
// GNU GPL v3
// Josef Pr?ša <josefprusa@me.com>
// Václav 'ax' H?la <axtheb@gmail.com>
// Vlnofka <>
// http://www.reprap.org/wiki/Prusa_Mendel
// http://github.com/prusajr/PrusaMendel

module chamfer(x=10,y=10,z=10) {
 rotate(a=[90,-90,0])
 linear_extrude(height = y, center = true, convexity = 2, twist = 0)
 polygon(points = [
[-1.00,-1.00]
,[-1.00,x-1.00]
,[0.00,x]
,[z,0.00]
,[z-1.00,-1.00]
]
,paths = [
[0,1,2,3,4]]
       );
}

// This will size an outer diameter to fit inside dia with $fn sides
// use this to set the diameter before passing to polyhole
function hole_fit( dia=0,$fn=0) = dia/cos(180/(($fn>0) ? $fn : 0.01));

// This determines the number of sides of a hole that is printable
// I added +1 because nobody wants to print a triangle. (plus it looks nicer, havn't tested printability yet.)
function poly_sides(d) = (max(round(2 * d),3)+1);

// Based on nophead research
module polyhole(d, d1, d2, h, center=false, $fn=0) {
    n = max((($fn>0) ? $fn : poly_sides(d)), (($fn>0) ? $fn : poly_sides(d1)), (($fn>0) ? $fn : poly_sides(d2)));
    cylinder(h = h, r = (d / 2), r1 = (d1 / 2), r2 = (d2 / 2), $fn = n, center=center);
}

// make it interchangeable between this and cylinder
module cylinder_poly(r, r1, r2, h, center=false, $fn=0){
    polyhole(d=r*2, d1=r1*2, d2=r2*2, h=h, center=center, $fn=$fn);
}

module cylinder_slot(r=0, r1, r2, h, length=0, center=false, $fn=0) {
	n = ($fn > 0) ? $fn : max(poly_sides(r*2), poly_sides(r1*2), poly_sides(r2*2));
	
	union() {
		rotate([0,0, 180/n]) cylinder_poly(h=h, r=r, r1=r1, r2=r2, center=center, $fn=n);
		if (length>0) {
			translate([((center) ? length/2 : 0),((center) ? 0 : -((r>0) ? r : r1)*cos(180/n)), 0]) trapezoid(cube=[length, ((r>0) ? r*2 : r1*2) *cos(180/n),h], y1=(r1-r2)*cos(180/n), y2=(r1-r2)*cos(180/n), center=center);
			//cube([length, dia*cos(180/n),h]);
			translate([length, 0, 0]) rotate([0,0, 180/n]) cylinder_poly(h=h, r=r, r1=r1, r2=r2, center=center, $fn=n);
		}
	}
}

module trapezoid(cube=[10, 10, 10], x1=0, x2=0, y1=0, y2=0, center=false) {
	translate((center) ? [0,0,0] : [cube[0]/2, cube[1]/2, cube[2]/2] ) {
		difference() {
			translate([0, 0 ,0]) cube(cube, center=true);
			if (x2 >0 ) translate([cube[0]/2, -(cube[1]+0.1)/2, -cube[2]/2]) rotate([0,-atan(x2/cube[2]),0]) cube([x2*cos(atan(x2/cube[2]))+0.1, cube[1]+0.1, sqrt( pow(cube[2], 2) + pow(x2, 2))]);
			if (x1 >0 ) translate([-cube[0]/2, -(cube[1]+0.1)/2, -cube[2]/2]) rotate([0,atan(x1/cube[2]),0]) translate([ -(x1*cos(atan(x1/cube[2]))+0.1), 0, 0]) cube([x1*cos(atan(x1/cube[2]))+0.1, cube[1]+0.1, sqrt( pow(cube[2], 2) + pow(x1, 2))]);
			if (y1 >0 ) translate([-(cube[0]+0.1)/2, -cube[1]/2, -cube[2]/2]) rotate([-atan(y1/cube[2]),0,0]) translate([ 0, -(y1*cos(atan(y1/cube[2]))+0.1), 0]) cube([cube[0]+0.1, y1*cos(atan(y1/cube[2]))+0.1, sqrt( pow(cube[2], 2) + pow(y1, 2))]);
			if (y2 >0 ) translate([-(cube[0]+0.1)/2, cube[1]/2, -cube[2]/2]) rotate([atan(y2/cube[2]),0,0]) cube([cube[0]+0.1, y2*cos(atan(y2/cube[2]))+0.1, sqrt( pow(cube[2], 2) + pow(y2, 2))]);
		}
	}
}

module fillet(radius, height=100, $fn=0) {
    //this creates acutal fillet
    n = ($fn>0) ? $fn : (ceil(poly_sides(radius*2)/4)*4);
    translate([-radius, -radius, -height/2-0.01])
        difference() {
            cube([radius*2, radius*2, height+0.02]);
            cylinder(r=radius, h=height+0.02, $fn=n);
        }
}

module cube_fillet(size, radius=-1, vertical=[3,3,3,3], top=[0,0,0,0], bottom=[0,0,0,0], center=false, $fn=0){
    //
    render(convexity = 2)
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