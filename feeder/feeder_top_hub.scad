ring_diameter = 89;
ring_thickness = 4;
ring_height = 15;

module ring(diameter, thickness, height) {
  outer_radius = diameter / 2;
  inner_radius = outer_radius - thickness;
  difference() {
    // outer cylinder
    cylinder(height, outer_radius, outer_radius, false);
    // inner cylinder, which gets subtracted from the outer in order to
    // make a ring
    translate([0,0,-1]) {
      cylinder(17, inner_radius, inner_radius, false);
    };
  };
};

module offset_ring(diameter, thickness, height) {
  translate([diameter - thickness, 0, 0]) {
    ring(diameter, thickness, height);
  };
}

module screw_hole() {
  // one cylinder emanating from the z-axis that will be subtracted
  // from a ring to create a hole for a nut and bolt
  translate([0,0, ring_height/2]) {
    rotate([0,90,0]) {
      cylinder(100, 2, 2, false);
    };
  };
};

module basic_inner_hub() {
  // center ring
  ring(ring_diameter, ring_thickness, ring_height);

  difference() {
    intersection() {

      union() {
        // three rings around the outside of the center ring
        offset_ring(ring_diameter, ring_thickness, ring_height);
        rotate([0,0,120]) {
          offset_ring(ring_diameter, ring_thickness, ring_height);
        };
        rotate([0,0,240]) {
          offset_ring(ring_diameter, ring_thickness, ring_height);
        };
      };

      // bounding cylinder to cut off everything but the innermost
      // arcs of the rings around the outside
      cylinder(20, 70, 70, false);
    };

    // screw holes
    union() {
      screw_hole();
      rotate([0,0,120]) {
        screw_hole();
      };
      rotate([0,0,240]) {
        screw_hole();
      };
    };
  };
};

basic_inner_hub();

