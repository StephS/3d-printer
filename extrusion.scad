
include <configuration.scad>

ex_corner_square_width = (extrusion[0]-extrusion[2])/2;
ex_wall_width=(extrusion[0]-extrusion[1])/2;

module extrusion(center=true,length=extrusion[0]) {
	difference() {
		color("silver") render(convexity = 8) union(){
			for (i=[0:3]) {
	           	rotate([0, 0, 90*i]) translate([extrusion[0]/2-extrusion[3]/2, extrusion[0]/2-ex_wall_width/2, 0]) cube([extrusion[3],ex_wall_width,length], center = center);
				rotate([0, 0, 90*i]) translate([extrusion[0]/2-ex_wall_width/2, extrusion[0]/2-extrusion[3]/2, 0]) cube([ex_wall_width,extrusion[3],length], center = center);
				rotate([0, 0, 90*i]) translate([extrusion[0]/2-ex_corner_square_width/2, extrusion[0]/2-ex_corner_square_width/2, 0]) cube([ex_corner_square_width,ex_corner_square_width,length], center = center);
			}
				rotate([0, 0, 45]) cube([extrusion[3],(extrusion[0]-(sin(45)*extrusion[3]))/cos(45),length], center = center);
				rotate([0, 0, -45]) cube([extrusion[3],(extrusion[0]-(sin(45)*extrusion[3]))/cos(45),length], center = center);
				cube([extrusion[4],extrusion[4],length], center = center);
			}
			cylinder(h=length+1,r=extrusion[5]/2,center=center);
		}
}

extrusion(length=extrusion[0]*3);
echo((extrusion[0]-(sin(45)*extrusion[3])));
echo((extrusion[0]-(sin(45)*extrusion[3]))/cos(45));