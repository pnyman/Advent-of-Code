#include <stdio.h>
#include <stdlib.h>
#include "uthash.h"
#include "utarray.h"
#include "helpers.h"

char *input = "../input/day-03.txt";

typedef struct {
    int x, y;
} House;


int main()
{
    FILE *file = fopen(input, "r");
    char line[256];

    if (file == NULL) {
        printf("Unable to open file.");
        return 1;
    }

    while (fgets(line, sizeof(line), file)) {
    }

    fclose(file);

    return 0;
}
