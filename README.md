3d-printer
==========

Repository for my 3d printer design based off of aluminum extrusions.

Do NOT CGAL render 8020_printer2.scad it will crash, too many faces and it's too complex.
rod_mounts.scad Is the smooth rod mounts for the X and Y axis, and the Y idler
motor_mounts.scad will give you the motor mounts for the X and Y axis
bushing.scad will give you the y axis bed bearing mounts
x-end.scad will give you the x idler and X motor mounts.
y-belt-holder.scad will give you the Y axis belt clamps.
x-carriage.scad will give you the X carriage.

Make sure to edit configuration.scad for your belt type, extrusion type, extrusion mounting screw, pulley type, bushing type, idler bearing type, and extrusion lengths (it will calculate rod lengths based off this)
