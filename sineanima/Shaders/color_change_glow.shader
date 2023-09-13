shader_type canvas_item;


uniform vec4 u_color_key : hint_color;
uniform vec4 u_replacement_color : hint_color;

vec4 bl00mFunc(vec4 _c0l_bl00m, float _strength_bl00m){
	float _gamma_bl00m = 1.0 - pow(_c0l_bl00m.r, _strength_bl00m);
	_c0l_bl00m.rgb += (_c0l_bl00m.rgb * _c0l_bl00m.a ) * min(max(_strength_bl00m, 0.0), 1.0);
	return _c0l_bl00m;
}


void fragment() {
    vec4 col = texture(TEXTURE, UV);
	
	
    vec4 d4 = abs(col - u_color_key);
    float d = max(max(d4.r, d4.g), d4.b);
    if(d < 0.5) {
    	col = bl00mFunc(col,0.8) ;
	
    }
    COLOR = col;
}


