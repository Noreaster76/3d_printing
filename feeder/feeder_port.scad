$fn = 80;

perch_thickness = 2.5;

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

module Perch(distance_up_from_xy_plane) {
  translate([11,0,distance_up_from_xy_plane]) {
    rotate([90,0,0]) {
      cylinder(57, perch_thickness, perch_thickness, true);
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

// outer radius of main feeder port cylinder
outer_radius = 24;
// thickness of main feeder port cylinder
thickness = 2.5;
// inner radius of main feeder port cylinder
inner_radius = outer_radius - thickness;

union() {

  color("red", 0.8)
    translate([0, 0, -11])
    difference(){
    // tube that fits into the inside of the bottom opening of the PVC pipe
        difference(){
            // outer cylinder
            cylinder(22, outer_radius, outer_radius, true);
            // have the inner cylinder extend 1 unit in each direction along the
            // z-axis in order to extend beyond the ends of the outer cylinder.
            // this will leave no ambiguity about whether the ends of the tube should
            // be open or closed.
            translate([0,0,-10]) {
                // inner cylinder that gets subtracted from the outer cylinder
                cylinder(100, inner_radius, inner_radius, true);
            }

            // a cylinder to make a hole to accommodate a bolt
            // to keep the perch assembly in the PVC pipe
            translate([20, 0, 0])
                rotate([0, 90, 0])
                color("purple") cylinder(20, 3, 3, true);
        }
    };

  color("orange", 0.8)
    rotate_extrude(convexity = 10) {
      translate([outer_radius - thickness/2, 0, 0])
        circle(thickness/2);
    }

  intersection() {
    // face that covers part of the opening.
    translate([3,0,0]) {
      color("blue") {
        // for the purpose of adding a nice rounded edge
        minkowski() {
          translate([12,0,0]) {
            // this is the front face itself
            cube([outer_radius, 55, 3], true);
            // for the purpose of adding a nice rounded edge
            translate([-12, 0, 0]) rotate([90, 0, 0]) cylinder(55, 1.5, 1.5, true);
          }
        }
      }
    }
    // cylinder with a radius equal to that of the outer tube, for the
    // purpose of trimming off the parts of the tube face that extend
    // beyond the radius of the outer tube.
    color("green") {
      translate([0,0,-5]) {
        cylinder(25, outer_radius, outer_radius, false);
      }
    }
  };

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

    // cube for clipping off excess of perch assembly inside main tube
    color("purple", 0.7) {
      translate([0,0,-10])
        cube([outer_radius * 2, outer_radius * 2, 20], true);
    }
  };

}
