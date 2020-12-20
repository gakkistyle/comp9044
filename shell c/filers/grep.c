//
//  grep.c
//  shell
//
//  Created by 郑淇文 on 2020/6/1.
//  Copyright © 2020 郑淇文. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void process_stream(FILE *stream,char *stream_name,char *substring){
    char line[65536];
    int line_number = 1;
    while(fgets(line, sizeof line, stream) != NULL){
        if (strstr(line,substring) != NULL)
            printf("%s:%d:%s",stream_name,line_number,line);
        line_number = line_number + 1;
    }
}

int main(int argc,char *argv[]){
    if(argc == 2)
        process_stream(stdin, "<stdin>", argv[1]);
    else
        for(int i=2;i<argc;i++){
            FILE *in = fopen(argv[i],"r");
            if(in == NULL){
                fprintf(stderr,"%s: %s: ",argv[0],argv[i]);
                perror("");
                return 1;
            }
            process_stream(in,argv[i],argv[1]);
            fclose(in);
        }
    return 0;
}
