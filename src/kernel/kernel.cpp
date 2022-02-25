void print(char String){
    *(char*)0xb8000 = String;
    return;
}

extern "C" void main(){
    print('a');
    return;
}