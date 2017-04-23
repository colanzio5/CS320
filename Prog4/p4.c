
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]){
	char ch;
	int count = 0;
	FILE *fp;
	fp = fopen(argv[1],"r");
	
	while((ch = fgetc(fp)) != EOF){
		if( count < 20 ){
			if(isalpha(ch)){
				if(isupper(ch)){
					printf("%c", tolower(ch));
					count++;
				}
				else{ 
					printf("%c", toupper(ch));
					count++;
				}
			}
			else if( (ch == '\t'))	{
				printf("%%%x",ch);
			
			}

			else	{
				printf("%c", ch);
				count++;
			}	
		}
		if (count == 20) {
			printf("\n");
			count = 0;
		}
	}

	fclose(fp);
	return(0);	
}
