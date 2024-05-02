import 'dart:io';

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

    values.add(
        left.intersection(right).fold<int>(0, (p, e) => p + (p == 0 ? 1 : p)));
  }

  final res =
      values.fold<int>(0, (previousValue, element) => previousValue + element);
  stdout.write(res);
}
