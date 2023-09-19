#include <stdio.h>
#include <unistd.h>
int main()
{
    int a =0;
    for (int i = 0; i < 3; i++)
    {
        fork();
        a++;
        printf("%d Hello World\n",a);
    }
   // printf("end\n");
}
