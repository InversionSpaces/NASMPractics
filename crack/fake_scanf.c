#define _GNU_SOURCE
#include <dlfcn.h>
#include <stdarg.h>
#include <string.h>

typedef int (*scanf_t)(const char*, ...);
typedef int (*puts_t)(const char*);

int __isoc99_scanf(const char* fmt, ...) {
	//scanf_t real_scanf = (scanf_t)dlsym(RTLD_NEXT, "scanf");
	puts_t puts = (puts_t)dlsym(RTLD_NEXT, "puts");

	puts("THIS PROGRAMM IS CRACKED");
	
	va_list args;
	va_start(args, fmt);

	char* straddr = va_arg(args, char*);
	strcpy(straddr, "1111110111111");

	va_end(args);
	
	return 1;
}
