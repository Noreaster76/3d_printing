include <ladder_perch.scad>;

$fn = 80;

perch_type = "diagonal ladder";

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

  if (perch_type == "diagonal ladder") {
    DiagonalLadderEntireAssembly();
  }

}
