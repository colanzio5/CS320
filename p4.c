 
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

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

void fold(char out[]){
	int count = 0;
	int length;
	
	int i = 0;
	char ch;
	int off;
	
	ch = out[count];
	while(ch != '\n'){
		count++;
		ch = out[count];
	}
	
	length = count;	
	count--;	 
	off = count % 20;
	off++;

	addchar(out,off,length);
	
	i = 0;
	ch = out[off];
	
	while(off <= count){
		if(i == 20){
			addchar(out,off,length);
			i = 0;
		}
		i++;
		off++;
		ch = out[off];
	}
	out[off+1] = '\n';		
}

void addchar(char out[], int index, int length){
	int k = 0;
	char ch = out[k];
	while(k < length){
		k++;
		ch = out[k];
	}
	k--;
	while(k >= index){
		out[k+1] = out[k];
		if(k == index){
			out[k] = '\n';
		}
		k--;
	}
}

void noascii(char out[]){
	int i = 0;
	int j = 0;
	char ch = out[i];
	
	while(ch != '\0'){
		if(ch > 127){
			j = i;
			while(out[j] != '\0'){
				out[j] = out[j+1];
				j++;
			}	
		}
		i++;
		ch = out[i];
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
		
	fp = fopen(argv[1], "r");
   	if(fp == NULL ) {
		printf("Input File Was Null");
		perror(argv[0]);
		exit(0);
	}

   	while (fgets( s, sizeof s, fp) != NULL ){
		
		caseswap(s);
		noascii(s);
		parse(s,t);
		fold(t);
		print(t);
		
	}
  	
   	fclose( fp );
	exit(-1);
}
