/*
 * main.c
 *
 *  Created on: Jul 31, 2013
 *      Author: Francis Giraldeau <francis.giraldeau@gmail.com>
 */

#include <stdio.h>
#include <stdlib.h>

struct stack_frame {
	struct stack_frame* next;
	void* ret;
};

void print_call_stack(void) {
	register struct stack_frame* fp asm("rbp");
	struct stack_frame* frame = fp;
	struct stack_frame* prev = fp;

	printf("%-18s %-18s %-18s\n", "frame", "ret", "size");
	while (frame) {
		printf("%-18p %-18p %-18lx\n", frame, frame->ret, ((unsigned long)frame - (unsigned long)prev));
		prev = frame;
		frame = frame->next;
	}
}

int a(int x)
{
	if (x <= 0) {
		print_call_stack();
		return x;
	}
	return a(--x);
}

int main(int argc, char **argv)
{
	int n;

	n = atoi(argv[1]);
	printf("%10d %10d %10d\n", n, a(n));
	return 0;
}
