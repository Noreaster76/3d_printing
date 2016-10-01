// an attachment that goes on the back of the makita sander
// and accommodates the hose from the shopvac

$fn=100;

translate([0,0,25]) {
  // something to fit over shopvac hose
  linear_extrude(height = 45) {
    difference() {
      circle(d = 43.4);
      circle(d = 39.4);
    };
  };
};

// something to fit over sander dust output port
linear_extrude(height = 15, twist = 0, slices = 60) {

  // rounded rectangle of the proper dimensions
  difference() {
    // positive, outside volume to accommodate port on sander
    offset(r = 2.5) {
      square([29.2,7.5], center = true);
    };
    // negative, inside space to accommodate port on sander
    offset(r = 1.5) {
      square([29.2,7.5], center = true);
    };
  };
};


