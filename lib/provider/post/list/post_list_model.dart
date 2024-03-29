import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sample/provider/post/base/eventbus_x.dart';
import 'package:flutter_sample/provider/post/data/post_bean.dart';
import 'package:flutter_sample/provider/post/data/post_server.dart';
import 'package:flutter_sample/provider/post/list/post_item_notifier.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:collection/collection.dart';

class PostListModel with ChangeNotifier {
  var posts = List<PostBean>.empty(growable: true);

  ///smartRefresher的刷新控制器
  RefreshController refreshController = RefreshController();

  ///解除事件监听方法
  late VoidCallback _eventDispose;

  /// 单个刷新的ChangeNotifier
  late PostNotifier itemChange;

  PostListModel() {
    itemChange = new PostNotifier();
    subscribePostLike();
  }

  ///订阅PostLikeEvent
  void subscribePostLike() {
    StreamSubscription subscription =
        eventBus.on<PostLikeEvent>().listen((event) {
      ///拿到event，更新下当前页面对应post的isLike状态
      var post = posts.firstWhereOrNull((post) => post.id == event.id);
      post?.isLike = event.isLike;
      itemChange.id = event.id;
      itemChange.notifyListeners();
    });
    _eventDispose = () => subscription.cancel();
  }

  ///加载数据
  void loadData({VoidCallback? callback}) {
    PostServer.instance().loadPosts().then((jsonList) {
      posts = jsonList.map((json) => PostBean.map(json)).toList();
      notifyListeners();
      callback?.call();
    }).catchError((e) => print(e));
  }

  ///下拉刷新，数据获取到后，通知smartRefresher
  void refresh() {
    loadData(callback: () => refreshController.refreshCompleted());
  }

  ///ChangeNotifier的 解除监听方法。
  @override
  void dispose() {
    super.dispose();
    _eventDispose.call();
  }
}
