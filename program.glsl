#AGL_VERTEX_SHADER 
#version 110
        
attribute vec2 position;
        
varying vec2 texcoord;
        
void main()
{       
    gl_Position = vec4(position, 0.0, 1.0);
    texcoord = position * vec2(0.5) + vec2(0.5);
}       
        
#AGL_FRAGMENT_SHADER 
#version 110
        
uniform float fade_factor;
uniform sampler2D textures[2];
        
varying vec2 texcoord;
        
void main()
{   
    gl_FragColor = mix(
        texture2D(textures[0], texcoord),
        texture2D(textures[1], texcoord),
        fade_factor
    );
}





