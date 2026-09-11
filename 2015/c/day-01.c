#include <stdio.h>
#include <stdbool.h>

int main(void)
{
    char ch;
    int pos = 0;
    int floor = 0;
    bool found = false;

    FILE *fp = fopen("../input/day-01.txt", "r");

    if (fp == NULL) {
        printf("Unable to open file.");
        return 1;
    }

    while ((ch = fgetc(fp)) != EOF) {
        if (!found) pos++;
        if (ch == '(') floor++;
        if (ch == ')') floor--;
        if (floor == -1) found = true;
    }

    fclose(fp);

    printf("Part 1:  %d\nPart 2: %d\n", floor, pos);
    return 0;
}
