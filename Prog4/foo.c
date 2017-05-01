#include <stdio.h>
#include <stdlib.h>

void fold(char c[]){
	int count, length, off;
	int bool = 1;
	char ch;
	length = strlen(c);

	
	off = length % 20;
	count = 0;
	printf("%i, %i ||\n", length, off);
	
	int i = 0;
	while(ch != '\0'){
		ch = c[i];
		printf("%c",ch);
		
		count++;
		i++;
		ch = c[i];
		
		if((count < off) && (bool)){
			ch = '\n';
			printf("%c",ch);
			
			count = 0;
			bool = 0;
		}
		if((count%20) == 0){
			ch = '\n';
			printf("%c",ch);
			count = 0;
		}
	}
}

/* void append(char subject[], const char insert[], int pos) {
	char buf[100] = {}; 

	strncpy(buf, subject, pos); 
	int len = strlen(buf);
	strcpy(buf+len, insert); 
	len += strlen(insert);  
	strcpy(buf+len, subject+pos); 
	strcpy(subject, buf); 
} */

void print(char *t) {
   if (*t == '\0')
      return;
   printf("%c", *t);
   print(++t);
}

int main(int argc, char *argv[]){

	
	FILE *fp;
	int c = 0;
	char ch, s[1024];
		
	int d = 0;
	char dh, t[1024];
	
	char eh, q[1024];
		
	fp = fopen(argv[1], "r");
   	if(fp == NULL ) {
		printf("Input File Was Null");
		perror(argv[0]);
		exit(0);
	}

   	while (fgets( s, sizeof s, fp) != NULL ){
		
		fold(s);
	}
  	
   	fclose( fp );
	exit(-1);
}

