import 'package:hive/hive.dart';

part 'novel.g.dart';

@HiveType(typeId: 7)
class Novel {
  @HiveField(0)
  int novelId;
  @HiveField(1)
  String title;
  @HiveField(2)
  String cover;
  @HiveField(3)
  String categories;
  @HiveField(4)
  String authors;
  @HiveField(5)
  int flag;
  @HiveField(6)
  int browseChapterId;

  Novel({
    required this.novelId,
    required this.title,
    required this.cover,
    required this.categories,
    required this.authors,
    required this.flag,
    required this.browseChapterId,
  });
}
