// an attachment that goes on the back of the makita sander
// and accommodates the hose from the shopvac

$fn=50;

difference() {
  // centered at origin
  translate([-15.5,-4.5,0]) {
    // positive, outside volume to accommodate port on sander
    minkowski() {
      cube([31,9,1]);
      cylinder(r=2.5,h=1);
    };
  };

  // centered at origin
  translate([-14.6,-3.75,-0.5]) {
    // negative, inside space to accommodate port on sander
    minkowski() {
      cube([29.2,7.5,2]);
      cylinder(r=1.5,h=2);
    };
  };

};


