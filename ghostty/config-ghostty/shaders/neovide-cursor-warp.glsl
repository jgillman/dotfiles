// neovide-cursor-warp.glsl
//
// Reproduces Neovide's signature cursor animation in Ghostty: as the cursor
// jumps between cells, its four corners animate independently instead of the
// whole rectangle sliding as one block. The leading corners (in the direction
// of travel) snap ahead while the trailing corners lag behind, so the cursor
// stretches into a "smear" quad for the duration of the move and then
// resolves back into a solid rectangle. This is the effect from Neovide's
// `Corner`/`CriticallyDampedSpringAnimation` code in
// src/renderer/cursor_renderer/mod.rs and animation_utils.rs.
//
// Ghostty doesn't expose a spring-physics API, so DURATION/ease() below
// approximate Neovide's critically-damped spring with a fixed-time easing
// curve (easeOutCirc by default) — visually very close for the animation
// lengths Neovide uses (~150ms).
//
// Tuned to mirror Neovide's DEFAULT settings:
//   cursor.animation_length = 0.150  -> DURATION
//   cursor.trail_size       = 1.0    -> TRAIL_SIZE (max smear: leading
//                                       corners arrive instantly, trailing
//                                       corners take the full duration)
//
// Adapted from sahaj-b/ghostty-cursor-shaders (cursor_warp.glsl, MIT
// License, Copyright (c) 2026 Sahaj Bhatt), itself built on the SDF/uniform
// approach from KroneCorylus/ghostty-shader-playground. Only the default
// tuning constants were changed here to match Neovide's numbers.

// sRGB -> Linear conversion (Ghostty passes sRGB values but the shader
// pipeline operates in linear color space).
vec3 sRGBToLinear(vec3 c) {
    return mix(c / 12.92, pow((c + 0.055) / 1.055, vec3(2.4)), step(vec3(0.04045), c));
}

// --- CONFIGURATION ---
vec4 TRAIL_COLOR = vec4(sRGBToLinear(iCurrentCursorColor.rgb), iCurrentCursorColor.a);
const float DURATION = 0.15;          // Neovide: cursor.animation_length
const float TRAIL_SIZE = 1.0;         // Neovide: cursor.trail_size (0=no smear, 1=max smear)
const float THRESHOLD_MIN_DISTANCE = 1.5; // min distance (in cursor heights) before a trail is drawn
const float BLUR = 1.0;               // antialiasing blur size in pixels
const float TRAIL_THICKNESS = 1.0;    // 1.0 = full cursor height
const float TRAIL_THICKNESS_X = 1.0;  // 1.0 = full cursor width

const float FADE_ENABLED = 0.0;       // Neovide's trail is a solid smear, not faded
const float FADE_EXPONENT = 5.0;

// --- CONSTANTS ---
const float PI = 3.14159265359;

// --- EASING FUNCTION ---
// EaseOutCirc approximates a critically damped spring's fast-in/slow-settle
// feel reasonably well for short animation lengths like Neovide's 150ms.
// Swap this out for a different curve below if you want a different feel.
float ease(float x) {
    return sqrt(1.0 - pow(x - 1.0, 2.0));
}

// // Linear
// float ease(float x) { return x; }
// // EaseOutQuad
// float ease(float x) { return 1.0 - (1.0 - x) * (1.0 - x); }
// // EaseOutCubic
// float ease(float x) { return 1.0 - pow(1.0 - x, 3.0); }
// // EaseOutExpo
// float ease(float x) { return x == 1.0 ? 1.0 : 1.0 - pow(2.0, -10.0 * x); }

float getSdfRectangle(in vec2 p, in vec2 xy, in vec2 b)
{
    vec2 d = abs(p - xy) - b;
    return length(max(d, 0.0)) + min(max(d.x, d.y), 0.0);
}

// Based on Inigo Quilez's 2D distance functions article: https://iquilezles.org/articles/distfunctions2d/
float seg(in vec2 p, in vec2 a, in vec2 b, inout float s, float d) {
    vec2 e = b - a;
    vec2 w = p - a;
    vec2 proj = a + e * clamp(dot(w, e) / dot(e, e), 0.0, 1.0);
    float segd = dot(p - proj, p - proj);
    d = min(d, segd);

    float c0 = step(0.0, p.y - a.y);
    float c1 = 1.0 - step(0.0, p.y - b.y);
    float c2 = 1.0 - step(0.0, e.x * w.y - e.y * w.x);
    float allCond = c0 * c1 * c2;
    float noneCond = (1.0 - c0) * (1.0 - c1) * (1.0 - c2);
    float flip = mix(1.0, -1.0, step(0.5, allCond + noneCond));
    s *= flip;
    return d;
}

