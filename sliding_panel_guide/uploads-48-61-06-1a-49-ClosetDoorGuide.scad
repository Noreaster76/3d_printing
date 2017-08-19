$fn = 50;

a = 44;
b = 25;
c = 5;
d = 30;
e = 12;
f = 21;
g = 6.3;
h = 8.7/2;
i = 4.9/2;
fudge_factor_for_second_screw_hole = 7;

difference()
{
	color("grey") linear_extrude(height = b) union()
	{
		square(size = [a, c]);
		translate([e, 0]) square(size = [g, d]);
		translate([e+g+f, 0]) square(size = [g, d]);
		/*translate([e+g+f+g+f, c]) square(size = [g, d]);*/
	}

	color("red") translate([e/2, c/2, b/2]) rotate([-90, 0, 0]) union()
	{
		cylinder(r = h, h = c);
		translate([0,0,-c]) cylinder(r = i, h = c);
	}

	color("orange") translate([a - e/2 - fudge_factor_for_second_screw_hole, c/2, b/2]) rotate([-90, 0, 0]) union()
	{
		cylinder(r = h, h = c);
		translate([0,0,-c]) cylinder(r = i, h = c);
	}
}
