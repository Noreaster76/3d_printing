// an attachment that goes on the back of the makita sander
// and accommodates the hose from the shopvac

$fn=100;

module ShopVacHoseReceptacle() {
  // something to fit over shopvac hose
  linear_extrude(height = 45) {
    difference() {
      circle(d = 43.4);
      circle(d = 39.4);
    };
  };
};

module ShapeForJoinerOfTwoParts() {
  // a shape to join the two objects together
  color("LightBlue")
    hull() {
      translate([0,0,25.1]) {
        linear_extrude(0.01, center = true) circle(d = 41.3);
      };
      // negative, inside space to accommodate port on sander
      linear_extrude(0.01, center = true) {
        offset(r = 1.5) {
          square([29.1,7.4], center = true);
        };
      };
    };
};

module JoinerOfTwoParts() {
  difference() {
    scale(v = [1.05, 1.05, 1.05]) ShapeForJoinerOfTwoParts();
    translate([0,0,-0.5]) scale(v = [1,1,1.1]) ShapeForJoinerOfTwoParts();
  };
};

module MakitaSanderDustPortReceptacle() {
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
};

translate([0,0,39]) ShopVacHoseReceptacle();

translate([0,0,14]) JoinerOfTwoParts();

MakitaSanderDustPortReceptacle();

