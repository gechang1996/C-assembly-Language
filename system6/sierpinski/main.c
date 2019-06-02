/**
 * @file main.c
 * Simple program to test and demonstrate the sierpinski function.
 */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>


void display(int *cells, int size);
void sierpinski(int *cells, int size);


int main(int argc, char **argv)
{
	int i;
	
	if(argc < 3) 
	{
		printf("Usage: sierpinski width height\n");
		return 1;
	}
	
	int width = atoi(argv[1]);
	int height = atoi(argv[2]);
	
	if(width < 2) 
	{
		printf("Width must be at least 2\n");
		return 1;
	}
	
	if(height < 2) 
	{
		printf("Height must be at least 2\n");
		return 1;
	}
	
	/*
	 * Allocate memory for the row of cells
	 */
	int *cells = (int *)calloc(width, sizeof(int));
	
	// Half way through the bits
	int w2 = width * 16;
	cells[w2/32] |= 1 << (31 - (w2 % 32));
	
	
	display(cells, width);
	
	for(i=1; i<height; i++)
	{
		sierpinski(cells, width);
		display(cells, width);
	}
	
	
	free(cells);
	return 0;
}

void display(int *cells, int size)
{
	int i;
	
	for(; size > 0; cells++, size--) 
	{
		for(i=0; i<32; i++) 
		{
			if((*cells << i) & 0x80000000)
			{
				printf("1");
			} 
			else
			{
				printf("0");
			}
		}
	}
	
	printf("\n");
}

