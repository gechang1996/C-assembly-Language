#include<stdlib.h>
#include<stdio.h>
#include<string.h>
#define BINARY_SIZE 10

/**
   create a LinkedListNode for containing strings
  and create a pointer next to point to the next Node
  **/
typedef struct LinkedListNode
{
  char *name;
  struct LinkedListNode *next;
} LinkedListNode;

/**
  create a LinkedList which has two pointers. One is the head pointer. The other
  one is the tail pointer
  **/

typedef struct
{
  LinkedListNode *head;
  LinkedListNode *tail;
} LinkedList;
/** 
  initialize the list, make its head and tail become null pointer
  **/

void initialize_list(LinkedList *list)
{
  list->head =NULL;
  list->tail =NULL;
}

/**
  this function is used for adding string to the LinkedList
  **/
void add(char* str, LinkedList *stack)
{
      LinkedListNode *node1=(LinkedListNode *)calloc(1,sizeof(LinkedListNode));
      node1 ->next=NULL;
      node1 ->name = (char *) calloc (BINARY_SIZE+1,sizeof(char));
      strncpy(node1->name,str,BINARY_SIZE);
      /**
        check if the stack is an empty LinkedList
        if It is, then let the head and tail become the created node
        if not,make the first of the stack become the second one and make the created
        node become the first one.
        **/
      if (stack->head == NULL)
      {
        stack -> head=node1;
        stack -> tail=node1;
      }
      else
      {
        
        
        node1->next=stack->head;
        stack->head=node1;
        
      }
}
/**
  this function is used for free a list
  **/
void free_list(LinkedList *list)
{
    LinkedListNode *node;

    for (node = list->head; node != NULL;  )
    {
      LinkedListNode *next = node->next;

      free(node->name);
      free(node);

      node = next;
    }

    list->head = NULL;
    list->tail = NULL;
}



/**
  this function is used for remove the first node of the LinkedList and return
  the name of it;
  **/
char *pop(LinkedList *stack)
{
 if (stack ->head !=NULL)
 {
  LinkedListNode *node =stack->head;
  
  char *my_str=(char *)calloc(BINARY_SIZE+1,sizeof(char));
  strncpy(my_str,stack->head->name,BINARY_SIZE); 
  stack->head = node->next;
  free(node ->name);
  free(node);
  /**
    you must free it later(in the main function
    **/
  return my_str;
 }
 else
 {
   return NULL;
 }
}

int main(int argc, char *argv[])
{
  LinkedList list;
  LinkedListNode *node;
  initialize_list(&list);
  char buffer[200];
  if (argc < 2)
  {
      printf("Usage: rpn file\n");
      return 1;
  }
/**
  open the file 
  **/
  FILE *fp = fopen(argv[1], "r");
  if (fp == NULL)
  {
      printf("Unable to open input file\n");
      return 1;
  }
/**
  read each line of the file
  **/
  while (fgets(buffer,sizeof (buffer),fp) !=NULL)
  {
/**
if this line is "print" line, print the first node of the linkedlist
**/
    if (buffer[0] =='p' && buffer[1] =='r')
    {
      node=list.head;
      if (node !=NULL)
      {
        printf("%s\n", node->name);
        
      }
      else
      {
        printf("** empty **\n");
      }
    }
/**
  if this line is a binary string, add it into the linkedlist
  **/
    else if (buffer[0] =='0' || buffer[0] =='1')
    {
      add(buffer,&list);

    }
 /**
   if this line is the "pop" line, remove the head of the linkedlist
   **/
    else if (buffer[0] =='p' && buffer[1] =='o')
    
    {
    char *A= pop(&list);
    free(A);
    }
/**
  if this line is the '|' line, Replace the two top stack items with the OR of
  their values.
  **/
    else if (buffer[0] =='|')
    {
      char *first=pop(&list);
      char *second=pop(&list);
      char *new_str=(char *)calloc(BINARY_SIZE+1,sizeof(char));
      strncpy(new_str,first,BINARY_SIZE+1);
      size_t i=0;
      while (i<BINARY_SIZE)
      {
        if (first[i]=='1' || second[i]=='1')
        {
          new_str[i]='1';
        }
        else
        {
          new_str[i]='0';
        }
        i=i+1;
      }
      add(new_str,&list);
      free(first);
      free(second);
      free(new_str);
    }
/** if this line is the '&' line ,Replace the two top stack items with the AND
 of their values.
 **/
    else if (buffer[0] =='&')
    {
      char *first=pop(&list);
      char *second=pop(&list);
      char *new_str=(char *)calloc(BINARY_SIZE+1,sizeof(char));
      strncpy(new_str,first,BINARY_SIZE+1);
      size_t i=0;
      while (i<BINARY_SIZE)
      {
        if (first[i]=='1' && second[i]=='1')
        {
          new_str[i]='1';
        }
        else
        {
          new_str[i]='0';
        }
        i=i+1;
      }
      add(new_str,&list);
      free(first);
      free(second);
      free(new_str);
    }
/**
  if this line is the "exit" line, break the while loop
  **/
    else if (buffer[0] =='e' && buffer[1]=='x')
    {
      break;
    }
  }
  printf("** goodbye **\n");
  /**
    remember to close the file and free the list
    **/
  free_list(&list);
  fclose(fp);
    
  return 0;  
}



