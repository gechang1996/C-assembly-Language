#include<stdlib.h>
#include<stdio.h>
#include<string.h>

void tobinary(char* result,double value)
{
  result[0]='0';
  result[1]='.';
  int i=2;
  double power =1;
  while(value>0 && i<32)
  {
    power /=2;
    if (value >=power)
    {
      result[i++]='1';
      value -=power;
    }
    else
    {
      result[i++] ='0';
    }
  }
  result[i]='\0'; 
}

int main()
{
  char* result=(char *)calloc(36,sizeof(char));
  tobinary(result,)
