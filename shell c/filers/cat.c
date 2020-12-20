//
//  main.c
//  shell
//
//  Created by 郑淇文 on 2020/5/29.
//  Copyright © 2020 郑淇文. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>

void process_stream(FILE *in){
    while(1){
        int ch = fgetc(in);
        if (ch==EOF)
            break;
        if (fputc(ch,stdout)==EOF){
            fprintf(stderr,"cat:");
            perror("");
            exit(1);
        }
    }
}

int main(int argc,char *argv[]){
    if(argc == 1)
        process_stream(stdin);
    else
        for(int i = 1;i < argc; i++){
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
