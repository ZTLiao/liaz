import 'package:hive/hive.dart';

part 'comic_chapter.g.dart';

@HiveType(typeId: 9)
class ComicChapter {
  @HiveField(0)
  int chapterId;
  @HiveField(1)
  String chapterName;
  @HiveField(2)
  int seqNo;
  @HiveField(3)
  String taskId;
  @HiveField(4)
  int currentIndex;
  @HiveField(5)
  int comicId;

  ComicChapter({
    required this.chapterId,
    required this.chapterName,
    required this.seqNo,
    required this.taskId,
    required this.currentIndex,
    required this.comicId,
  });
}
