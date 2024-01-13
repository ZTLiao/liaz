import 'package:hive/hive.dart';

part 'comic.g.dart';

@HiveType(typeId: 6)
class Comic {
  @HiveField(0)
  int comicId;
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

  Comic({
    required this.comicId,
    required this.title,
    required this.cover,
    required this.categories,
    required this.authors,
    required this.flag,
    required this.browseChapterId,
  });
}
