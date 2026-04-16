//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec4 pal[255];


void main()
{
    vec4 samp_color = texture2D( gm_BaseTexture, v_vTexcoord );
	
	int index = int(samp_color.r*255.0);
	
	vec4 index_color = pal[index];
	
	gl_FragColor = v_vColour * index_color;
}
