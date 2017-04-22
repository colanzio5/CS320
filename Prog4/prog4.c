
 
#include <stdio.h>
#include <stdlib.h>
 
int main(int argc, char *argv[])
{
   
   char ch;
   FILE *fp;
   fp = fopen(argv[1],"r"); // read mode
 
   if( fp == NULL )
   {
      perror("Error while opening the file.\n");
      exit(EXIT_FAILURE);
   }
 
   while( ( ch = fgetc(fp) ) != EOF ){
      printf("%c",ch);
   }

   system("echo hello1234"); 
   fclose(fp);
   return 0;
}
