import 'dart:io';

typedef Pair = ({int time, int distance});

void main(List<String> args) {
  if (args.isEmpty) {
    print('missing argument');
    return;
  }

  final file = File(args.first);

  List<int> time = [];
  List<int> distance = [];
  for (final line in file.readAsLinesSync()) {
    final s = line.split(':');
    switch (s.first) {
      case 'Time':
        time = s[1]
            .split(' ')
            .where((e) => e.isNotEmpty)
            .toList()
            .map((e) => int.parse(e))
            .toList();
      case 'Distance':
        distance = s[1]
            .split(' ')
            .where((e) => e.isNotEmpty)
            .toList()
            .map((e) => int.parse(e))
            .toList();
    }
  }
  final List<Pair> pairs = [];
  for (var i = 0; i < time.length; i++) {
    pairs.add((time: time[i], distance: distance[i]));
  }

  List<int> results = [];
  for (final pair in pairs) {
    print('$pair: ${pair.qualifyingNumbers()}');
    results.add(pair.qualifyingNumbers());
  }
  final result = results.reduce((value, element) => value * element);

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
