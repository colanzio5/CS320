#include <stdio.h>
#include <stdlib.h>

void addchar(char d[], int pos, char *s){
	char * b;

	b = (char*)malloc(strlen(d)+strlen(s)+1);
	strncpy(b,d,pos);
	b[pos] = '\0';
	strcat(b,s);
	strcat(b,d+pos);
	strcpy(d,b);
	free(b);
}
void fold(char c[]){
	int count, length, off;
	int bool = 1;
	char ch;
	length = strlen(c);
	off = length % 20;
	off--;
	
	int i = 0;
	foldprint(c,off);
}

void caseswap(char s[]){
	int c = 0;
	char ch;
	while (s[c] != '\0') {
      		ch = s[c];
      		if (ch >= 'A' && ch <= 'Z')
        		 s[c] = s[c] + 32;
      		else if (ch >= 'a' && ch <= 'z')
         		s[c] = s[c] - 32;   
      		c++;   
   	}	 
}


void foldprint(char c[], int off){
	int i = 0;
	int count = 0;
	int length = strlen(c);
	int bool = 1;
	
	char ch;
	while(i <= length){
		ch = c[i];
		if((i == off) && (bool == 1)){
			printf("\n");
			bool = 0;
			count = 0;
		}
		if(count == 20){
			printf("\n");
			count = 0;
		}
		else{
			printf("%c",ch);
			i++;
			count++;
		}
	}
}


void parse(char s[], char t[]){
	int c = 0;
	int d = 0;
	char ch;
	
	while (s[c] != '\0'){
		ch = s[c];		
		if ((ch=='_')||(ch=='/')||(ch==':')||(ch=='?')||(ch=='&')||(ch==' ')){
			t[d] = '%';
			d++;
			if(ch=='_'){
				t[d] = '5'; d++;
				t[d] = 'F'; d++;
			}
			if(ch=='/'){
				t[d] = '2'; d++;
				t[d] = 'F'; d++;
			}
			if(ch==':'){
				t[d] = '3'; d++;
				t[d] = 'A'; d++;
			}
			if(ch=='?'){
				t[d] = '3'; d++;
				t[d] = 'F'; d++;
			}
			if(ch=='&'){
				t[d] = '2'; d++;
				t[d] = '6'; d++;
			}
			if(ch==' '){
				t[d] = '2'; d++;
				t[d] = '0'; d++;
			}
			
		c++;
		}
		else {
			t[d] = ch;
			d++; c++;
		}	
	}
}


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
		
		caseswap(s);
		parse(s,t);
		fold(t);
		
		memset(s,0,strlen(s));
		memset(t,0,strlen(t));		
	}
  	
   	fclose( fp );
	exit(-1);
}

