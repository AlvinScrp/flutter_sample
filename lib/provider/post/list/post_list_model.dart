import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sample/provider/post/base/eventbus_x.dart';
import 'package:flutter_sample/provider/post/data/post_bean.dart';
import 'package:flutter_sample/provider/post/data/post_server.dart';
import 'package:flutter_sample/provider/post/list/post_item_notifier.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PostListModel with ChangeNotifier {
  var posts = new List<PostBean>();

  RefreshController refreshController = RefreshController();

  VoidCallback _eventDispose;

  PostListItemListenable itemListenable;

  PostListModel() {
    itemListenable = new PostListItemListenable();

    StreamSubscription subscription =
        eventBus.on<PostLikeEvent>().listen((event) {
      posts
          .firstWhere((post) => post.id == event.id, orElse: () => null)
          ?.isLike = event.isLike;
    });
    _eventDispose = () => subscription.cancel();
  }

  void loadData({VoidCallback callback}) {
    PostServer.instance().loadPosts().then((jsonList) {
      posts = jsonList.map((json) => PostBean.map(json)).toList();
      notifyListeners();
      callback.call();
    }).catchError((e) => print(e));
  }

  void refresh() {
    loadData(callback: () => refreshController.refreshCompleted());
  }

  @override
  void dispose() {
    super.dispose();
    _eventDispose?.call();
  }
}
