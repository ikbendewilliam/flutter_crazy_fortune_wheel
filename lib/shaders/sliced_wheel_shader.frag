#version 460 core

#include<flutter/runtime_effect.glsl>

#define PI 3.14159265359
#define PI_2 (PI * 2.0)
#define RING_COUNT 8

uniform vec2 resolution;
uniform float iTime;
uniform sampler2D imageTexture;

out vec4 fragColor;

float atan2(in float y, in float x)
{
    return mod(atan(y, x) + PI_2, PI_2);
}

float smoothStep2(in float edge, in float x)
{
    const float fadeWidth = 0.004;
    return smoothstep(edge - fadeWidth, edge + fadeWidth, x);
}

float arc(in vec2 uv, in float rMin, in float rMax, in float aMin, in float aMax)
{
    float r = length(uv);
    float a = atan2(uv.y, uv.x);
    aMin = mod(aMin, PI_2);
    aMax = mod(aMax, PI_2);
    float minGtMax = step(aMax, aMin);
    a += step(a, aMax) * minGtMax * PI_2;
    aMax += minGtMax * PI_2;
    return smoothStep2(rMin, r) * smoothStep2(r, rMax) * step(aMin, a) * step(a, aMax);
}

float angleStart(in float i)
{
    return PI_2 * i * iTime;
}

mat2 rotationMatrix(float angle)
{
    float c = cos(angle);
    float s = sin(angle);
    return mat2(c, -s, s, c);
}

void main()
{
    vec2 uv = (FlutterFragCoord().xy / resolution.xy);
    vec2 centeredUV = (uv - vec2(0.5)) * 2.0;
    vec4 texColor=texture(imageTexture,uv);

    fragColor = vec4(0.0);
    float rMin = 0.05;
    float ringWidth = (1.0 - rMin) / float(RING_COUNT + 1);
    for (int i = 0; i < RING_COUNT; ++i)
    {
        rMin += ringWidth;
        float start = angleStart(float(i));
        vec2 rotatedUV = rotationMatrix(start) * centeredUV;

        vec2 rotatedTextureUV = rotatedUV * 0.5 + vec2(0.5);
        vec4 texColor = texture(imageTexture, rotatedTextureUV);

        float add = arc(centeredUV, rMin, rMin + ringWidth, 0.0, PI_2);
        fragColor += add * texColor;
    }
}
