#if defined(VERTEX) || __VERSION__ > 100 || defined(GL_FRAGMENT_PRECISION_HIGH)
	#define MY_HIGHP_OR_MEDIUMP highp
#else
	#define MY_HIGHP_OR_MEDIUMP mediump
#endif

extern MY_HIGHP_OR_MEDIUMP vec2 gilded;

extern MY_HIGHP_OR_MEDIUMP number dissolve;
extern MY_HIGHP_OR_MEDIUMP number time;
extern MY_HIGHP_OR_MEDIUMP vec4 texture_details;
extern MY_HIGHP_OR_MEDIUMP vec2 image_details;
extern bool shadow;
extern MY_HIGHP_OR_MEDIUMP vec4 burn_colour_1;
extern MY_HIGHP_OR_MEDIUMP vec4 burn_colour_2;

// the following four vec4 are (as far as I can tell) required and shouldn't be changed

vec4 dissolve_mask(vec4 tex, vec2 texture_coords, vec2 uv)
{
    if (dissolve < 0.001) {
        return vec4(shadow ? vec3(0.,0.,0.) : tex.xyz, shadow ? tex.a*0.3: tex.a);
    }

    float adjusted_dissolve = (dissolve*dissolve*(3.-2.*dissolve))*1.02 - 0.01; //Adjusting 0.0-1.0 to fall to -0.1 - 1.1 scale so the mask does not pause at extreme values

	float t = time * 10.0 + 2003.;
	vec2 floored_uv = (floor((uv*texture_details.ba)))/max(texture_details.b, texture_details.a);
    vec2 uv_scaled_centered = (floored_uv - 0.5) * 2.3 * max(texture_details.b, texture_details.a);
	
	vec2 field_part1 = uv_scaled_centered + 50.*vec2(sin(-t / 143.6340), cos(-t / 99.4324));
	vec2 field_part2 = uv_scaled_centered + 50.*vec2(cos( t / 53.1532),  cos( t / 61.4532));
	vec2 field_part3 = uv_scaled_centered + 50.*vec2(sin(-t / 87.53218), sin(-t / 49.0000));

    float field = (1.+ (
        cos(length(field_part1) / 19.483) + sin(length(field_part2) / 33.155) * cos(field_part2.y / 15.73) +
        cos(length(field_part3) / 27.193) * sin(field_part3.x / 21.92) ))/2.;
    vec2 borders = vec2(0.2, 0.8);

    float res = (.5 + .5* cos( (adjusted_dissolve) / 82.612 + ( field + -.5 ) *3.14))
    - (floored_uv.x > borders.y ? (floored_uv.x - borders.y)*(5. + 5.*dissolve) : 0.)*(dissolve)
    - (floored_uv.y > borders.y ? (floored_uv.y - borders.y)*(5. + 5.*dissolve) : 0.)*(dissolve)
    - (floored_uv.x < borders.x ? (borders.x - floored_uv.x)*(5. + 5.*dissolve) : 0.)*(dissolve)
    - (floored_uv.y < borders.x ? (borders.x - floored_uv.y)*(5. + 5.*dissolve) : 0.)*(dissolve);

    if (tex.a > 0.01 && burn_colour_1.a > 0.01 && !shadow && res < adjusted_dissolve + 0.8*(0.5-abs(adjusted_dissolve-0.5)) && res > adjusted_dissolve) {
        if (!shadow && res < adjusted_dissolve + 0.5*(0.5-abs(adjusted_dissolve-0.5)) && res > adjusted_dissolve) {
            tex.rgba = burn_colour_1.rgba;
        } else if (burn_colour_2.a > 0.01) {
            tex.rgba = burn_colour_2.rgba;
        }
    }

    return vec4(shadow ? vec3(0.,0.,0.) : tex.xyz, res > adjusted_dissolve ? (shadow ? tex.a*0.3: tex.a) : .0);
}

number hue(number s, number t, number h)
{
	number hs = mod(h, 1.)*6.;
	if (hs < 1.) return (t-s) * hs + s;
	if (hs < 3.) return t;
	if (hs < 4.) return (t-s) * (4.-hs) + s;
	return s;
}

vec4 RGB(vec4 c)
{
	if (c.y < 0.0001)
		return vec4(vec3(c.z), c.a);

	number t = (c.z < .5) ? c.y*c.z + c.z : -c.y*c.z + (c.y+c.z);
	number s = 2.0 * c.z - t;
	return vec4(hue(s,t,c.x + 1./3.), hue(s,t,c.x), hue(s,t,c.x - 1./3.), c.w);
}

vec4 HSL(vec4 c)
{
	number low = min(c.r, min(c.g, c.b));
	number high = max(c.r, max(c.g, c.b));
	number delta = high - low;
	number sum = high+low;

	vec4 hsl = vec4(.0, .0, .5 * sum, c.a);
	if (delta == .0)
		return hsl;

	hsl.y = (hsl.z < .5) ? delta / sum : delta / (2.0 - sum);

	if (high == c.r)
		hsl.x = (c.g - c.b) / delta;
	else if (high == c.g)
		hsl.x = (c.b - c.r) / delta + 2.0;
	else
		hsl.x = (c.r - c.g) / delta + 4.0;

	hsl.x = mod(hsl.x / 6., 1.);
	return hsl;
}

