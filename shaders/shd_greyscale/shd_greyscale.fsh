//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    vec4 samp_color = texture2D( gm_BaseTexture, v_vTexcoord );
	
	gl_FragColor = v_vColour * vec4(vec3(samp_color.r),samp_color.g);
}
