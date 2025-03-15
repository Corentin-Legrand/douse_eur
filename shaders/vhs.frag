#version 460 core

precision mediump float;

uniform float uTime;
uniform vec2 uResolution;
uniform sampler2D uTexture;

out vec4 fragColor;

void main() {
    vec2 uv = gl_FragCoord.xy / uResolution.xy;

    // Texture originale
    vec4 color = texture(uTexture, uv);

    // Effet de bruit VHS
    float noise = (fract(sin(dot(uv * uTime, vec2(12.9898, 78.233))) * 43758.5453) - 0.5) * 0.1;
    color.rgb += noise;

    // Distorsion de couleur
    color.r = texture(uTexture, uv + vec2(0.005, 0.0)).r;
    color.b = texture(uTexture, uv - vec2(0.005, 0.0)).b;

    fragColor = color;
}