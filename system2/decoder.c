#include "decoder.h"
#include <string.h>
/**
 * Decode an encoded string into a character stream.
 * @param encoded The input string we are decoding
 * @param decoded The output string we produce
 * @param maxLen The maximum size for decoded
 */
void decoder(const char *encoded, char *decoded, int maxLen)
{
    // This is just a copy so it has something in decoded
    unsigned int a=strlen(encoded);
    unsigned int b= 0;
    unsigned int count=0;
    unsigned char my_str[10000];
/**
  this is the rule for decoding the encoded to binary numbers
  */
    while (b<a)
    {
      
      if (encoded[b]=='2')
      {
        my_str[count]='0';
        my_str[count+1]='0';
        my_str[count+2]='0';
        count=count+3;     
      }
      if (encoded[b]=='g')
      {
        my_str[count]='0';
        my_str[count+1]='0';
        my_str[count+2]='1';
        count=count+3;
      }
      if (encoded[b]=='S')
      {
        my_str[count]='0';
        my_str[count+1]='1';
        my_str[count+2]='0';
        count=count+3;
      }
      if (encoded[b]=='0')
      { 
        my_str[count]='0';
        my_str[count+1]='1';
        my_str[count+2]='1';
        count=count+3;
      }
      if (encoded[b]=='7')
      {
        my_str[count]='1';
        my_str[count+1]='0';
        my_str[count+2]='0';
        count=count+3;
      }
      if (encoded[b]=='B')
      {
        my_str[count]='1';
        my_str[count+1]='0';
        my_str[count+2]='1';
        count=count+3;
      }
      if (encoded[b]=='n')
      {
        my_str[count]='1';
        my_str[count+1]='1';
        my_str[count+2]='0';
        count=count+3;
      }
      if (encoded[b]=='o')
      {
        my_str[count]='1';
        my_str[count+1]='1';
        my_str[count+2]='1';
        count=count+3;
      }
      if (encoded[b]=='=')
      {
        my_str[count]='0';
        my_str[count+1]='0';
        count=count+2;
      }
      if (encoded[b]=='-')
      {
        my_str[count]='0';
        my_str[count+1]='1';
        count=count+2;
      }
      if (encoded[b]=='Y')
      {
        my_str[count]='1';
        my_str[count+1]='0';
        count=count+2;
      }
      if (encoded[b]=='T')
      {
        my_str[count]='1';
        my_str[count+1]='1';
        count=count+2;
      }     
      b=b+1; 
    }
    unsigned int G=0;
    unsigned count1=0;
    unsigned int sum=0;
    unsigned int start=128;
    char my_char;
/**
  use the string which contains the binary numbers we get to do the next step
  run this loop strlen(my_str) times
  */
    while (G<count)
    {
/**
  check if the decoded size is larger than the maxlen
  */
      if (count1<maxLen)
      {
/**
  after decoding a character, put this character into decoded
  */
        if(G%8==0 && G!=0)
        {
          my_char=sum;
          decoded[count1]= my_char;
          count1=count1+1;
          start=128;
          

          sum=0;
        }

        if ( my_str[G]=='1')
        {
          sum=sum+start;
          start=start/2;


        }
        else
        {
          start=start/2;
  
        }

        



        G=G+1;
      }







    }

}

