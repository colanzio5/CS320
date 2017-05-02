#include <stdio.h>
#include <stdlib.h>

//Colin Casazza
//cssc0112
//John Carroll
//CS320

void addchar(char d[], int pos, char *s){			//adds character s to string d at position pos
	char * b;

	b = (char*)malloc(strlen(d)+strlen(s)+1);		
	strncpy(b,d,pos);
	b[pos] = '\0';
	strcat(b,s);
	strcat(b,d+pos);
	strcpy(d,b);q
	free(b);
}
void fold(char c[]){						//fold finds the offset for the first prefold
	int count, length, off;					
	int bool = 1;
	char ch;
	length = strlen(c);
	off = length % 20;
	off--;							//offset offset by one
	
	int i = 0;
	foldprint(c,off);					//pass the offset and the array into foldprint
}

void caseswap(char s[]){					//swaps all a-z with all A-Z
	int c = 0;
	char ch;	
	while (s[c] != '\0') {					
      		ch = s[c];
      		if (ch >= 'A' && ch <= 'Z')			//if uppercase, cast to lowercase
        		 s[c] = s[c] + 32;
      		else if (ch >= 'a' && ch <= 'z')		//if lowercase, cast to uppercase
         		s[c] = s[c] - 32;   
      		c++;   
   	}	 
}


void foldprint(char c[], int off){				//prints out a new line if count is 20 (normal fold condition)
	int i = 0;						//prints out a new line if the offset is reached and prefold
	int count = 0;						//(determined by off and bool) hasen't happened yet.
	int length = strlen(c);
	int bool = 1;
	
	char ch;
	while(i <= length){
		ch = c[i];
		if((i == off) && (bool == 1)){			//initial prefold new line
			printf("\n");
			bool = 0;
			count = 0;
		}
		if(count == 20){				//fold for other lines greater than 20 char
			printf("\n");
			count = 0;
		}
		else{						//else print char
			printf("%c",ch);
			i++;
			count++;
		}
	}
}


void parse(char s[], char t[]){					//when a 'special char' is reached in input buffer s,
	int c = 0;						//the three matching characters are added to outut buffer t
	int d = 0;
	char ch;
	
	while (s[c] != '\0'){
		ch = s[c];					//set ch and see if its equal to any special chars
		if ((ch=='_')||(ch=='/')||(ch==':')||(ch=='?')||(ch=='&')||(ch==' ')){
			t[d] = '%';
			d++;
			if(ch=='_'){				//when match occurs add new characters to output buffer and move index
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
		if((ch < 0) || (ch > 127)){			//characters that are non ascii are ignored (not passed to output buffer)
			c++;
		}
		else {
			t[d] = ch;				//all other characters are passed to output buffer normally
			d++; c++;
		}	
	}
}


void print(char *t) {						//recursively print the contents of a string
   if (*t == '\0')						//break when end of line is reached
      return;
   printf("%c", *t);
   print(++t);
}


int main(int argc, char *argv[]){
	
	int i = 1;
	FILE *fp;
	int c = 0;
	char ch, s[1024];					//input buffer
								
	int d = 0;
	char dh, t[1024];					//output buffer for results of parse
		
	while(i < argc){					//loop through the input arguments
		fp = fopen(argv[i], "r");
	
   		if(fp == NULL ) {				//if file is null exit(0)
			printf("Input File Was Null");		
			perror(argv[0]);
			exit(0);				//exit with error condition
		}
		printf("\n");
   		while (fgets( s, sizeof s, fp) != NULL ){	//if file was not null, get each line
					
			caseswap(s);				
			parse(s,t);
			fold(t);				//caseswap and parse must be first because fold is a print,
								//to terminal focused function
		
			memset(s,0,strlen(s));			//clear s and t from memory so no garbage is present in next			
			memset(t,0,strlen(t));			//lines
		}
		
   		fclose( fp );
		i++;
	}
	exit(-1);						//after all filse open successfully, exit(-1);
}

