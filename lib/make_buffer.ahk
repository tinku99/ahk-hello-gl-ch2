make_buffer(target, buffer_data, buffer_size){
global GL_STATIC_DRAW	     

VarSetCapacity(pbuffer, 4, 0)
glGenBuffers(1, &pbuffer)
    buffer := NumGet(pbuffer, 0, "uint")
    glBindBuffer(target, buffer)	
    glBufferData(target, buffer_size, buffer_data, GL_STATIC_DRAW)
return buffer				
}		    


