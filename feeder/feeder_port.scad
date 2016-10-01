module PerchSupport() {
  cylinder(100, 3.5, 3.5, false);
}

module PerchSupportAtEdgeOfTube() {
  // rotate it around the z-axis.
  rotate([0,0,30]) {
    // move the perch support to the outside of the tube.
    translate([0,-28.5,0]) {
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

module Perch(distance_up_from_xy_plane) {
  translate([14,0,distance_up_from_xy_plane]) {
    rotate([90,0,0]) {
      cylinder(57, 3.5, 3.5, true);
    };
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

union() {

  // outer tube that goes around the outside of the bottom opening of the PVC pipe
  difference(){
    // outer cylinder
    cylinder(22, 27.5, 27.5, false);
    // have the inner cylinder extend 1 unit in each direction along the
    // z-axis in order to extend beyond the ends of the outer cylinder.
    // this will leave no ambiguity about whether the ends of the tube should
    // be open or closed.
    translate([0,0,-1]) {
      // inner cylinder that gets subtracted from the outer cylinder
      cylinder(24, 24.5, 24.5, false);
    }
  };

  // translate it up the z-axis to the top of the outer cylinders.
  translate([0,0,20]) {
    difference() {
      // disk with a hole in the middle that joins the outer tube and
      // inner tube that go around the outside and inside, respectively,
      // of the bottom of the PVC pipe.
      cylinder(2, 27.5, 27.5, false);
      translate([0,0,-1]) {
        cylinder(4, 19.75, 19.75, false);
      }
    }
  };

  intersection() {
    // face that covers half of the opening.
    translate([0,0,21]) {
      // move it down the x-axis so that it reveals half of the tube opening.
      translate([13.75, 0, 0]) {
        // create a rectangle that will obscure half of the tube opening,
        // centered on the origin.
        cube([27.5, 55, 2], true);
      }
    };
    // cylinder with a radius equal to that of the outer tube, for the
    // purpose of trimming off the parts of the tube face that extend
    // beyond the radius of the outer tube.
    cylinder(25, 27.5, 27.5, false);
  };

  // the two perch supports that extend parallel to the axis of the
  // tube opening.
  PerchSupportAtEdgeOfTubeAtEightOClock();
  PerchSupportAtEdgeOfTubeAtFourOClock();

  // Perches
  ClippedPerch(50);
  ClippedPerch(75);
  ClippedPerch(100);
}
