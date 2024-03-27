include <perch_common.scad>;

module Hole(hole_diameter) {
    cylinder(100, d1 = hole_diameter, d2 = hole_diameter, false);
}

module HoleAtEdgeOfTube(hole_diameter) {
    // move the perch support to the outside of the tube.
    translate([9,-14.5,-10]) {
        Hole(hole_diameter){};
    };
};

module HoleAtEdgeOfTubeAtEightOClock(hole_diameter) {
    HoleAtEdgeOfTube(hole_diameter);
};
module HoleAtEdgeOfTubeAtFourOClock(hole_diameter) {
    mirror([0,1,0]) {
        HoleAtEdgeOfTube(hole_diameter);
    };
};

module HolesForNonPrintedPerchEntireAssembly(hole_diameter) {
    union() {
        // the two perch supports that extend parallel to the axis of the
        // tube opening.
        HoleAtEdgeOfTubeAtEightOClock(hole_diameter);
        HoleAtEdgeOfTubeAtFourOClock(hole_diameter);
    };
};
