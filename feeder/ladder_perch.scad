include <perch_common.scad>;

module PerchSupport() {
  cylinder(125, perch_thickness, perch_thickness, false);
}

module PerchSupportAtEdgeOfTube() {
  // rotate it around the z-axis.
  rotate([0,0,30]) {
    // move the perch support to the outside of the tube.
    translate([0,-21.5,0]) {
      PerchSupport(){};
    };
  };
};

module PerchSupportAtEdgeOfTubeAtEightOClock() {
  PerchSupportAtEdgeOfTube();
};
module PerchSupportAtEdgeOfTubeAtFourOClock() {
  mirror([0,1,0]) {
    PerchSupportAtEdgeOfTube();
  };
};

module ClippedPerch(distance_up_from_xy_plane) {
  intersection() {
    translate([0,0,20]) {
      hull() {
        PerchSupportAtEdgeOfTubeAtEightOClock();
        PerchSupportAtEdgeOfTubeAtFourOClock();
      };
    };
    Perch(distance_up_from_xy_plane);
  };
};

module DiagonalLadderEntireAssembly() {
    difference() {
        // perch assembly
        translate([-13,0,0]) {
            // rotate it around the y-axis.
            rotate([0,60,0]) {
                union() {
                    // the two perch supports that extend parallel to the axis of the
                    // tube opening.
                    PerchSupportAtEdgeOfTubeAtEightOClock();
                    PerchSupportAtEdgeOfTubeAtFourOClock();

                    // Perches
                    ClippedPerch(50);
                    ClippedPerch(75);
                    ClippedPerch(100);
                    ClippedPerch(125);
                };
            };
        };

        ClippingCube(outer_radius);
    };
};
