import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_string.dart';
import 'package:liaz/app/enums/download_status_enum.dart';
import 'package:liaz/app/http/request.dart';
import 'package:liaz/app/logger/log.dart';
import 'package:liaz/app/utils/dialog_util.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/models/db/task.dart';
import 'package:liaz/services/task_service.dart';

import 'package:path/path.dart' as path;

class DownloadTask {
  late Rx<Task> task;

  final Function() onUpdate;
  final Function(String) getCached;

  DownloadTask(
    Task task, {
    required this.onUpdate,
    required this.getCached,
  }) {
    this.task = Rx<Task>(task);
  }

  int get status => task.value.status;

  CancelToken? cancelToken;

  int retryTime = 0;

  void start() async {
    try {
      updateStatus(DownloadStatusEnum.loading);
      if (task.value.urls.isEmpty) {
        updateStatus(DownloadStatusEnum.errorLoad);
      }
      await _saveTask();
      _startDownload();
    } catch (e) {
      updateStatus(DownloadStatusEnum.errorLoad);
    }
  }

  void pause() {
    stop();
    updateStatus(DownloadStatusEnum.pause);
  }

  void resume() {
    _startDownload();
  }

  void stop() {
    cancelToken?.cancel();
    cancelToken = null;
  }

  void cancel() async {
    var result = await DialogUtil.showAlertDialog(
      AppString.cancelTaskAlert,
      title: AppString.cancelTask,
    );
    if (!result) {
      return;
    }
    cancelToken?.cancel();
    cancelToken = null;
    await _deleteTask();
  }

  void _startDownload() async {
    updateStatus(DownloadStatusEnum.downloading);
    for (int i = task.value.index; i < task.value.total; i++) {
      try {
        if (status != DownloadStatusEnum.downloading.index) {
          break;
        }
        var url = task.value.urls[i];
        retryTime = 0;
        await _download(url, i);
      } catch (e) {
        break;
      }
    }
    if (status == DownloadStatusEnum.downloading.index &&
        (task.value.index == task.value.total - 1)) {
      updateStatus(DownloadStatusEnum.complete);
    }
  }

  Future<void> _download(String url, int index) async {
    try {
      Uint8List bytes;
      var loadlFile = await getCached(url);
      if (loadlFile != null) {
        bytes = await loadlFile.readAsBytes();
      } else {
        cancelToken = CancelToken();
        bytes = await Request.instance.getResource(
          url,
          responseType: ResponseType.bytes,
          cancel: cancelToken,
        );
      }
      var urlArray = url.split(StrUtil.slash);
      if (urlArray.isEmpty) {
        return;
      }
      var fileName = urlArray[urlArray.length - 1].split(StrUtil.question)[0];
      Log.d('url : $url, fileName : $fileName');
      fileName = await _saveFile(fileName, bytes);
      if (fileName.isNotEmpty) {
        task.update((val) {
          val!.index = index;
          val.files.add(fileName);
        });
      }
      await _saveTask();
    } catch (e) {
      Log.logPrint(e);
      if (status == DownloadStatusEnum.waitNetwork.index ||
          status == DownloadStatusEnum.pauseCellular.index) rethrow;
      if (retryTime < 3) {
        retryTime++;
        await Future.delayed(const Duration(seconds: 1));
        return await _download(url, index);
      }
      updateStatus(DownloadStatusEnum.error);
      rethrow;
    }
  }

  void updateStatus(DownloadStatusEnum downloadStatus,
      {bool updateTask = true}) async {
    task.update((val) {
      val!.status = downloadStatus.index;
    });
    if (updateTask) {
      onUpdate();
    }
    await _saveTask();
  }

  Future<String> _saveFile(String fileName, Uint8List bytes) async {
    if (bytes.isEmpty) {
      return StrUtil.empty;
    }
    var file = File(path.join(task.value.path, fileName));
    if (!await file.exists()) {
      file = await file.create(
        recursive: true,
      );
    }
    await file.writeAsBytes(bytes);
    return fileName;
  }

  Future<void> _saveTask() async {
    await TaskService.instance.put(task.value);
  }

  Future<void> _deleteTask() async {
    try {
      await Directory(task.value.path).delete(
        recursive: true,
      );
    } finally {
      await TaskService.instance.delete(task.value.taskId);
      updateStatus(DownloadStatusEnum.cancel);
    }
  }
}
