ring_diameter = 89;
ring_thickness = 4;

module ring(diameter, thickness) {
  outer_radius = diameter / 2;
  inner_radius = outer_radius - thickness;
  difference() {
    // outer cylinder
    cylinder(15, outer_radius, outer_radius, false);
    // inner cylinder, which gets subtracted from the outer in order to
    // make a ring
    translate([0,0,-1]) {
      cylinder(17, inner_radius, inner_radius, false);
    };
  };
};

module offset_ring(diameter, thickness) {
  translate([diameter - thickness, 0, 0]) {
    ring(diameter, thickness);
  };
}

// center ring
ring(ring_diameter, ring_thickness);

// three rings around the outside of the center ring
offset_ring(ring_diameter, ring_thickness);
rotate([0,0,120]) {
  offset_ring(ring_diameter, ring_thickness);
};
rotate([0,0,240]) {
  offset_ring(ring_diameter, ring_thickness);
};
