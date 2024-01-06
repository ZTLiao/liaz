import 'package:hive/hive.dart';

part 'search.g.dart';

@HiveField(5)
class Search {
  String key;

  Search({
    required this.key,
  });
}
