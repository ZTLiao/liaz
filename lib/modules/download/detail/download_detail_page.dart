import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/constants/app_style.dart';
import 'package:liaz/modules/download/detail/download_detail_controller.dart';

class DownloadDetailPage extends GetView<DownloadDetailController> {
  const DownloadDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Center(
          child: Text(
            controller.title,
          ),
        ),
      ),
      body: Padding(
        padding: AppStyle.edgeInsetsA12,
        child: Obx(
          () => ListView.separated(
            itemCount: controller.tasks.length + 1,
            separatorBuilder: (context, i) {
              return LinearProgressIndicator(
                minHeight: 1,
                value: controller.tasks[i].total > 0
                    ? (controller.tasks[i].total == 0
                            ? 0
                            : (controller.tasks[i].index + 1)) /
                        controller.tasks[i].total
                    : 0,
              );
            },
            itemBuilder: (context, i) {
              if (controller.tasks.length <= i) {
                return const SizedBox();
              }
              var task = controller.tasks[i];
              return Slidable(
                key: ValueKey(task.taskId),
                endActionPane: ActionPane(
                  extentRatio: 0.25,
                  motion: const ScrollMotion(),
                  dismissible: DismissiblePane(onDismissed: () {
                    controller.dismiss(task.taskId);
                  }),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        controller.dismiss(task.taskId);
                      },
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: AppString.delete,
                    ),
                  ],
                ),
                child: ListTile(
                  title: Text(
                    task.taskName,
                  ),
                ),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: 48,
          child: Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 14),
                  ),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.pause_outlined,
                    size: 20,
                  ),
                  label: const Text(
                    AppString.pause,
                  ),
                ),
              ),
              Expanded(
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 14),
                  ),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.start_outlined,
                    size: 20,
                  ),
                  label: const Text(
                    AppString.start,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
