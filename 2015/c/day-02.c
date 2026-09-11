#include <stdio.h>
#include <stdlib.h>
#include "helpers.h"

int main()
{
    FILE *file = fopen("../input/day-02.txt", "r");
    char line[256];
    int sum1 = 0;
    int sum2 = 0;

    if (file == NULL) {
        printf("Unable to open file.");
        return 1;
    }

    while (fgets(line, sizeof(line), file)) {
        int a, b, c, l, w, h;
        int m = 0;
        sscanf(line, "%dx%dx%dx", &l, &w, &h);
        a = l*w;
        b = w*h;
        c = h * l;
        sum1 += 2 * (a + b + c) + min(min(a, b), c);
        m = (l + w + h) - max(max(l, w), h);
        sum2 += 2 * m + l * h * w;
    }

    fclose(file);

    printf("Part 1: %d\nPart 2: %d", sum1, sum2);
    return 0;
}
