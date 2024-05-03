import 'dart:io';
import 'dart:math';

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    print('missing args');
    return;
  }
  final f = File(arguments[0]);

  final values = <int>[];
  for (final line in f.readAsLinesSync()) {
    final input = line.split(':')[1].split('|').map((e) => e.trim()).toList();
    final right = input[1].split(RegExp(r'\s+')).toSet();
    final left = input[0].split(RegExp(r'\s+')).toSet();

    values.add(pow(2, (left.intersection(right).length - 1)).toInt());
  }

  final res =
      values.fold<int>(0, (previousValue, element) => previousValue + element);

  stdout.write(res);
}
