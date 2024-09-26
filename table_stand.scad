// Parameters for the base
base_z_height = 20; // Adjustable height of the base
top_diameter = 91;
bottom_diameter = 95;
wall_thickness = 1;
cutout_width = 10;  // Width of the wire cutout (adjusted from diameter)
cutout_length = 10;  // Length of the wire cutout
cutout_depth = 6; // Depth of the cutout from the edge
cutout_height = 20; // Depth of the cutout into the Z axis
top_thickness = 0.6; // Thickness of the top surface

// New parameter for adjustable base thickness
base_thickness = 0.6; // Adjust this value to change the thickness of the base

// Parameters for the rectangular cutouts
rect_cutout1_width = 40;  // Width of the first rectangular cutout
rect_cutout1_length = 20;  // Length of the first rectangular cutout
rect_cutout_height = base_z_height; // Height of the rectangular cutouts (cuts through the base)

// Parameters for the second rectangular cutout
rect_cutout2_width = 10;  // Width of the second rectangular cutout
rect_cutout2_length = 50;  // Length of the second rectangular cutout
// Position offsets for the second rectangular cutout
rect_cutout2_offset_x = 0;  // X offset for the second rectangular cutout
rect_cutout2_offset_y = 20;  // Y offset for the second rectangular cutout

// New parameter for X-axis offset of the first rectangular cutout
x_offset = -5; // Adjust this value for the X-axis offset

// Parameters for the new ring
ring_height = 4; // Height of the ring
ring_thickness = 2; // Thickness of the ring
ring_inner_diameter = 89; // Inner diameter of the ring
ring_outer_diameter = 91; // Outer diameter of the ring (same as top_diameter)

// Parameters for the cutout in the ring
cutout_position_x = 10; // X position of the cutout center
cutout_position_y = 0; // Y position of the cutout center
cutout_width_in_ring = 4; // Width of the cutout
cutout_height_in_ring = 3; // Height of the cutout

// Set number of facets for smoother cylinders
$fn = 200; // Increases the number of segments to make the cylinder smooth

// Main base shape (truncated cone with smooth sides and a top)
module base() {
    difference() {
        // Outer part (smooth cone) colored in light blue
        color("lightblue")
            cylinder(h = base_z_height, r1 = bottom_diameter / 2, r2 = top_diameter / 2);

        // Wire cutout on the top lip, extending over the edge (changed to rectangle) colored in red
        color("red")
            translate([x_offset, (top_diameter / 2) + (cutout_width / 2) - cutout_depth, base_z_height - cutout_height])
                cube([cutout_width, cutout_length, cutout_height + wall_thickness]);

        // First rectangular cutout centered on the top and cutting through the whole model colored in yellow
        color("yellow")
            translate([-rect_cutout1_width / 2, -rect_cutout1_length / 2, 0]) // Start at the bottom of the model
                cube([rect_cutout1_width, rect_cutout1_length, rect_cutout_height]);

        // Second rectangular cutout positioned by offsets and resizable colored in green
        color("green")
            translate([rect_cutout2_offset_x - rect_cutout2_width / 2, 
                       rect_cutout2_offset_y - rect_cutout2_length / 2, 
                       0]) // Start at the bottom of the model
                cube([rect_cutout2_width, rect_cutout2_length, rect_cutout_height]);
    }
    
    // Create the solid base colored in gray
    color("gray")
        translate([0, 0, -base_thickness]) // Lower the base to ensure it aligns with the ring
            cylinder(h = base_thickness, r = bottom_diameter / 2); // Adjust the height to base_thickness
}

// New ring module with a cutout
module ring() {
    difference() {
        // Outer cylinder for the ring colored in dark blue
        color("darkblue")
            cylinder(h = ring_height, r = ring_outer_diameter / 2);
        
        // Inner cylinder to create the hollow part of the ring colored in light gray
        color("lightgray")
            translate([0, 0, -1]) // Ensure the inner cut does not interfere with other features
                cylinder(h = ring_height + 2, r = ring_inner_diameter / 2);
        
        // Cutout in the ring colored in orange
        color("orange")
            translate([cutout_position_x, cutout_position_y, 0]) // Position the cutout
                cube([cutout_width_in_ring, cutout_height_in_ring, ring_height + 2], center = true); // Center the cutout
    }
}

// Call the base module
base();

// Call the ring module on top of the base
translate([0, 0, base_z_height]) // Position the ring on top of the base
    ring();
