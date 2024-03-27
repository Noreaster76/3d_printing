perch_thickness = 2.5;

module Perch(distance_up_from_xy_plane) {
  translate([11,0,distance_up_from_xy_plane]) {
    rotate([90,0,0]) {
      cylinder(57, perch_thickness, perch_thickness, true);
    };
  };
};

// cube for clipping off excess of perch assembly inside main tube
module ClippingCube(outer_radius) {
    color("purple", 0.7) {
        translate([0,0,-10])
            cube([outer_radius * 2, outer_radius * 2, 20], true);
    }
}
