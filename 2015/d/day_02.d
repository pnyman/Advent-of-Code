import std.stdio;
import std.array : split;
import std.conv : to;
import std.format : formattedRead;
import std.algorithm.comparison;

void main() {
  File file = File("../input/day-02.txt", "r");
  int sum1 = 0;
  int sum2 = 0;

  foreach (line; file.byLine()) {
    int a, b, c, l, w, h;
    int m = 0;
    // auto lineCopy = line.idup;  // formattedRead vill ofta ha en mutable/egen kopia
    formattedRead(line, "%dx%dx%d", &l, &w, &h);
    a = l * w;
    b = w * h;
    c = h * l;
    sum1 += 2 * (a + b + c) + min(a, b, c);
    m = (l + w + h) - max(l, w, h);
    sum2 += 2 * m + l * h * w;
  }

  writeln("Part 1: ", sum1);
  writeln("Part 2: ", sum2);
}
