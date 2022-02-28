void print(int color, const char *string, int x, int y){
    volatile char *video = (volatile char*)0xB8000 + (y * 80 + x);
    if (x % 2 == 0 & y % 2 == 0){
        while( *string != 0 )
        {
            *video++ = *string++;
            *video++ = color;
        }
    }
}