/* Colin Casazza - cssc0112, Professor Carroll, CS320, Due 2/22/17 */ 

/* This code works by first reading in a char array buffer of length 20 ( + 1 
 * for '/0'. Next an iderator indexes through all elements of the buffer and 
 * tests the current index. If it's a special char, it prints/returns the hex 
 * code to the user. Otherwise the iderator prints the normal, lowercast value.
 * Return value is triggered in the if clause that determines when there's 
 * special characters.
 *
 * Downsides to this code is that the new, modified array is not returned to 
 * it's own char array, nor is the origional buffer modified/prezerved through
 * the output, which doesn't necessairly reflect good practice either. 
 * 
 * A redesign of this would definetly only act on one char array functionally
 * to ensure efficiency and general good practice.
*/


#include <stdio.h>
#include <string.h>


int main(void)	{

	
	char buffer[20 + 1];
	char output[256];
	char b;
	int in;
	int ret = 0;
	int i = 0; //buffer pointer

	in = scanf("%20[^\n]s", buffer);	
	
	printf("\n\n");
	while( i < strlen(buffer))	{
		
		b =buffer[i];
		
		if( (b == '_') || (b == '?')  || (b == ':') || (b == '/') || (b == '&') || (b == ' ') )  {
			printf("%%");
			printf("%x", buffer[i]);
			ret = 1;
		}
		
		else	{
			printf("%c", tolower( buffer[i]) );
		}								
	++i;	
	}
	printf("\n");
	return ret;

}
