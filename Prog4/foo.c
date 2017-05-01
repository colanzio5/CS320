#include <stdio.h>
#include <stdlib.h>

void fold(char c[]){
	int count, length, off;
	int bool = 1;
	char ch;
	length = strlen(c);
	length--;
	
	off = length % 20;
	count = 0;
	addchar(c,off,'\n');
	
	int i = 0;
	while(count < length){
		ch = c[i];
		printf("%c",ch);
		count++;
		i++;
		if(count == off){
			ch = c[i];
			printf("%c",ch);
			off++;
			foldprint(c,off);
			return;
		}
	}
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


void foldprint(char c[], int index){
	int i = index;
	int count = 0;
	int length = strlen(c);
	
	char ch;
	while(i <= length){
		ch = c[i];
		if(count == 20){
			printf("\n");
			printf("%c",ch);
			count = 0;
		}
		else{
			printf("%c",ch);
			i++;
			count++;
		}
	}
}


void parse(char s[]){
	int c = 0;
	int d = 0;
	char ch;
	
	while (s[c] != '\0'){
		ch = s[c];		
		if ((ch=='_')||(ch=='/')||(ch==':')||(ch=='?')||(ch=='&')||(ch==' ')){
			s[c] = '%';
			c++;
			if(ch=='_'){
				
				addchar(s,c,'5'); 
				addchar(s,c,'F'); c++;
			}
			/* if(ch=='/'){
				addchar(s,c,'2'); c++;
				addchar(s,c,'F'); c++;
			}
			if(ch==':'){
				addchar(s,c,'3'); c++;
				addchar(s,c,'A'); c++;
			}
			if(ch=='?'){
				addchar(s,c,'3'); c++;
				addchar(s,c,'F'); c++;
			}
			if(ch=='&'){
				addchar(s,c,'2'); c++;
				addchar(s,c,'6'); c++;
			}
			if(ch==' '){
				addchar(s,c,'2'); c++;
				addchar(s,c,'0'); c++;
			} */
		}
		else{
			c++;
		}
	}
}

void addchar(char c[], int pos, char foo){
	int length = strlen(c);
	int i = 0;
	
	c[length+1]= '\0';

	while(length > pos){
		c[length] = c[length - 1];
		length--;
	}
	c[pos-1] = foo;
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
		parse(s);
		fold(s);
		
		printf("%c",s);
		
		memset(s,0,strlen(s));
		memset(t,0,strlen(t));	
		
	}
  	
   	fclose( fp );
	exit(-1);
}

