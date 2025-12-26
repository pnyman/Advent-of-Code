#include <stdio.h>

static inline int floor100(int x) {
    return (x >= 0) ? x / 100 : (x - 99) / 100;
}

int passes(int start, int step) {
    int end = start + step;
    if (step > 0) return floor100(end);
    if (step < 0) return floor100(start - 1) - floor100(end - 1);
    return 0;
}

int main() {
    FILE *fptr = fopen("../input/day-01-input.txt", "r");
    char line[100] = {0};
    char rot;
    int value;
    int arrow_1 = 50, arrow_2 = 50, zeroes = 0, clicks = 0;

    while (fgets(line, 100, fptr)) {
        sscanf(line, "%c%d", &rot, &value);
        if (rot == 'L') value *= -1;
        arrow_1 += value;
        if ((arrow_1 % 100) == 0) zeroes++;
        clicks += passes(arrow_2, value);
        arrow_2 = ((arrow_2 + value) % 100 + 100) % 100;
    }

    printf("zeroes: %d\n", zeroes); // 1135
    printf("clicks: %d\n", clicks); // 6558
    fclose(fptr);

    return 0;
}
