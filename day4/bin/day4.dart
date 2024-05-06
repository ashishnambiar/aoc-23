import 'dart:io';
import 'dart:math';

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    print('missing args');
    return;
  }
  final f = File(arguments[0]);

  final values = <int>[];
  int r = 0;
  var v = <int>[f.readAsLinesSync().length];
  for (final (i, line) in f.readAsLinesSync().indexed) {
    final input = line.split(':')[1].split('|').map((e) => e.trim()).toList();
    final right = input[1].split(RegExp(r'\s+')).toSet();
    final left = input[0].split(RegExp(r'\s+')).toSet();

    final common = left.intersection(right).length;

    // add the amount
    r += v.length;

    // add the numbers
    v.addAll(List.generate(v.length, (index) => common + i));

    // remove the invalid cards
    v = v.where((e) {
      return e != i;
    }).toList();

    values.add(pow(2, (common - 1)).toInt());
  }

  final res =
      values.fold<int>(0, (previousValue, element) => previousValue + element);

  stdout.write(res);
  stdout.write(' ');
  stdout.write(r);
}
