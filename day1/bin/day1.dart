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
    if (line.isEmpty) break;

    values.add(textEval(line));
  }

  stdout.write(values.fold<int>(
    0,
    (previousValue, element) => previousValue + element,
  ));
}

int textEval(String line) {
  final n1 = line.indexOf(RegExp(r'[0-9]'));
  final n2 = line.lastIndexOf(RegExp(r'[0-9]'));
  ({int index, int value}) s1 = (index: -1, value: -1);
  ({int index, int value}) s2 = (index: -1, value: -1);

  for (final (i, v) in Numbers.values.indexed) {
    if (!line.contains(v.name)) continue;
    final t1 = line.indexOf(v.name);
    final t2 = line.lastIndexOf(v.name);

    if (s1.index == -1 || s1.index > t1) {
      s1 = (index: t1, value: i + 1);
    }
    if (s2.index == -1 || s2.index < t2) {
      s2 = (index: t2, value: i + 1);
    }
  }
  final first = s1.index < 0 || n1 < s1.index ? line[n1] : s1.value.toString();
  final second = s2.index < 0 || n2 > s2.index ? line[n2] : s2.value.toString();
  final number = int.parse(first + second);
  return number;
}

enum Numbers {
  one,
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine,
}
