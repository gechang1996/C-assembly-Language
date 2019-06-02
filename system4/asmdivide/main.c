/**
 * @file main.c
 * Simple program to test the assembly multiplication functions.
 */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int dumb_divide(int a, int b);
int divide(int a, int b);
int signed_divide(int a, int b);

void test_dumb(int a, int b);
void test_divide(int a, int b);
void test_signed(int a, int b);

int main()
{
    test_dumb(4, 2);
    test_dumb(1000, 5);
    test_dumb(0, 1000);
    test_dumb(57, 13);
    test_dumb(13, 57);
    test_dumb(5, 1000); 
    test_dumb(60000, 2);    
    
    printf("\n");
    
    test_divide(4, 2);
    test_divide(1000, 5);
    test_divide(0, 1000);
    test_divide(57, 13);
    test_divide(13, 57);
    test_divide(5, 1000);   
    test_divide(60000, 2);  
    
    printf("\n");
    
    test_signed(-3, 2);
    test_signed(-3, -2);
    test_signed(3, 2);  
    test_signed(3, -2);     
    test_signed(-5, 7);
    test_signed(23, -37);
    test_signed(0, -1000);
    test_signed(-1000, 5);
    test_signed(-5, 1000);  
    test_signed(1000, -5);
    test_signed(5, -1000);  
    test_signed(60000, 2);  
    test_signed(-60000, 2); 
    test_signed(60000, -2); 
    test_signed(-60000, -2);    
        
    return 0;
}

void test_dumb(int a, int b)
{
    int quotient = dumb_divide(a, b);
    printf("Dumb: %d / %d = %d / should be %d\n", a, b, quotient, a / b);
}


void test_divide(int a, int b)
{
    int quotient = divide(a, b);
    printf("Efficient divide: %d / %d = %d / should be %d\n", a, b, quotient, a / b);
}

void test_signed(int a, int b)
{
    int product = signed_divide(a, b);
    printf("Signed Divide: %d / %d = %d / should be %d\n", a, b, product, a / b);
}

int times3(int a)
{
    return a * 3;
}

int time2(int b)
{
    return times3( b * 2);
}

