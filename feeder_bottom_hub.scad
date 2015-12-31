include <feeder_top_hub.scad>;

union() {
  basic_inner_hub();

  // this is just to make sure there's no gap or other weakness
  // between the main ring and the tube that serves as a coupler between
  // the main ring and the PVC squirrel baffle.
  ring(ring_diameter - (ring_thickness * 1.9), ring_thickness, ring_height);

  difference() {
    difference() {
      ring(ring_diameter - (ring_thickness * 2), ring_thickness, ring_height * 3);
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
