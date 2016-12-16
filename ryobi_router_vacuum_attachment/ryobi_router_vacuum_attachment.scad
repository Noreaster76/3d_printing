// this is the design for a model of a vacuum attachment for
// a ryobi fixed base router.

$fn=100;

diameter_of_vacuum_nozzle_in_mm = 48;
diameter_of_screws_in_mm = 3.1;
diameter_of_flange_in_mm = 10;
distance_between_router_screw_holes_in_mm = 85;
thickness_in_mm = 2;
width_of_little_straight_part_of_flange = 5;

function convert_to_radius(diameter) = diameter / 2;

module ScrewHole() {
  translate([0,0,-0.1]) {
    cylinder(thickness_in_mm * 2, d = diameter_of_screws_in_mm, center = true);
  };
};

module Flange() {
  difference() {
    hull() {
      cylinder(thickness_in_mm, d = diameter_of_flange_in_mm, center = true);
      // a little straight part extending back from the flange disc to the origin
      translate([-width_of_little_straight_part_of_flange,0,0]) {
        cube([
            width_of_little_straight_part_of_flange,
            diameter_of_flange_in_mm,
            thickness_in_mm
        ], center = true);
      };
    };
    ScrewHole();
  };
};

module ShopVacHoseReceptacle() {
  // something to fit over shopvac hose
  linear_extrude(height = 45) {
    difference() {
      circle(d = 48);
      circle(d = 45);
    };
  };
};

module TranslatedFlange() {
  translate([distance_between_router_screw_holes_in_mm / 2, 0, 0]) {
    Flange();
  };
};

module ArchFragment() {
  // ? not sure how to calculate this
  distance_to_translate_arch_cross_section = (distance_between_router_screw_holes_in_mm / 2) - (width_of_little_straight_part_of_flange * 1.5);

  rotate([90, 0, 0])
    rotate_extrude(angle=50)
    translate([distance_to_translate_arch_cross_section,0,0])
    color("cyan")
    rotate([0,0,90])
    square([diameter_of_flange_in_mm, thickness_in_mm], center = true);
};

module TranslatedFlangePlusArchFragment() {
  union() {
    TranslatedFlange();
    ArchFragment();
  };
};

// all the parts!

TranslatedFlangePlusArchFragment();
mirror([1,0,0]) TranslatedFlangePlusArchFragment();

translate([0,0,20])
  ShopVacHoseReceptacle();

