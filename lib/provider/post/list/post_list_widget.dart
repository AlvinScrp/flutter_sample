import 'package:flutter/material.dart';
import 'package:flutter_sample/provider/post/base/item_refresher.dart';
import 'package:flutter_sample/provider/post/base/slide_page_route.dart';
import 'package:flutter_sample/provider/post/data/post_bean.dart';
import 'package:flutter_sample/provider/post/detail/post_detail_widget.dart';
import 'package:flutter_sample/provider/post/list/post_item_notifier.dart';
import 'package:flutter_sample/provider/post/list/post_item_widget.dart';
import 'package:flutter_sample/provider/post/list/post_list_model.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PostListWidget extends StatefulWidget {
  PostListWidget({Key key}) : super(key: key);

  @override
  _PostListWidgetState createState() => _PostListWidgetState();
}

class _PostListWidgetState extends State<PostListWidget>
    with AutomaticKeepAliveClientMixin {
  PostListModel _listModel;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    ///初始化加载数据
    _listModel = PostListModel()..loadData();
    print("PostListWidget:initState");
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print("PostListWidget:build");
    return Scaffold(
      appBar: AppBar(
        title: Text("帖子列表"),
      ),

      ///多Provider使用，提前设置好
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: _listModel),
          ChangeNotifierProvider.value(value: _listModel.itemChange),
        ],
        child: Consumer<PostListModel>(
          builder: (context, model, child) {
            Widget child;
            if (model.posts?.isEmpty ?? true) {
              child = Container();
            } else {
              child = ListView.separated(
                  padding: EdgeInsets.only(left: 20),
                  itemBuilder: (itemContext, index) {
                    return _buildListItem(itemContext, model.posts[index]);
                  },
                  separatorBuilder: (separatorContext, index) {
                    return Divider(
                      height: 1,
                      color: Colors.grey,
                    );
                  },
                  itemCount: model.posts.length);
            }

            ///设置 SmartRefresher： refreshController，onRefresh。
            ///onRefresh回调。widget不处理数据相关的回调，而是交给model处理
            return SmartRefresher(
              controller: model.refreshController,
              enablePullDown: true,
              enablePullUp: true,
              onRefresh: () => model.refresh(),
              child: child,
            );
          },
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, PostBean post) {
    ///ItemRefresher 自定义的列表item刷新
    return ItemRefresher<PostItemChange, PostBean>(
      value: post,
      shouldRebuild: (itemListenable, value) =>
          (itemListenable.id != null && itemListenable.id == value.id),
      builder: (context, value, child) {
        return PostItemWidget(
          post: value,
          click: _skipPostDetail,
        );
      },
    );
  }

  _skipPostDetail(BuildContext context, PostBean post) {
    Navigator.of(context).push(SlidePageRoute(
      widget: PostDetailWidget(id: post.id),
    ));
  }
}
