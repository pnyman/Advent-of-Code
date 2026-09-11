import std.stdio;

void main() {
    File file = File("../input/day-01.txt", "r");
    char[1] buf;
    int floor = 0;
    ulong pos;

    while (!file.eof()) {
        auto result = file.rawRead(buf);
        if (result.length == 0) break;
        char c = result[0];

        if (c == '(') { floor++; }
        else if (c == ')') { floor--; }

        if (floor == -1 && !pos) {
          pos = file.tell();
        }
    }

    writeln("Part 1:  ", floor);
    writeln("Part 2: ", pos);
}
