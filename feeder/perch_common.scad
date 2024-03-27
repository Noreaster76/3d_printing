perch_thickness = 2.5;

module Perch(distance_up_from_xy_plane) {
  translate([11,0,distance_up_from_xy_plane]) {
    rotate([90,0,0]) {
      cylinder(57, perch_thickness, perch_thickness, true);
    };
  };
};

