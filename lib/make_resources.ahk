
make_resources()
{
global GLfloat, GLushort, GL_ARRAY_BUFFER, GL_ELEMENT_ARRAY_BUFFER
, GL_TEXTURE_2D
VarSetCapacity(g_vertex_buffer_data, 4 * 8, 0)
VarSetCapacity(g_element_buffer_data, 2 * 8, 0)

		    
a_vertex_data := [-1.0, -1.0, 1.0, -1.0, -1.0,  1.0, 1.0,  1.0 ]
a_buffer_data := [0, 1, 2, 3]
for v in a_vertex_data{
NumPut(v, g_vertex_buffer_data, 4 * (A_Index - 1), GLfloat)
}
for e in a_buffer_data{
NumPut(e, g_element_buffer_data, 2 * (A_Index - 1), GLushort)
}

g_resources := {fade_factor: 0.5}
    g_resources.vertex_buffer := make_buffer(GL_ARRAY_BUFFER
,  &g_vertex_buffer_data, 32 )
    g_resources.element_buffer := make_buffer(GL_ELEMENT_ARRAY_BUFFER
, &g_element_buffer_data, 8)
  
tex := aglLoadTexImage2D(GL_TEXTURE_2D, "hello1.png")
tex2 := aglLoadTexImage2D(GL_TEXTURE_2D, "hello2.png")
g_resources.textures := [tex, tex2]
program := aglLoadProgram("program.glsl", log)
glUseProgram(program)
g_resources.program := program
u := {}
u.fade_factor := glGetUniformLocation(program, "fade_factor")			    
ut1 := glGetUniformLocation(program, "textures[0]")			    
ut2 := glGetUniformLocation(program, "textures[1]")			    
u.textures := [ut1, ut2]
aposition := glGetAttribLocation(program, "position")
g_resources.attributes := {position: aposition}
g_resources.uniforms := u
listvars
msgbox % "g_resources: " tostring(g_resources)	  
return g_resources
}      	       	
