import 'package:hive/hive.dart';

part 'search.g.dart';

@HiveField(5)
class Search {
  @HiveField(0)
  String key;

  Search({
    required this.key,
  });
}
