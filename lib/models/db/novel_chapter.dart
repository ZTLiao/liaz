import 'package:hive/hive.dart';

part 'novel_chapter.g.dart';

@HiveType(typeId: 10)
class NovelChapter {
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

  NovelChapter({
    required this.chapterId,
    required this.chapterName,
    required this.seqNo,
    required this.taskId,
    required this.currentIndex,
  });
}
