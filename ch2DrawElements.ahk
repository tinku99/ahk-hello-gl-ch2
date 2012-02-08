#include, gl.ahk  
#include, wgl.ahk 
#include, agl.ahk 
#include, glext.ahk
#include, glu.ahk  	 	  
aglInit()	  
        	  
Gui, +Resize	  
Gui, show, w640 h480 x000 y100
Gui, Color, 0
hRC := aglUseGui()
hDC := wglGetCurrentDC()
aglInitExt()	  
 
OnExit, ExitSub	  
g_resources := make_resourcesElements()
 glEnable(GL_TEXTURE_2D)       	  
 
Gui, show, w640 h480, % "OpenGL v" aglGetVersion()
. " - " glGetString(GL_RENDERER)
 
Loop
{
 
glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)
 
glUseProgram(g_resources.program)
MouseGetPos, x, y
g_resources.fade_factor := y / 1000
glUniform1f(g_resources.uniforms.fade_factor, g_resources.fade_factor)
 glActiveTexture(GL_TEXTURE0)
    glBindTexture(GL_TEXTURE_2D, g_resources.textures[1])
    glUniform1i(g_resources.uniforms.textures[1], 0)
         
    glActiveTexture(GL_TEXTURE1)
    glBindTexture(GL_TEXTURE_2D, g_resources.textures[2])
    glUniform1i(g_resources.uniforms.textures[2], 1)
         

glEnableClientState(GL_VERTEX_ARRAY)
glVertexPointer(4, GL_FLOAT, 0, g_resources.vertexPointer)
glDrawElements(GL_TRIANGLE_STRIP, 4, GL_UNSIGNED_SHORT, g_resources.elementPointer)
 
glDisableClientState(GL_VERTEX_ARRAY)
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

!r::reload
