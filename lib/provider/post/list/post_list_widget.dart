import 'package:flutter/material.dart';
import 'package:flutter_sample/provider/post/base/item_refresher.dart';
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

class _PostListWidgetState extends State<PostListWidget> {
  PostListModel _listModel;

  @override
  void initState() {
    super.initState();
    _listModel = PostListModel()..loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("帖子列表"),
      ),
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: _listModel),
          ChangeNotifierProvider.value(value: _listModel.itemListenable),
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
    return ItemRefresher<PostListItemListenable, PostBean>(
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
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => PostDetailWidget(id: post.id),
    ));
  }
}
