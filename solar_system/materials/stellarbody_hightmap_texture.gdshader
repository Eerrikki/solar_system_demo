shader_type spatial;

uniform sampler2D texture_map : source_color;
uniform sampler2D u_transition_mask : source_color;

varying vec3 frag_global_pos;

vec2 get_spherical_uv(vec3 p) {
    p = normalize(p);
    
    float lat = asin(p.y);
    float lon = atan(p.z, p.x);
    
    vec2 uv;
    uv.x = -lon * (1.0 / (2.0 * PI)) + 0.5;
    uv.y = -0.5 * ((p.y * p.y * p.y + p.y) * 0.5) + 0.5;
    
    return uv;
}

void vertex() {
    frag_global_pos = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
}

void fragment() {
	// Calculate UV coordinates based on global position
    vec3 sphere_pos = normalize(frag_global_pos);
    vec2 uv = get_spherical_uv(sphere_pos);
    
    // Sample the texture
    vec4 color = texture(texture_map, uv);
    
    // Apply basic lighting
    vec3 normal = normalize(cross(dFdx(frag_global_pos), dFdy(frag_global_pos)));
    float ndotl = dot(normal, normalize(vec3(1.0, 1.0, 1.0)));
    color.rgb *= max(0.1, ndotl);
    
    // Apply transition mask
    vec4 mask = texture(u_transition_mask, UV);
    color.a *= mask.r;
    
    ALBEDO = color.rgb;
    //ALPHA = color.a;
}
