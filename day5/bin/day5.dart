import 'dart:io';
import 'dart:math';

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    exit(1);
  }

  late List<int> seeds;

  final Map<String, Set<Distribution>> items = {};

  final file = File(arguments.first);
  for (final line in file.readAsLinesSync()) {
    if (line.isEmpty) continue;
  }
  for (final line in file.readAsLinesSync()) {
    if (line.isEmpty) continue;

    if (line.contains('seeds:')) {
      seeds = line
          .split(':')[1]
          .split(' ')
          .where((element) => element.isNotEmpty)
          .map((e) => int.parse(e))
          .toList();
      continue;
    }

    if (line.contains(':')) {
      final name = line.split(':').first;
      items.addAll({name: {}});
      continue;
    }

    final nums = line.split(' ').map((e) => int.parse(e)).toList();
    Distribution d = (dest: nums[0], src: nums[1], diff: nums[2]);
    items[items.last.key]?.add(d);
  }
  var min = pow(2, 62);
  for (var (_, s) in seeds.indexed) {
    var seed = s;
    for (var (_, (String _, Set<Distribution> value)) in items //
        .entries
        .map((e) => (e.key, e.value))
        .toList()
        .indexed) {
      for (var (_, Distribution d) in value.indexed) {
        var canTransform = seed >= d.src && seed <= (d.src + d.diff - 1);
        if (canTransform) {
          final diff = seed - d.src;
          seed = d.dest + diff;
          break;
        }
      }
    }
    if (seed < min) min = seed;
  }

  stdout.write('$min');
}

typedef Distribution = ({int dest, int src, int diff});

extension DistributionExt on Distribution {
  int destination(int i) {
    return 0;
  }
}

extension MapExt<K, V> on Map<K, V> {
  MapEntry<K, V> get last => entries.last;
  void addLast(V value) {
    addAll({});
  }
}
