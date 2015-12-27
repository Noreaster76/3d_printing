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

  // outer tube that goes around the inside of the bottom opening of the PVC pipe
  difference(){
    // outer cylinder
    cylinder(22, 19.75, 19.75, false);
    // have the inner cylinder extend 1 unit in each direction along the
    // z-axis in order to extend beyond the ends of the outer cylinder.
    // this will leave no ambiguity about whether the ends of the tube should
    // be open or closed.
    translate([0,0,-1]) {
      // inner cylinder that gets subtracted from the outer cylinder
      cylinder(24, 17.25, 17.25, false);
    }
  };

  // translate it up the z-axis to the top of the outer and inner cylinders.
  translate([0,0,20]) {
    difference() {
      // disk with a hole in the middle that joins the outer tube and
      // inner tube that go around the outside and inside, respectively,
      // of the bottom of the PVC pipe.
      cylinder(2, 27.5, 27.5, false);
      translate([0,0,-1]) {
        cylinder(4, 17.25, 17.25, false);
      }
    }
  }

}
