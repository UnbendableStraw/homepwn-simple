// Parameters for the base
base_z_height = 15; // Adjustable height of the base
top_diameter = 76;
bottom_diameter = 92;
wall_thickness = 1;
cutout_width = 10;  // Width of the wire cutout (adjusted from diameter)
cutout_length = 10;  // Length of the wire cutout
cutout_depth = 6; // Depth of the cutout from the edge
cutout_height = 20; // Depth of the cutout into the Z axis
top_thickness = 0.6; // Thickness of the top surface

// New parameter for adjustable base thickness
base_thickness = 0; // Adjust this value to change the thickness of the base

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
ring_inner_diameter = 73; // Inner diameter of the ring
ring_outer_diameter = 76; // Outer diameter of the ring (same as top_diameter)

// Parameters for the cutout in the ring
cutout_position_x = 0; // X position of the cutout center
cutout_position_y = 70; // Y position of the cutout center
cutout_width_in_ring = 10; // Width of the cutout
cutout_height_in_ring = 70; // Height of the cutout (increased to ensure full cut through)

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
            translate([cutout_position_x, cutout_position_y, 1]) // Position the cutout
                cube([cutout_width_in_ring, cutout_height_in_ring, ring_height + 5], center = true); // Ensure the cut goes through fully
    }
}
// Parameters for the bottom ring (same as the top ring)
bottom_ring_height = 5; // Height of the bottom ring
bottom_ring_thickness = 2; // Thickness of the bottom ring
bottom_ring_inner_diameter = 89; // Inner diameter of the bottom ring (same as ring_inner_diameter)
bottom_ring_outer_diameter = 92; // Outer diameter of the bottom ring (same as bottom_diameter)

// New bottom ring module
module bottom_ring() {
    difference() {
        // Outer cylinder for the bottom ring colored in dark blue
        color("darkblue")
            cylinder(h = bottom_ring_height, r = bottom_ring_outer_diameter / 2);
        
        // Inner cylinder to create the hollow part of the ring colored in light gray
        color("lightgray")
            translate([0, 0, -1]) // Ensure the inner cut does not interfere with other features
                cylinder(h = bottom_ring_height + 2, r = bottom_ring_inner_diameter / 2);
                // Cutout in the ring colored in orange
        color("orange")
            translate([cutout_position_x, cutout_position_y, 1]) // Position the cutout
                cube([cutout_width_in_ring, cutout_height_in_ring, ring_height + 5], center = true); // Ensure the cut goes through fully
    }
}
// Parameters for text
text_content = "Nic's Fix";  // The text to display
font = "SF Pro Display:style=Bold"; 
text_size = 6;  // Size of the text
text_thickness = 1;  // Thickness of the text extrusion
text_spacing = 1.2;  // Spacing between letters

// Parameters for text position
text_x_offset = 29;  // Offset for moving the text along the X-axis
text_z_offset = 10;  // Adjustable Z-position for the text


// Calculate the text width for centering
text_width = text_spacing * (len(text_content) - 1) * text_size;

// Call the bottom text module


// Add mirrored text to the bottom of the object with adjustable Z-position

toptext_z_offset = 15;  // Adjustable Z-position for the text
module top_text() {
    color("black")
        translate([-(text_width / 2) + text_x_offset, -(text_size / 2), toptext_z_offset])  // Adjust X and Z positions
    translate([0,-20,0])
        linear_extrude(height = text_thickness)
            text(text_content, size = text_size, spacing = text_spacing, halign = "center", valign = "center");
}


// Call the top text module
top_text();


// Call the bottom ring module at the bottom of the base
translate([0, 0, -bottom_ring_height]) // Position the ring at the bottom of the base
    bottom_ring();

// Call the base module
base();

// Call the ring module on top of the base
translate([0, 0, base_z_height]) // Position the ring on top of the base
    ring();


