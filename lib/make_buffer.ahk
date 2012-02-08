make_buffer(target, buffer_data, buffer_size){
global GL_STATIC_DRAW_ARB

VarSetCapacity(pbuffer, 4, 0)
glGenBuffers(1, &pbuffer)
    buffer := NumGet(pbuffer, 0, "uint")
    glBindBufferARB(target, buffer)	
    glBufferDataARB(target, buffer_size, buffer_data, GL_STATIC_DRAW_ARB)
return buffer				
}		    


