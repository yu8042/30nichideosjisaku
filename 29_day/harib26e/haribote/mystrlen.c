int strlen(const char* str){
    int length = 0; // (1)文字列の長さを入れる箱

   // (2)文字列の長さを数える
    while(*str++ != '¥0'){
        length++;
    }
    return length;
}
