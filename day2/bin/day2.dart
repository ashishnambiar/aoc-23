import 'dart:io';

void main(List<String> arguments) {
  final f = File('bin/input.txt');
  final values = <int>{};

  for (var (_, e) in f.readAsLinesSync().indexed) {
    final game = e.split(':');
    final gameNum = game.first.split(' ')[1];
    final rounds = game[1].split(';');
    final List<bool> l = [];

    for (var e in rounds) {
      final colors = e.split(',');
      final Map<ColorType, int> colorPair = {};

      for (var c in colors) {
        final p = c.trim().split(' ');
        final color = p[1].colorType ?? ColorType.red;
        colorPair.addAll({color: int.parse(p[0])});
      }

      l.add(!colorPair.entries.any((e) => e.value > e.key.max));
    }

    if (l.fold<bool>(true, (p, e) => p && e)) {
      values.add(int.parse(gameNum));
    }
  }
  stdout.write(values.fold<int>(0, (p, e) => p + e));
}

enum ColorType {
  red(12),
  green(13),
  blue(14);

  final int max;
  const ColorType(this.max);
}

extension ColorTypeExtract on String {
  ColorType? get colorType {
    for (var e in ColorType.values) {
      if (e.name == this) {
        return e;
      }
    }
    return null;
  }
}
