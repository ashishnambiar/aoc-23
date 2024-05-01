import 'dart:io';
import 'dart:math';

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    print('missing args');
    return;
  }

  final f = File(arguments[0]);
  final dot = '.'.runes.first;
  final nums =
      List.generate(10, (index) => index).fold('', (p, e) => '$p$e').runes;

  final values = <Value>[];
  final chars = <Point<int>>[];
  final lines = <String>[];
  for (final (y, line) in f.readAsLinesSync().indexed) {
    lines.add(line);
    final str = StringBuffer();
    Point<int>? start;

    for (var (x, rune) in line.runes.indexed) {
      if (rune == dot) {
        if (str.isNotEmpty) {
          values.add(Value(start!, Point(x, y), int.parse(str.toString())));
          str.clear();
        }
        continue;
      }

      if (nums.contains(rune)) {
        if (str.isEmpty) {
          start = Point(x, y);
        }
        str.write(String.fromCharCode(rune));
        continue;
      }

      if (str.isNotEmpty) {
        values.add(Value(start!, Point(x, y), int.parse(str.toString())));
        str.clear();
      }
      chars.add(Point(x, y));
    }
    if (str.isNotEmpty) {
      values
          .add(Value(start!, Point(line.length, y), int.parse(str.toString())));
      str.clear();
    }
  }

//////////////////////////////////////////////////
  final ratio = <List<int>>[];
  final indexes = <int>{};
  for (final (_, char) in chars.indexed) {
    Range xrange = (min: char.x - 1, max: char.x + 1);
    Range yrange = (min: char.y - 1, max: char.y + 1);
    final isStar = lines[char.y][char.x] == "*";
    final ratioGroup = <int>[];
    for (final (index, val) in values.indexed) {
      if (xrange.near(val.start.x, val.end.x - 1) &&
          yrange.near(val.start.y, val.end.y)) {
        indexes.add(index);

        if (isStar) {
          ratioGroup.add(val.number);
        }
      }
    }
    if (ratioGroup.length == 2) ratio.add(ratioGroup);
  }

  final res =
      ratio.fold<int>(0, (p, e) => p + (e.fold<int>(1, (p, e) => p * e)));
  stdout.write(res);

  // final v = indexes.map((e) => values[e]).fold(0, (p, e) => p + e.number);
  // stdout.write(v);
}

typedef Range = ({int min, int max});

extension RangeExt on Range {
  bool near(int start, int end) => this.min <= end && this.max >= start;
}

class Value {
  Point<int> start;
  Point<int> end;
  int number;
  Value(
    this.start,
    this.end,
    this.number,
  );

  @override
  String toString() {
    return '($start,$end): $number';
  }
}
