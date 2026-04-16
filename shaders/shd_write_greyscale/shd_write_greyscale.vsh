//
// Simple passthrough vertex shader
//
attribute vec2 in_Position;                  // (x,y,z)
                 // (x,y,z)     unused in this shader.
attribute vec2 in_Colour;                    // (r,g,b,a)
             // (u,v)


varying vec4 v_vColour;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, 0.0, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    v_vColour = vec4(in_Colour.x/255.0,in_Colour.y/255.0,in_Colour.y/255.0,in_Colour.y/255.0);
    
    
}
