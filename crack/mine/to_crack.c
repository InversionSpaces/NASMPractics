#include <stdio.h>
#include <string.h>

const char* const password = "WhrIsDenuvoCrck";

void print_secret() {
	printf("Secret: CAKE IS A LIE!\n");
}

int main() {
	printf("Enter password: ");
	
	struct {
		char password[16];
		char valid;
	} auth = {"", 0};
	
	scanf("%[^\n]", auth.password);
	if (strcmp(auth.password, password) == 0)
		auth.valid = 1;

	if (auth.valid)
		print_secret();
	else
		printf("Wrong password\n");
}
