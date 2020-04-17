import 'package:flutter/material.dart';
import 'package:flutter_sample/provider/post/base/eventbus_x.dart';
import 'package:flutter_sample/provider/post/data/post_bean.dart';
import 'package:flutter_sample/provider/post/data/post_server.dart';

class PostDetailModel with ChangeNotifier {
  PostBean post;

  initPost(int id) {
    PostServer.instance().getPostDetail(id).then((json) {
      post = PostBean.map(json);
      notifyListeners();
    }).catchError((e) => print(e));
  }

  likePost(bool toLike) {
    PostServer.instance().like(post.id, toLike).then((result) {
      if (result["success"]) {
        post.isLike = toLike;
        PostLikeEvent(post.id, toLike).fire();
      }
      notifyListeners();
    }).catchError((e) => print(e));
  }
}
