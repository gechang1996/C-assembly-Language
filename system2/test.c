#include<stdio.h>
#include<string.h>
int main()
{
  unsigned char *x="abcdefghijklmn";
  char my_str[1000];
  my_str[0]='a';
  my_str[1]='b';
  unsigned int b=40;
  char A= b;
  my_str[2]= A ;
  char my_str1[1000];
  my_str1[0]=my_str[0];
  int my_int=10%8;
  printf("%s\n",my_str1);
  printf("%s\n", my_str);

}
