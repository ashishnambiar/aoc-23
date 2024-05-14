import 'dart:io';

typedef Pair = ({int time, int distance});

void main(List<String> args) {
  if (args.isEmpty) {
    print('missing argument');
    return;
  }

  final file = File(args.first);

  int time = 0;
  int distance = 0;
  for (final line in file.readAsLinesSync()) {
    final s = line.split(':');
    switch (s.first) {
      case 'Time':
        time = int.parse(s[1].replaceAll(' ', ''));
      case 'Distance':
        distance = int.parse(s[1].replaceAll(' ', ''));
    }
  }
  Pair pair = (time: time, distance: distance);

  final result = pair.qualifyingNumbers();

  stdout.write('$result');
}

extension PairExt on Pair {
  int qualifyingNumbers() {
    for (var i = 1; i < time; i++) {
      final val = i * (time - i);
      if (val > distance) {
        return time - (i * 2) + 1;
      }
    }
    return 0;
  }
}
