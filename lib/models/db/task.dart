import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 8)
class Task {
  @HiveField(0)
  String taskId;
  @HiveField(1)
  String taskName;
  @HiveField(2)
  String path;
  @HiveField(3)
  List<String> files;
  @HiveField(4)
  List<String> urls;
  @HiveField(5)
  int index;
  @HiveField(6)
  int total;
  @HiveField(7)
  int status;
  @HiveField(8)
  int createdAt;
  @HiveField(9)
  int seqNo;
  @HiveField(10)
  List<String> types;

  Task({
    required this.taskId,
    required this.taskName,
    required this.path,
    required this.files,
    required this.urls,
    required this.index,
    required this.total,
    required this.status,
    required this.createdAt,
    required this.seqNo,
    required this.types,
  });

  factory Task.empty() => Task(
        taskId: '',
        taskName: '',
        path: '',
        files: [],
        urls: [],
        index: 0,
        total: 0,
        status: 0,
        createdAt: 0,
        seqNo: 0,
        types: [],
      );
}
