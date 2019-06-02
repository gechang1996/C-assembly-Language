#include <stdlib.h>
#include <string.h>
#include "binarymath.h"



/**
 * Increment a BINARY_SIZE binary number expressed as a 
 * character string.
 * @param number The number we are passed
 * @returns Incremented version of the number
 */
char *inc(const char *number)
{
    size_t required=strlen(number)+1;
    char *result=(char *)malloc(required);
    strncpy(result, number,required);
/**
 if the last digit is 0,then make it 1
 if the last digit is 1,then make it 0 and so on. 
 **/
    while (required-1>0)
    {
      if (result[required-2]=='0')
      {
        result[required-2]='1';
        break;
      }
      else if (result[required-2]=='1')
      {
        result[required-2]='0';
        required=required-1;
      }
    }
    return result;
}


/**
 * Negate a BINARY_SIZE binary number expressed as a character string
 * @param number The number we are passed
 * @returns Incremented version of the number
 */
char *negate(const char *number)
{
    size_t required=strlen(number)+1;
    char *result=(char *)malloc(required);
    strncpy(result,number,required);
    /**
      reverse each digit and add 1 to the reversed string
      **/
    while (required-1>0)
    {
      if (result[required-2]=='0')
      {
        result[required-2]='1';
      }
      else
      {
        result[required-2]='0';
      }
      required=required-1;
    }
    char *result1=inc(result);
    free(result);
    return result1;
}

/**
 * Add two BINARY_SIZE binary numbers expressed as
 * a character string. 
 * @param a First number to add
 * @param b Second number to add
 * @return a + b
 */
char *add(const char *a, const char *b)
{
    size_t required=strlen(a)+1;
    size_t remain=0;
    char *result=(char *)malloc(required);
    strncpy(result,a,required);
    /* 
       add each digit of these two strings and the remain , if sum is 0, then
       keep 0 and remain=0;
       if sum is 1 then keep 1 and remain=0
       if sum is 2 then keep 0 and remain=1
       if sum is 2 then kepp 1 and remain=1
       **/
    while (required-1>0)
    {
      if (a[required-2]=='1')
      {
        remain=remain+1;
      }
      if (b[required-2]=='1')
      {
        remain=remain+1;
      }
      if (remain==0)
      {
        result[required-2]='0';
      }
      else if (remain ==1)
      {
        result[required-2]='1';
        remain=remain-1;
      }
      else if (remain ==2)
      {
        result[required-2]='0';
        remain=remain-1;
      }
      else if (remain ==3)
      {
        result[required-2]='1';
        remain=remain-2;
      }
      required=required-1;
    }



    return result;
}

/**
 * Subtract two BINARY_SIZE binary numbers expressed as
 * a character string.
 * @param a First number
 * @param b Second number 
 * @return a - b
 */
char *sub(const char *a, const char *b)
{
  /**
    first find the negated b, then use add funcion to add them together
    **/
    char *ne_b=negate(b);
    char *result=add(a,ne_b);
    free(ne_b);
    return result;
}

