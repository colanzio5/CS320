#include <stdio.h>
#include <stdlib.h>

void addchar(char destination[], int pos, char *seed){
	char * strC;

	strC = (char*)malloc(strlen(destination)+strlen(seed)+1);
	strncpy(strC,destination,pos);
	strC[pos] = '\0';
	strcat(strC,seed);
	strcat(strC,destination+pos);
	strcpy(destination,strC);
	free(strC);
}
void fold(char c[]){
	int count, length, off;
	int bool = 1;
	char ch;
	length = strlen(c);
	length--;
	
	int i = 0;
	while(i < length){
		ch = c[i];
		if((i == off)){
			addchar(c, i, "\n");
			bool = 0;
		}
		count++;
		i++;
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
	printf("\n");
}


void parse(char s[]){
	int c = 0;
	int d = 0;
	char ch;
	
	while (s[c] != '\0'){
		ch = s[c];
		c++;		
		if ((ch=='_')||(ch=='/')||(ch==':')||(ch=='?')||(ch=='&')||(ch==' ')){
			s[c] = '%'; 			//REPLACE WITH %(asciicode)
			if(ch=='_'){			//ex. _ is replaced with %5F
				addchar(s,d,"5");
				addchar(s,d,"F");
			}
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
		//parse(s);
		
		
		//fold(s);
		print(s);
		
		memset(s,0,strlen(s));
		memset(t,0,strlen(t));	
		
	}
  	
   	fclose( fp );
	exit(-1);
}

