#include <stdio.h>
#include <memory.h>

int main(int argc, char** argv) {
	if (argc != 2) {
		puts("Specify the file");
		return 1;
	}

	FILE* file = fopen(argv[1], "r+");
	if (!file) {
		puts("Failed to open");
		return 1;
	}

	size_t start = 0x000011fa;
	size_t end = 0x0000125a;
	size_t size = end - start + 1;
	
	char block[size];
	memset(block, 0x90, size);

	fseek(file, start, SEEK_SET);
	fwrite(block, 1, size, file);

	fclose(file);
}