//increase contrast function
vec4 increase_contrast(vec4 tex, float contrast_level)
{
    // Normalize the RGB values to the -0.5 to +0.5 range
    vec3 normalized_rgb = tex.rgb - 0.5;

    // Apply contrast scaling based on the contrast level
    normalized_rgb *= contrast_level;

    // Shift back to the 0-1 range
    vec3 adjusted_rgb = normalized_rgb + 0.5;

    // Clamp to ensure RGB values are within a valid range
    adjusted_rgb = clamp(adjusted_rgb, 0.0, 1.0);

    // Return the color with the adjusted contrast
    return vec4(adjusted_rgb, tex.a);  // Keep the original alpha value
}

// this is what actually changes the look of card
vec4 effect( vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords )
{
    // turns the texture into pixels
    vec4 tex = Texel(texture, texture_coords);
	vec2 uv = (((texture_coords)*(image_details)) - texture_details.xy*texture_details.ba)/texture_details.ba;

    number cyan = 0;
    number magenta = 0;
    number yellow = 0;
    
    // from booster.fs

    number low = min(tex.r, min(tex.r, tex.b));
    number high = max(tex.r, max(tex.g, tex.r));
	number delta = max(high-low, low*0.7);

    number fac = 0.8 + 0.4*sin(9.*uv.x+3.1*uv.y + gilded.r*2. + cos(gilded.r*1.1 + uv.y*0.2 - uv.x*7.7));
    number fac2 = 0.5 + 0.2*sin(1.*uv.x+7.1*uv.y + gilded.r*5. - cos(gilded.r*2. + uv.x*3.4));
    number fac3 = 0.5 + 0.3*sin(3.*uv.x+2.1*uv.y + gilded.r*3. + sin(gilded.r*2.1 + uv.y*4.5));
    number fac4 = 0.5 + 0.1*sin(4.*uv.x+4.1*uv.y + gilded.r*0.23 + sin(gilded.r*6.2 + uv.y*1.));
    number fac5 = sin(0.5*17.*uv.x+4.4*uv.y + gilded.r*12. + cos(gilded.r*2.2 + uv.y*1.2 - uv.x*1.4));

    number maxfac = 0.6*max(max(fac2, max(fac4, max(fac3,0.0))) + (fac+fac2+fac3*fac4), 0.);

    // from lyman

    number black = 1 - max(tex.r, max(tex.g, tex.b));

    float grayscale = 0.2126 * tex.r + 0.7152 * tex.g + 0.0722 * tex.b;

    // greyscale tex
    vec4 gray = vec4(grayscale, grayscale, grayscale, tex.a);

    // desaturate tex
    tex.rgb = mix(tex.rgb, gray.rgb, 1);

    if (black < 1) {
        cyan = (1 - tex.r - black) / (1 - black);
        magenta = (1 - tex.g - black) / (1 - black);
        yellow = (1 - tex.b - black) / (1 - black);
    }
    if (gilded.g > 0.0 || gilded.g < 0.0) {
        cyan *= 0.3;
        magenta *= 0.6;
        yellow *= 1.4;
        black *= 0.9;
	}
    
    tex.r = (1.2 - cyan) * (1 - black);
    tex.g = (1.2 - magenta) * (1 - black);
    tex.b = (1 - yellow) * (1 - black);

    // gradient

    float brightness_reduction = (0.5 * (uv.y-0.5));
    float bottom_rim = (0.2 * (uv.y-0.5));
    float x_brightness_reduction = (0.5 * (uv.x-0.5));
    tex.rgb *= (1.0 - brightness_reduction);
    tex.rgb *= (1.0 + bottom_rim);
    tex.rgb *= (1.0 - x_brightness_reduction);
    tex.g *= (1.0 - (0.5 * brightness_reduction));
    tex.g *= (1.0 - (0.5 * x_brightness_reduction));
    tex.b *= (1.0 - brightness_reduction);
    tex.b *= (1.0 - x_brightness_reduction);

    // lower contrast
    tex = increase_contrast(tex, 0.8);
    tex.r *= 1.2;
    tex.g *= 0.90;
    tex.b *= 0.8;

    // from booster.fs

    tex.r = tex.r-delta + delta*maxfac*(0.7 + fac5*0.35) - 0.1;
    tex.g = tex.g-delta + delta*maxfac*(0.7 + fac5*0.25) - 0.1;
    tex.b = tex.b-delta + delta*maxfac*(0.5 + fac5*0.20) - 0.1;
    tex.a = tex.a*(0.15*max(min(1., max(0.,0.9*max(low*0.7, delta)+ min(max(maxfac*0.7,0.), 0.01)) ), 0.) + 0.35*maxfac*(0.1+delta));

    // required
	return dissolve_mask(tex*colour, texture_coords, uv);
}

// for transforming the card while your mouse is on it
extern MY_HIGHP_OR_MEDIUMP vec2 mouse_screen_pos;
extern MY_HIGHP_OR_MEDIUMP float hovering;
extern MY_HIGHP_OR_MEDIUMP float screen_scale;

#ifdef VERTEX
vec4 position( mat4 transform_projection, vec4 vertex_position )
{
    if (hovering <= 0.){
        return transform_projection * vertex_position;
    }
    float mid_dist = length(vertex_position.xy - 0.5*love_ScreenSize.xy)/length(love_ScreenSize.xy);
    vec2 mouse_offset = (vertex_position.xy - mouse_screen_pos.xy)/screen_scale;
    float scale = 0.2*(-0.03 - 0.3*max(0., 0.3-mid_dist))
                *hovering*(length(mouse_offset)*length(mouse_offset))/(2. -mid_dist);

    return transform_projection * vertex_position + vec4(0,0,0,scale);
}
#endif