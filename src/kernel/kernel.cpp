void print(int color, const char *string){
    volatile char *video = (volatile char*)0xB8000;
    while( *string != 0 )
    {
        *video++ = *string++;
        *video++ = color;
    }
}

extern "C" void main(){
    print((255,255,255), "Hello World");
    return;
}