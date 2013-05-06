// Global Parameters
rd = 70;         // Diameter of ring
rt = 10;         // Thickness of ring
ld = rt;         // Lug diameter
lt = 3;          // Lug thickness
hd = ld * 0.6;   // Hole diameter
zcrop = 0;       // Crop bottom say 0.3mm to make it more printable, or print a raft
precision = 200; // Circular precision

module curtainring() {

    difference() {

        // Things that exist
        union() {
            rotate_extrude( convexity = 10, $fn = precision )
                translate([rd/2, rt/2, 0])
                    circle( r = rt/2 );
            hull() {
                translate([ rd/2, 0, ld/2])
                    rotate([90,0,0])
                    cylinder( h = lt, r = ld/2, $fn = precision );
                translate([ rd/2 + ld, 0, ld/2])
                    rotate([90,0,0])
                    cylinder( h = lt, r = ld/2, $fn = precision );
            }
        }

        // Things to be cut out
        union() {
            translate([ rd/2 + ld, 0, ld/2])
                rotate([90,0,0])
                cylinder( h = lt, r = hd/2, $fn = precision );
            translate( [-rd, -rd, -rt + zcrop] )
                cube( [rd * 2, rd * 2, rt] );

        }
    }

}

translate( [0, 0, -zcrop] )
    curtainring();

