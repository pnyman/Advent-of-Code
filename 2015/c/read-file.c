#include <stdio.h>
#include <stdlib.h>

int main()
{
    // Create a file pointer and open the file "GFG.txt" in read mode.
    FILE* file = fopen("../input/day-01.txt", "r");

    // Buffer to store each line of the file.
    char line[256];

    // Check if the file was opened successfully.
    if (file != NULL) {
        // Read each line from the file and store it in the 'line' buffer.
        while (fgets(line, sizeof(line), file)) {
            // Print each line to the standard output.
            printf("%s", line);
        }

        // Close the file stream once all lines have been read.
        fclose(file);
    }
    else {
        // Print an error message to the standard error
        // stream if the file cannot be opened.
        fprintf(stderr, "Unable to open file!\n");
    }

    return 0;
}
