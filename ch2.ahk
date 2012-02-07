#include, gl.ahk  
#include, wgl.ahk 
#include, agl.ahk 
#include, glext.ahk
#include, glu.ahk  	 	  
aglInit()	  
        	  
Gui, +Resize	  
Gui, show, w640 h480 x000 y100
hRC := aglUseGui()
hDC := wglGetCurrentDC()
aglInitExt()	  
 
OnExit, ExitSub	  
g_resources := make_resources()
        	  
 
Gui, show, w640 h480, % "OpenGL v" aglGetVersion()
. " - " glGetString(GL_RENDERER)
 
Loop
{
 
glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)
 
glUseProgram(g_resources.program)
glUniform1f(g_resources.uniforms.fade_factor, g_resources.fade_factor)
 glActiveTexture(GL_TEXTURE0)
    glBindTexture(GL_TEXTURE_2D, g_resources.textures[1])
    glUniform1i(g_resources.uniforms.textures[1], 0)
         
    glActiveTexture(GL_TEXTURE1)
    glBindTexture(GL_TEXTURE_2D, g_resources.textures[2])
    glUniform1i(g_resources.uniforms.textures[2], 1)
         
glBindBuffer(GL_ARRAY_BUFFER, g_resources.vertex_buffer)
    glVertexAttribPointer( g_resources.attributes.position  ; attribute 
        , 2                               ; size 
        , GL_FLOAT                         ; type 
        , GL_FALSE                         ; normalized? 
        , 8                ; stride 
        , 0 )                         ; array buffer offset 
         
    glEnableVertexAttribArray(g_resources.attributes.position)
         
 glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, g_resources.element_buffer)
        
    glDrawElements(        GL_TRIANGLE_STRIP  ; mode 
        ,4                  ; count 
        ,GL_UNSIGNED_SHORT  ; type 
        ,0 )           ; element array buffer offset 
      		    
glDisableVertexAttribArray(g_resources.attributes.position)
  
  SwapBuffers(hDC)
  sleep, 30
}
return


GuiSize:
glViewport(0, 0, A_GuiWidth, A_GuiHeight)
return

GuiClose:
ExitApp

ExitSub:
wglMakeCurrent(0, 0)
wglDeleteContext(hRC)
aglReleaseDC(hDC)
aglFree()
ExitApp

assertgl(){
if x := glGetError()
msgbox % "error: " x
}
