#include "bin2dec.h"
#include <string.h>
/**
 * Convert a binary representation of a 
 * number to an unsigned integer. 
 * 
 * For this function, the values T and F represent 
 * true (1) and false (0). So, the string:
 * 
 * TTFT is equal to 1101 binary, which is equal to 13.
 *
 * Unexpected characters are ignored. Only 1's and 0's are
 * considered to be valid. Stop converting when you get
 * to a space character or the end of the string. The 
 * representation is case-insensitive (both T/F and t/f 
 * are valid true and false values).
 *
 * 'aTFcT TT' should convert to 5
 * 'ftft' should convert to 5
 *
 * @param binary Binary number as a string of 'T's and 'F's. 
 * @returns unsigned int result
 */
unsigned int bin2dec(const char *binary)
{
   unsigned int a_size=strlen(binary);
   unsigned int my_pow=1;
   unsigned int result=0;
   while (a_size>=1)
   {
/**
  check if this bit is ' ', if it is , reset the pow and result
  If it is a t or T ,then add this pow into the result and do pow times 2
  IF it is a f or F, Thne just do pow times 2.
  */
      
      if (binary[a_size-1] == ' ')
      {
        result=0;
        my_pow=1;
      }
     
      if (binary[a_size-1] == 't' || binary[a_size-1] =='T')
      {
        result =result +my_pow;
        my_pow=my_pow*2;

      }  
      else if(binary[a_size-1] =='f' || binary[a_size-1] =='F')
      {
        my_pow=my_pow*2;
      }
      
      a_size=a_size-1;
   }
   
   
  return result;
}
