box_length = 15;
box_width = 4.6;
box_height = 5;
box_height_extra = 5.5;
pin_pad = 0.5;
pin_width = 1.1;
nop_width = 1.5;
nop_height = 2;
sidepin_width = 2.5;

// Parameters

base_z_height = 1;

hole_diameter = 2.5;  // Diameter of the holes
hole_depth = 100;    // Depth of the holes (adjusted to be less than the cylinder height)
hole_positions = [
    [14.8, 12],  // Position of hole 1 (x, y)
    [-14.8, 12], // Position of hole 2 (x, y)
    [18.6, -4],  // Position of hole 3 (x, y)
    [-18.6, -4]  // Position of hole 4 (x, y)
];

hole2_diameter = 44;  // Diameter of the holes
hole2_depth = 18;    // Depth of the holes (adjusted to be less than the cylinder height)
hole2_positions = [
    [0, 0, 10]  // Position of hole 4 (x, y, z)
];

// Parameters for the base
top_diameter = 70;
bottom_diameter = 76;
wall_thickness = 1;
top_thickness = 0; // Thickness of the top surface
curve_radius = 15; // Radius of the curve
cutout_position_z = 0; // Z position of the cut-out (make this adjustable)
cutout_height_adjustable = 0.8; // Adjust the height of the cut-out (new parameter)
// New parameter for adjustable base thickness
base_thickness = 0; // Adjust this value to change the thickness of the base

// Parameters for the new ring
ring_height = 4; // Height of the ring
ring_thickness = 2; // Thickness of the ring
ring_inner_diameter = 73; // Inner diameter of the ring
ring_outer_diameter = 76; // Outer diameter of the ring (same as top_diameter)

// Parameters for the cutout in the ring
cutout_position_x = 0; // X position of the cutout center
cutout_position_y = 70; // Y position of the cutout center
cutout_width_in_ring = 4; // Width of the cutout
cutout_height_in_ring = 70; // Height of the cutout (increased to ensure full cut through)

// Set number of facets for smoother cylinders
$fn = 200; // Increases the number of segments to make the cylinder smooth

// Parameters for the bottom ring (same as the top ring)
bottom_ring_height = 2; // Height of the bottom ring
bottom_ring_thickness = 3; // Thickness of the bottom ring
bottom_ring_inner_diameter = 44; // Inner diameter of the bottom ring (same as ring_inner_diameter)
bottom_ring_outer_diameter = 76; // Outer diameter of the bottom ring (same as bottom_diameter)

// Parameters for the top ring =
top_ring_height = 5; // Height of the top ring
top_ring_inner_diameter = 73; // Inner diameter of the top ring (same as ring_inner_diameter)
top_ring_outer_diameter = 76; // Outer diameter of the top ring (same as top_diameter)
module holebox(x = 0, y = 0, z = 0, withHoles = 1){
    translate([x,y,z+1.5]){
        difference(){
            translate([0,0,box_height_extra/2])
            cube([box_length, box_width, box_height+box_height_extra], center = true);
        
            if (withHoles != 0){
                for ( i = [-3 : 3]){
                    if (i != -3){
                        translate([i*2, box_width/2-1.2, 0])
                            cube([pin_width, pin_width, box_height+1+box_height_extra*2], center = true);
                        
                        //sideholes
                        translate([i*2-pin_width/2,box_width/2-1,box_height])
                            cube([pin_width,1,2]);
                    }
                    if (i == 0)
                    translate([i*2, -(box_width/2-1.2), 0])
                        cube([pin_width, pin_width, box_height+1+box_height_extra*2], center = true);
                }
            }
        }
        

        //pin
        translate([0, box_width/2 + nop_width/2, box_height/2-nop_height/2 - pin_pad-0.8])
            cube([nop_width, nop_width, nop_height], center = true);
        translate([0, box_width/2 + nop_width/2, box_height/2-nop_height/2-1])
            cube([nop_width, nop_width, nop_height], center = true);
        
        
        //sidepin right
        translate([box_length/2 + nop_width/2, 0, -0.5])
            cube([nop_width, sidepin_width, box_height-1], center = true);

        //sidepin left
        translate([-(box_length/2 + nop_width/2), 0, -0.5])
            cube([nop_width, sidepin_width, box_height-1], center = true);
        
    }
}

support_len = 2;
support_width = 4;
thickness = 1;

module foot(x = 0, y = 0, z = 0){
    
    leg_len = 3;
    
    translate([x-support_width/2,y-support_len/2,z]){
        translate([0,0,1]);

      


        
        translate([0,-0.5,-3])
        rotate([0,0,0]){
            translate([0,0,-leg_len+2])
                cube([support_width,thickness,leg_len]);                    
        }

    }
}

module footstuff(x = 0, y = 0, z = 1){
    plate_length = box_width + 0;
    plate_width = box_length + 0;
    plate_thickness = 0;
    
    plate_conn = 0;
    
    fplate_radius = 21;

    
    translate([x,y,z]){
    

        



        for ( i = [0:6]){
            rotate([180,0,51.4*i])
                foot(0,-fplate_radius,nop_height);            
        }

    }
}
translate([0, 0, +base_z_height]) {
rotate([0, 0, 0]) {
footstuff();
}
}


module hole(x = 0, y = 0, z = 0){
    translate([x,y,z-1]){
        cylinder(3,1.25,1.25);
    }
}



module base() {
    difference() {
        // Outer part (smooth cone)
        color("lightblue") {
            // Create the smooth cone for the main body
            cylinder(h = base_z_height, r1 = bottom_diameter / 2, r2 = top_diameter / 2);
        }
       // Subtract the curved cut-out from the base without flipping
translate([0, 0,  cutout_position_z]) {
    rotate_extrude($fn = 200)
        translate([bottom_diameter / 2, 0, 0])
            offset(r = curve_radius) {
                // Adjust the height of the cut-out without flipping
                square([curve_radius, cutout_height_adjustable], center = false);
            }
}
    // Cutting hole: a cylinder
    translate([0, -10, 13.1])
    rotate([90,0,900])// Move the cylinder to pass through the cube
    cylinder(h=50, r=2.5, center=false);  // A vertical cylinder with radius 5
            //cut holes out for pins
            translate([0,0,0])
            cube([box_length, box_width, box_height+box_height_extra], center = true);
        
            
                for ( i = [-3 : 3]){
                    if (i != -3){
                        translate([i*2, box_width/2-1, 0])
                            cube([pin_width, pin_width, box_height+1+box_height_extra*2], center = true);
                        
                        //sideholes
                        translate([i*2-pin_width/2,box_width/2-1,box_height])
                            cube([pin_width,1,2]);
                    }
                    if (i == 0)
                    translate([i*2, -(box_width/2-1), 0])
                        cube([pin_width, pin_width, box_height+1+box_height_extra*2], center = true);
                }
                                // Create holes
        for (pos = hole2_positions) {
            translate([pos[0], pos[1], pos[2]]) { // Adjusting the z position to cut through the cylinder
                cylinder(hole2_depth, hole2_diameter / 2, hole2_diameter / 2, center = true); // Create the holes
            }
        }
     // Create holes
        for (pos = hole_positions) {
            translate([pos[0], pos[1], 0]) { // Adjusting the z position to cut through the cylinder
                cylinder(hole_depth, hole_diameter / 2, hole_diameter / 2, center = true); // Create the holes
            }
        }
            
        

    }

}
translate([0, 0, +base_z_height]) {
rotate([180, 0, 0]) {
base();
}
}





rotate([180, 0, 0]) {
    holebox(0, 0, -base_z_height -2);  // Adjust z-position as necessary after flipping
}






