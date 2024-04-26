import 'dart:io';

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    print('Argument required');
    return;
  }
  final f = File(arguments[0]);
  if (!f.existsSync()) {
    print('$f doesn\'t exist');
    return;
  }

  List<int> values = [];
  for (final (_, line) in f.readAsStringSync().split('\n').indexed) {
    final n1 = line.indexOf(RegExp(r'[0-9]'));
    if (n1 < 0) break;
    final n2 = line.lastIndexOf(RegExp(r'[0-9]'));
    final number = int.parse(line[n1] + line[n2]);
    values.add(number);
  }

  stdout.write(values.fold<int>(
    0,
    (previousValue, element) => previousValue + element,
  ));

  return;
}
