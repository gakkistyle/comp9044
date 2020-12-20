//
//  uniq.c
//  shell
//
//  Created by 郑淇文 on 2020/6/1.
//  Copyright © 2020 郑淇文. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_LINE 65536

void process_stream(FILE *stream){
    char line[MAX_LINE];
    char lastLine[MAX_LINE];
    int line_number = 0;
    
    while (fgets(line,MAX_LINE, stream) != NULL) {
        if (line_number == 0 || strcmp(line,lastLine)!=0){
            fputs(line,stdout);
            strncpy(lastLine,line,MAX_LINE);
        }
        line_number ++;
    }
}


int main(int argc,char *argv[]){
    if(argc == 1)
        process_stream(stdin);
    else
        for (int i = 1;i<argc;i++){
            FILE *in = fopen(argv[i],"r");
            if(in == NULL){
                fprintf(stderr,"%s: %s: ",argv[0],argv[i]);
                perror("");
                return 1;
                
            }
            process_stream(in);
            fclose(in);
        }
    return 0;
}
