// this is the design for a model of a vacuum attachment for
// a ryobi fixed base router.

$fn=100;

diameter_of_vacuum_nozzle_in_mm = 48;
diameter_of_screws_in_mm = 3.1;
diameter_of_flange_in_mm = 10;
distance_between_router_screw_holes_in_mm = 85;
thickness_in_mm = 2;

function convert_to_radius(diameter) = diameter / 2;

module DifferenceOfTwoCylinders(height,
    first_cylinder_diameter,
    second_cylinder_diameter) {

  difference() {
    cylinder(thickness_in_mm, d = diameter_of_flange_in_mm, center = true);
    translate([0,0,-0.1]) {
      cylinder(thickness_in_mm * 2, d = diameter_of_screws_in_mm, center = true);
    };
  };
};

module Flange() {
  DifferenceOfTwoCylinders(thickness_in_mm,
    diameter_of_flange_in_mm,
    diameter_of_screws_in_mm);
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

// all the parts!

TranslatedFlange();
mirror([1,0,0]) TranslatedFlange();

