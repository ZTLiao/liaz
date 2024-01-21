import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:liaz/app/constants/app_settings.dart';
import 'package:liaz/app/enums/download_status_enum.dart';
import 'package:liaz/app/logger/log.dart';
import 'package:liaz/app/utils/str_util.dart';
import 'package:liaz/models/db/task.dart';
import 'package:liaz/models/dto/download_task.dart';
import 'package:liaz/services/task_service.dart';

import 'package:path/path.dart' as path;

abstract class DownloadService extends GetxService {
  /// 连接信息监听
  StreamSubscription<ConnectivityResult>? connectivitySubscription;

  /// 当前连接类型
  ConnectivityResult? connectivityType;

  String savePath = StrUtil.empty;

  /// 当前正在下载的数量
  var currentNum = 0;

  Future<void> init() async {
    savePath = await getSavePath();
    //监听网络状态
    initConnectivity();
    //更新ID
    updateDownloadIds();
    updateDownloaded();
  }

  /// 初始化连接状态
  void initConnectivity() async {
    try {
      var connectivity = Connectivity();
      connectivitySubscription = connectivity.onConnectivityChanged
          .listen((ConnectivityResult result) {
        networkChanged(result);
      });
      connectivityType = await connectivity.checkConnectivity();
      initTask();
    } catch (e) {
      Log.logPrint(e);
      initTask();
    }
  }

  /// 网络变更
  void networkChanged(ConnectivityResult type) {
    if (connectivityType != type && type == ConnectivityResult.mobile) {
      //切换至流量
      switchCellular();
    } else if (connectivityType != type && type == ConnectivityResult.none) {
      //网络断开
      switchNoNetwork();
    } else {
      switchToWiFi();
    }
    connectivityType = type;
  }

  /// 切换至流量
  void switchCellular() {
    if (AppSettings.downloadAllowCellular.value) {
      //允许使用流量,当成WiFi处理
      switchToWiFi();
      return;
    }
    //把任务状态改为pauseCellular
    for (var item in TaskService.instance.taskQueues) {
      if (item.status == DownloadStatusEnum.wait.index ||
          item.status == DownloadStatusEnum.loading.index ||
          item.status == DownloadStatusEnum.downloading.index ||
          item.status == DownloadStatusEnum.waitNetwork.index) {
        item.stop();
        item.updateStatus(DownloadStatusEnum.pauseCellular, updateTask: false);
      }
    }
    updateQueue();
  }

  /// 无网络
  void switchNoNetwork() {
    //把任务状态改为pauseCellular
    for (var item in TaskService.instance.taskQueues) {
      if (item.status == DownloadStatusEnum.wait.index ||
          item.status == DownloadStatusEnum.loading.index ||
          item.status == DownloadStatusEnum.downloading.index ||
          item.status == DownloadStatusEnum.pauseCellular.index) {
        item.stop();
        item.updateStatus(DownloadStatusEnum.waitNetwork, updateTask: false);
      }
    }
    updateQueue();
  }

  void switchToWiFi() {
    for (var item in TaskService.instance.taskQueues) {
      if (item.status == DownloadStatusEnum.pauseCellular.index ||
          item.status == DownloadStatusEnum.waitNetwork.index) {
        item.updateStatus(DownloadStatusEnum.wait, updateTask: false);
      }
    }
    updateQueue();
  }

  /// 更新队列
  void updateQueue() {
    //如果下载中任务数小于设定值，添加一个任务
    //如果任务取消或完成，移除队列
    for (var task in List<DownloadTask>.from(TaskService.instance.taskQueues)) {
      //下载完成或取消，移除队列
      if (task.status == DownloadStatusEnum.complete.index ||
          task.status == DownloadStatusEnum.cancel.index) {
        TaskService.instance.taskQueues.remove(task);
        updateDownloaded();
        continue;
      }
    }
    var taskNum = AppSettings.downloadTaskCount.value;
    var count = TaskService.instance.taskQueues
        .where((x) =>
            x.status == DownloadStatusEnum.downloading.index ||
            x.status == DownloadStatusEnum.loading.index)
        .length;
    currentNum = count;
    if (taskNum == 0) {
      var ls = TaskService.instance.taskQueues
          .where((x) => x.status == DownloadStatusEnum.wait.index);
      for (var item in ls) {
        item.start();
      }
    } else {
      if (count < taskNum) {
        var ls = TaskService.instance.taskQueues
            .where((x) => x.status == DownloadStatusEnum.wait.index)
            .take(taskNum - count);
        for (var item in ls) {
          item.start();
        }
      }
    }
    updateDownloadIds();
  }

  void initTask() async {
    var tasks = TaskService.instance.getDownloadingTask(savePath);
    for (var item in tasks) {
      if (item.status == DownloadStatusEnum.cancel.index) {
        TaskService.instance.delete(item.taskId);
        continue;
      }
      //无网络
      if (connectivityType == ConnectivityResult.none) {
        if (item.status != DownloadStatusEnum.pause.index) {
          item.status = DownloadStatusEnum.waitNetwork.index;
        }
      } else if (connectivityType == ConnectivityResult.mobile) {
        //不允许使用数据下载
        if (!AppSettings.downloadAllowCellular.value) {
          if (item.status != DownloadStatusEnum.pause.index) {
            item.status = DownloadStatusEnum.pauseCellular.index;
          }
        }
      } else {
        //只要不是手动暂停的，全部改为等待，添加到下载队列
        if (item.status != DownloadStatusEnum.pause.index) {
          item.status = DownloadStatusEnum.wait.index;
        }
      }
      TaskService.instance.taskQueues.add(
        DownloadTask(
          item,
          onUpdate: updateQueue,
          getCached: getCached,
        ),
      );
    }
    updateQueue();
  }

  Future<String> getSavePath();

  Future<File?> getCached(String url);

  void updateDownloadIds() {
    TaskService.instance.downloadIds.clear();
    TaskService.instance.downloadIds.addAll(TaskService.instance.getTaskIds());
  }

  void updateDownloaded();

  /// 继续
  void resumeAll() {
    //更新状态至等待
    for (var task in TaskService.instance.taskQueues) {
      if (task.status == DownloadStatusEnum.pause.index) {
        task.stop();
        task.updateStatus(
          DownloadStatusEnum.wait,
          updateTask: false,
        );
      }
    }
    updateQueue();
  }

  /// 暂停
  void pauseAll() {
    for (var task in TaskService.instance.taskQueues) {
      if (task.status != DownloadStatusEnum.pause.index &&
          task.status != DownloadStatusEnum.error.index &&
          task.status != DownloadStatusEnum.errorLoad.index) {
        task.stop();
        task.updateStatus(DownloadStatusEnum.pause, updateTask: false);
      }
    }
    updateQueue();
  }

  /// 取消任务
  void cancelTask(DownloadTask task) {
    // 移除列表
    // 移除数据库
    // 取消任务
    // 删除文件
  }

  ///删除
  void delete(Task task) async {
    var taskId = task.taskId;
    try {
      var directory = Directory(path.join(savePath, task.taskId));
      await directory.delete(recursive: true);
    } catch (e) {
      Log.logPrint(e);
    } finally {
      await TaskService.instance.delete(taskId);
      updateDownloaded();
    }
    updateDownloadIds();
  }
}
