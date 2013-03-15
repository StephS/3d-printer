include <configuration.scad>

module feet(height=stepper_motor_height-extrusion[0]+5) {
	difference() {
	translate([0,0,height/2]) cube_fillet([extrusion[0], extrusion[0], height],vertical=[extrusion[0]/3,extrusion[0]/3,extrusion[0]/3,extrusion[0]/3], center=true);
	translate([0,0,height]) rotate([180,0,0]) screw_hole(type=ex_screw,h=support_wall_thickness+1, head_drop=height-support_wall_thickness);
	}
}

feet();