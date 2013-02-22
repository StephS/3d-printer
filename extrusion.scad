
include <configuration.scad>

center=true;

module extrusion(center=true,length=extrusion_width) {
	difference() {
		union(){
			for (i=[0:3]) {
	           		rotate([0, 0, 90*i]) translate([extrusion_width/2-extrusion_thin_wall/2, extrusion_width/2-extrusion_wall_width/2, 0]) color("silver") cube([extrusion_thin_wall,extrusion_wall_width,length], center = center);
				rotate([0, 0, 90*i]) translate([extrusion_width/2-extrusion_wall_width/2, extrusion_width/2-extrusion_thin_wall/2, 0]) color("silver") cube([extrusion_wall_width,extrusion_thin_wall,length], center = center);
				rotate([0, 0, 90*i]) translate([extrusion_width/2-extrusion_corner_square_width/2, extrusion_width/2-extrusion_corner_square_width/2, 0]) color("silver") cube([extrusion_corner_square_width,extrusion_corner_square_width,length], center = center);
			}
				rotate([0, 0, 45]) color("silver") cube([extrusion_thin_wall,(extrusion_width-(sin(45)*extrusion_thin_wall))/cos(45),length], center = center);
				rotate([0, 0, -45]) color("silver") cube([extrusion_thin_wall,(extrusion_width-(sin(45)*extrusion_thin_wall))/cos(45),length], center = center);
				color("silver") cube([extrusion_center_square,extrusion_center_square,length], center = center);
			}
			cylinder(h=length+1,r=extrusion_hole_dia/2,center=center);
		}
}

extrusion(length=extrusion_width*3);
echo((extrusion_width-(sin(45)*extrusion_thin_wall)));
echo((extrusion_width-(sin(45)*extrusion_thin_wall))/cos(45));