float getSdfConvexQuad(in vec2 p, in vec2 v1, in vec2 v2, in vec2 v3, in vec2 v4) {
    float s = 1.0;
    float d = dot(p - v1, p - v1);

    d = seg(p, v1, v2, s, d);
    d = seg(p, v2, v3, s, d);
    d = seg(p, v3, v4, s, d);
    d = seg(p, v4, v1, s, d);

    return s * sqrt(d);
}

vec2 normalize(vec2 value, float isPosition) {
    return (value * 2.0 - (iResolution.xy * isPosition)) / iResolution.y;
}

float antialising(float distance, float blurAmount) {
  return 1. - smoothstep(0., normalize(vec2(blurAmount, blurAmount), 0.).x, distance);
}

// Determines animation duration per corner based on alignment with the
// direction of travel (dot product in [-2, 2]): leading corners get the
// short duration, trailing corners get the full one. This is the shader
// equivalent of Neovide's per-corner `rank` in Corner::jump().
float getDurationFromDot(float dot_val, float DURATION_LEAD, float DURATION_SIDE, float DURATION_TRAIL) {
    float isLead = step(0.5, dot_val);
    float isSide = step(-0.5, dot_val) * (1.0 - isLead);

    float duration = mix(DURATION_TRAIL, DURATION_SIDE, isSide);
    duration = mix(duration, DURATION_LEAD, isLead);
    return duration;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord){
    #if !defined(WEB)
    fragColor = texture(iChannel0, fragCoord.xy / iResolution.xy);
    #endif

    vec2 vu = normalize(fragCoord, 1.);
    vec2 offsetFactor = vec2(-.5, 0.5);

    vec4 currentCursor = vec4(normalize(iCurrentCursor.xy, 1.), normalize(iCurrentCursor.zw, 0.));
    vec4 previousCursor = vec4(normalize(iPreviousCursor.xy, 1.), normalize(iPreviousCursor.zw, 0.));

    vec2 centerCC = currentCursor.xy - (currentCursor.zw * offsetFactor);
    vec2 halfSizeCC = currentCursor.zw * 0.5;
    vec2 centerCP = previousCursor.xy - (previousCursor.zw * offsetFactor);

    float sdfCurrentCursor = getSdfRectangle(vu, centerCC, halfSizeCC);

    float lineLength = distance(centerCC, centerCP);
    float minDist = currentCursor.w * THRESHOLD_MIN_DISTANCE;

    vec4 newColor = vec4(fragColor);

    float baseProgress = iTime - iTimeCursorChange;

    if (lineLength > minDist && baseProgress < DURATION - 0.001) {
        // Current-cursor corners (with trail thickness applied)
        float cc_half_height = currentCursor.w * 0.5;
        float cc_center_y = currentCursor.y - cc_half_height;
        float cc_new_half_height = cc_half_height * TRAIL_THICKNESS;
        float cc_new_top_y = cc_center_y + cc_new_half_height;
        float cc_new_bottom_y = cc_center_y - cc_new_half_height;

        float cc_half_width = currentCursor.z * 0.5;
        float cc_center_x = currentCursor.x + cc_half_width;
        float cc_new_half_width = cc_half_width * TRAIL_THICKNESS_X;
        float cc_new_left_x = cc_center_x - cc_new_half_width;
        float cc_new_right_x = cc_center_x + cc_new_half_width;

        vec2 cc_tl = vec2(cc_new_left_x, cc_new_top_y);
        vec2 cc_tr = vec2(cc_new_right_x, cc_new_top_y);
        vec2 cc_bl = vec2(cc_new_left_x, cc_new_bottom_y);
        vec2 cc_br = vec2(cc_new_right_x, cc_new_bottom_y);

        // Previous-cursor corners (same treatment)
        float cp_half_height = previousCursor.w * 0.5;
        float cp_center_y = previousCursor.y - cp_half_height;
        float cp_new_half_height = cp_half_height * TRAIL_THICKNESS;
        float cp_new_top_y = cp_center_y + cp_new_half_height;
        float cp_new_bottom_y = cp_center_y - cp_new_half_height;

        float cp_half_width = previousCursor.z * 0.5;
        float cp_center_x = previousCursor.x + cp_half_width;
        float cp_new_half_width = cp_half_width * TRAIL_THICKNESS_X;
        float cp_new_left_x = cp_center_x - cp_new_half_width;
        float cp_new_right_x = cp_center_x + cp_new_half_width;

        vec2 cp_tl = vec2(cp_new_left_x, cp_new_top_y);
        vec2 cp_tr = vec2(cp_new_right_x, cp_new_top_y);
        vec2 cp_bl = vec2(cp_new_left_x, cp_new_bottom_y);
        vec2 cp_br = vec2(cp_new_right_x, cp_new_bottom_y);

        const float DURATION_TRAIL = DURATION;
        const float DURATION_LEAD = DURATION * (1.0 - TRAIL_SIZE);
        const float DURATION_SIDE = (DURATION_LEAD + DURATION_TRAIL) / 2.0;

        vec2 moveVec = centerCC - centerCP;
        vec2 s = sign(moveVec);

        float dot_tl = dot(vec2(-1., 1.), s);
        float dot_tr = dot(vec2( 1., 1.), s);
        float dot_bl = dot(vec2(-1.,-1.), s);
        float dot_br = dot(vec2( 1.,-1.), s);

        float dur_tl = getDurationFromDot(dot_tl, DURATION_LEAD, DURATION_SIDE, DURATION_TRAIL);
        float dur_tr = getDurationFromDot(dot_tr, DURATION_LEAD, DURATION_SIDE, DURATION_TRAIL);
        float dur_bl = getDurationFromDot(dot_bl, DURATION_LEAD, DURATION_SIDE, DURATION_TRAIL);
        float dur_br = getDurationFromDot(dot_br, DURATION_LEAD, DURATION_SIDE, DURATION_TRAIL);

        float isMovingRight = step(0.5, s.x);
        float isMovingLeft  = step(0.5, -s.x);

        float dot_right_edge = (dot_tr + dot_br) * 0.5;
        float dur_right_rail = getDurationFromDot(dot_right_edge, DURATION_LEAD, DURATION_SIDE, DURATION_TRAIL);

        float dot_left_edge = (dot_tl + dot_bl) * 0.5;
        float dur_left_rail = getDurationFromDot(dot_left_edge, DURATION_LEAD, DURATION_SIDE, DURATION_TRAIL);

        float final_dur_tl = mix(dur_tl, dur_left_rail, isMovingLeft);
        float final_dur_bl = mix(dur_bl, dur_left_rail, isMovingLeft);

        float final_dur_tr = mix(dur_tr, dur_right_rail, isMovingRight);
        float final_dur_br = mix(dur_br, dur_right_rail, isMovingRight);

        float prog_tl = ease(clamp(baseProgress / final_dur_tl, 0.0, 1.0));
        float prog_tr = ease(clamp(baseProgress / final_dur_tr, 0.0, 1.0));
        float prog_bl = ease(clamp(baseProgress / final_dur_bl, 0.0, 1.0));
        float prog_br = ease(clamp(baseProgress / final_dur_br, 0.0, 1.0));

        vec2 v_tl = mix(cp_tl, cc_tl, prog_tl);
        vec2 v_tr = mix(cp_tr, cc_tr, prog_tr);
        vec2 v_br = mix(cp_br, cc_br, prog_br);
        vec2 v_bl = mix(cp_bl, cc_bl, prog_bl);

        float sdfTrail = getSdfConvexQuad(vu, v_tl, v_tr, v_br, v_bl);

        vec2 fragVec = vu - centerCP;
        float fadeProgress = clamp(dot(fragVec, moveVec) / (dot(moveVec, moveVec) + 1e-6), 0.0, 1.0);

        vec4 trail = TRAIL_COLOR;

        float effectiveBlur = BLUR;
        if (BLUR < 2.5) {
          float isDiagonal = abs(s.x) * abs(s.y);
          float effectiveBlur = mix(0.0, BLUR, isDiagonal);
        }
        float shapeAlpha = antialising(sdfTrail, effectiveBlur);

        if (FADE_ENABLED > 0.5) {
            float easedProgress = pow(fadeProgress, FADE_EXPONENT);
            trail.a *= easedProgress;
        }

        float finalAlpha = trail.a * shapeAlpha;

        newColor = mix(newColor, vec4(trail.rgb, newColor.a), finalAlpha);
        newColor = mix(newColor, fragColor, step(sdfCurrentCursor, 0.));
    }

    fragColor = newColor;
}
