#include <stdio.h>
#include <stdbool.h>
#include "is42.h"

int main(){
	int y = 42;
	int x = is42(y);
	printf("Number passed is %i\nNumber returned is %i\n",y,x);
	if(x){
		printf("It's 42\n");
	}
	else{
		printf("It's not 42\n");
	}
	printf("%i\n",return4());
}
