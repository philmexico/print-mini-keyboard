width = 67;
length = 61;
height = 10.7;
radius_front = 17;
length_front = 15;
top_indent = 3; // for later; how much of the tip of the mouth goes in
thickness = 1.8;
tooth_width = 7.2;
tooth_height = .65;
tooth_length = 5.5;
tooth_distance = 6.5;
tooth_thickness = 1;
tooth_hook_radius = 1;

printer_tolerance = .2;

module bottom_plate() {
    difference(){
        cube([width, length, thickness]);
        translate([tooth_width, tooth_width, 0])cube([width - 2 * tooth_width, length - 2 * tooth_width, thickness]);
    }
}

module front() {
    difference() {
        // start with the cylinder
        translate([0, length, radius_front])rotate([0, 90, 0])cylinder(h = width, r = radius_front);

        // convert cylinder into tube
        translate([0, length, radius_front])rotate([0, 90, 0])cylinder(h = width, r = radius_front - thickness);

        // cut off top - front
        translate([0, length, height])cube([width, length + length_front, width * 2]);

        // cut off top - back
        translate([0, -length, thickness])cube([width, length * 2, length * 2]);
    }
}

module teeth() {
    translate([tooth_distance, -tooth_length, thickness])cube([tooth_width, tooth_length, tooth_thickness]);
    translate([tooth_distance, -tooth_length + tooth_hook_radius, thickness])rotate([0, 90, 0])cylinder(h = tooth_width, r = tooth_hook_radius);
    translate([tooth_distance, -.25, thickness + .03])rotate([-15, 0, 0])cube([tooth_width, tooth_length, tooth_thickness]);

    translate([width - tooth_width - tooth_distance, -tooth_length, thickness])cube([tooth_width, tooth_length, tooth_thickness]);
    translate([width - tooth_width - tooth_distance, -tooth_length + tooth_hook_radius, thickness])rotate([0, 90, 0])cylinder(h = tooth_width, r = tooth_hook_radius);
    translate([width - tooth_width - tooth_distance, -.25, thickness + .03])rotate([-15, 0, 0])cube([tooth_width, tooth_length, tooth_thickness]);

    translate([tooth_distance + printer_tolerance, length + radius_front - tooth_length, height - tooth_thickness])cube([tooth_width, tooth_length / 2, tooth_thickness]);
//    translate([tooth_distance, -tooth_length + tooth_hook_radius, thickness])rotate([0, 90, 0])cylinder(h = tooth_width, r = tooth_hook_radius);
    translate([width - tooth_width - tooth_distance - printer_tolerance, length + radius_front - tooth_length, height - tooth_thickness])cube([tooth_width, tooth_length / 2, tooth_thickness]);
}

module nothing() {
    rotate([0, 90, 0])translate([0, length, 0])cylinder(h = width, r = width);
    
    difference() {
        cube([width, length, height]);
        translate([5, 5, 1])cube([width - 10, length - 10, height]);
    }
}

bottom_plate();
front();
teeth();

//    translate([5, 5, 1])cube([width - 10, length - 10, heigth]);

// just for reference
/*
color(c = "red")translate([0, length + length_front, 0])cube([width, 20, height]);
color(c = "red")translate([width, length, 0])cube([10, 15, height]);
//*/
