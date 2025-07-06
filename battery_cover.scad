$fn = 50;

width = 66.5;
length = 43.5;
height = 11;

radius_front = 17;
front_length = 15;

rounded_corner_radius = 6;

top_indent = 3; // for later; how much of the tip of the mouth goes in

thickness = 1.9;
tooth_width = 7.2;
tooth_height = .65;
tooth_length = 5.5;
tooth_distance = 6.5;
tooth_thickness = 1;
tooth_hook_radius = .6;

printer_tolerance = .2;

rounding_radius_small = 1;

module bottom_plate() {
    difference(){
        cube([width, length, thickness]);
        cube([rounding_radius_small, rounding_radius_small, thickness]);
        translate([width - rounding_radius_small, 0, 0])cube([rounding_radius_small, rounding_radius_small, thickness]);
        // save filament for test
        translate([tooth_width, tooth_width, 0])cube([width - 2 * tooth_width, length - 2 * tooth_width, thickness]);
    }
    translate([rounding_radius_small, rounding_radius_small, 0])cylinder(h = thickness, r = rounding_radius_small);
    translate([width - rounding_radius_small, rounding_radius_small, 0])cylinder(h = thickness, r = rounding_radius_small);
}

module front() {
    difference() {
        // start with the cylinder
        translate([0, length, radius_front])rotate([0, 90, 0])cylinder(h = width, r = radius_front);

        // convert cylinder into tube
        translate([0, length, radius_front])rotate([0, 90, 0])cylinder(h = width, r = radius_front - thickness);

        // cut off top - front
        translate([0, length, height])cube([width, length + front_length, width * 2]);

        // cut off top - back
        translate([0, -length, thickness])cube([width, length * 2, length * 2]);


        // save filament for test
        translate([tooth_width, length, 0])cube([width - 2 * tooth_width, front_length - .5 * tooth_width, height]);
    }
}

module teeth() {
    translate([tooth_distance, -tooth_length, thickness + tooth_thickness / 2])rotate([-5, 0, 0])cube([tooth_width, tooth_length, tooth_thickness]);
    translate([tooth_distance, -tooth_length + tooth_hook_radius, thickness + tooth_thickness / 2])rotate([0, 90, 0])cylinder(h = tooth_width, r = tooth_hook_radius);
    translate([tooth_distance, -.25, thickness + .03])rotate([-15, 0, 0])cube([tooth_width, tooth_length, tooth_thickness]);

    translate([width - tooth_width - tooth_distance, -tooth_length, thickness + tooth_thickness / 2])rotate([-5, 0, 0])cube([tooth_width, tooth_length, tooth_thickness]);
    translate([width - tooth_width - tooth_distance, -tooth_length + tooth_hook_radius, thickness + tooth_thickness / 2])rotate([0, 90, 0])cylinder(h = tooth_width, r = tooth_hook_radius);
    translate([width - tooth_width - tooth_distance, -.25, thickness + .03])rotate([-15, 0, 0])cube([tooth_width, tooth_length, tooth_thickness]);

    translate([tooth_distance + printer_tolerance, length + radius_front - tooth_length, height - tooth_thickness])cube([tooth_width, tooth_length / 2, tooth_thickness]);
//    translate([tooth_distance, -tooth_length + tooth_hook_radius, thickness])rotate([0, 90, 0])cylinder(h = tooth_width, r = tooth_hook_radius);
    translate([width - tooth_width - tooth_distance - printer_tolerance, length + radius_front - tooth_length, height - tooth_thickness])cube([tooth_width, tooth_length / 2, tooth_thickness]);
}

    difference(){
  //      cylinder(h = thickness * 2, r = rounded_corner_radius + thickness * 2);
//        cylinder(h = thickness * 2, r = rounded_corner_radius);
    }
//        translate([0, 0, 0])cube([rounded_corner_radius, rounded_corner_radius + thickness * 2, thickness * 2]);
module cutting_tube() {
    difference(){
        cylinder(h = thickness * 2, r = rounded_corner_radius + thickness * 2);
        cylinder(h = thickness * 2, r = rounded_corner_radius);
        translate([0, -rounded_corner_radius - 2 * thickness, 0])cube([2 * rounded_corner_radius + thickness, (rounded_corner_radius + thickness * 2) * 2, thickness * 2]);
//        translate([-rounded_corner_radius - thickness, -3 * (rounded_corner_radius - thickness), rounded_corner_radius])cube([rounded_corner_radius + thickness, rounded_corner_radius + thickness, thickness * 2]);
        translate([-rounded_corner_radius - 2 * thickness, -rounded_corner_radius - 2 * thickness, 0])cube([rounded_corner_radius + 2 * thickness, rounded_corner_radius + 2 * thickness, thickness * 2]);
    }
}
//        translate([1.5 * rounded_corner_radius, length + front_length, height - rounded_corner_radius - 0 * thickness])scale([1.5, 1])rotate([60, 0, 0])translate([-rounded_corner_radius - thickness, -2 * (rounded_corner_radius - thickness), rounded_corner_radius - 2 * thickness])cube([rounded_corner_radius + thickness, rounded_corner_radius + thickness, thickness * 2]);
//translate([1.5 * rounded_corner_radius, length + front_length + 4 * thickness, height - 2 * thickness])scale([1.5, 1])rotate([60, 0, 0])translate([-rounded_corner_radius - thickness, -3 * (rounded_corner_radius - thickness), rounded_corner_radius])cube([rounded_corner_radius + thickness, rounded_corner_radius + thickness, thickness * 2]);
//cutting_tube();

