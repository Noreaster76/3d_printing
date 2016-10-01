
// entire shape

union() {

  // top of sliced cylinder
  intersection() {

    cylinder(h = 10, r1 = 10, r2 = 10);

    // rotated plane that slices through a cylinder
    translate([0,0,4]) {
      rotate([0,-20,0]) {
        cube([30, 30, 1], center=true);
      }
    }
  }

  // diagonally sliced cylindrical tube
  difference() {

    // cylindrical tube
    difference() {
      cylinder(h = 10, r1 = 10, r2 = 10);
      translate([0,0,-1]) {
        cylinder(h = 12, r1 = 9, r2 = 9);
      }
    }

    // translated and rotated big cube
    translate([0,0,8.9]) {
      rotate([0,-20,0]) {
        cube([30, 30, 10], center=true);
      }
    }

  }

}
