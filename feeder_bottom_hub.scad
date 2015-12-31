include <feeder_top_hub.scad>;

union() {
  basic_inner_hub();

  difference() {
    difference() {
      ring(ring_diameter - (ring_thickness * 1.95), ring_thickness, ring_height * 3);
      translate([0,0,-1]) {
        ring(ring_diameter - (ring_thickness * 3), ring_thickness, ring_height * 4);
      };
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