module cutting_tube_backup() {
    rounded_corner_x_in = -2 * thickness;
    rounded_corner_y_in = length + front_length;
    rounded_corner_z_up = height - 2 * rounded_corner_radius + thickness;
    difference(){
        translate([2 * rounded_corner_radius - thickness, rounded_corner_y_in, rounded_corner_z_up])rotate([60, 0, 0])cylinder(h = thickness * 2, r = rounded_corner_radius + 2 * thickness);
        translate([2 * rounded_corner_radius - thickness, rounded_corner_y_in, rounded_corner_z_up])rotate([60, 0, 0])cylinder(h = thickness * 2, r = rounded_corner_radius + thickness);
//        translate([rounded_corner_radius + thickness, rounded_corner_y_in, rounded_corner_z_up])rotate([60, 0, 0])cylinder(h = thickness * 2, r = rounded_corner_radius);
        translate([radius_front / 1.5 + rounded_corner_x_in, length + front_length / 2, 0])cube([radius_front * 2, radius_front, radius_front * 2]);
    }
}

module rounded_front_() {
    rounded_corner_radius = 4;
    rounded_corner_x_in = -2 * thickness;
    rounded_corner_y_in = length + front_length;
    rounded_corner_z_up = height - 2 * rounded_corner_radius + thickness;
    difference(){
        translate([2 * rounded_corner_radius - thickness, rounded_corner_y_in, rounded_corner_z_up])rotate([60, 0, 0])cylinder(h = thickness * 2, r = rounded_corner_radius + 2 * thickness);
        translate([2 * rounded_corner_radius - thickness, rounded_corner_y_in, rounded_corner_z_up])rotate([60, 0, 0])cylinder(h = thickness * 2, r = rounded_corner_radius + thickness);
//        translate([rounded_corner_radius + thickness, rounded_corner_y_in, rounded_corner_z_up])rotate([60, 0, 0])cylinder(h = thickness * 2, r = rounded_corner_radius);
        translate([radius_front / 1.5 + rounded_corner_x_in, length + front_length / 2, 0])cube([radius_front * 2, radius_front, radius_front * 2]);
    }
    difference(){
        translate([width - radius_front / 2, length + front_length + thickness / 2, height - radius_front])rotate([90, 0, 0])cylinder(h = thickness * 2, r = radius_front + 2 * thickness);
        translate([width - radius_front / 2.5, length + front_length + thickness / 2, height - radius_front])rotate([90, 0, 0])cylinder(h = thickness * 2, r = radius_front);
        translate([width - 2.3 * radius_front, length + front_length / 2, 0])cube([radius_front * 2, radius_front, radius_front]);
    }
}
// rounded_front();

//    translate([5, 5, 1])cube([width - 10, length - 10, height]);

// just for reference
//*
//color(c = "red")translate([0, length + length_front, 0])cube([width, 20, height]);
//color(c = "red")translate([width, length, 0])cube([10, 15, height]);
//color(c = "red")translate([width, 61, 0])cube([10, 15, height]);
//*/

module main() {
    bottom_plate();
    difference(){
        front();
        translate([1.5 * rounded_corner_radius, length + front_length - 1 * thickness, height - rounded_corner_radius + .25 * thickness])scale([1.5, 1])rotate([60, 0, 0])cutting_tube();
    //    rounded_front();
    //    translate([1.5 * rounded_corner_radius, length + front_length + 4 * thickness, height - 2 * thickness])scale([1.5, 1])rotate([60, 0, 0])cutting_tube();
    //    translate([width - 1.5 * rounded_corner_radius, length + front_length, height - rounded_corner_radius - 0 * thickness])scale([1.5, 1])rotate([60, 0, 0])cutting_tube();

        translate([width - 1.5 * rounded_corner_radius, length + front_length - thickness, height - rounded_corner_radius + .25 * thickness])scale([-1.5, 1])rotate([60, 0, 0])cutting_tube();
    }
    teeth();
}

main();