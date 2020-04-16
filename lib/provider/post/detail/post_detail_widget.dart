import 'package:flutter/material.dart';
import 'package:flutter_sample/provider/post/detail/post_detail_model.dart';
import 'package:provider/provider.dart';

class PostDetailWidget extends StatefulWidget {
  final int id;

  const PostDetailWidget({Key key, this.id}) : super(key: key);

  @override
  _PostDetailWidgetState createState() => _PostDetailWidgetState();
}

class _PostDetailWidgetState extends State<PostDetailWidget> {
  PostDetailModel _detailModel;

  @override
  void initState() {
    super.initState();
    _detailModel = PostDetailModel()..initPost(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _detailModel,
      child: Scaffold(
          appBar: AppBar(
            title: Text("帖子详情"),
            actions: <Widget>[
              Consumer<PostDetailModel>(
                builder: (context, model, child) {
                  var post = model.post;
                  if (post == null) {
                    return Container();
                  }
                  return GestureDetector(
                      onTap: () => model.likePost(!model.post.isLike),
                      child: Icon(
                        Icons.favorite,
                        color: post.isLike ? Colors.red : Colors.white,
                      ));
                },
              ),
              Container(
                width: 30,
              )
            ],
          ),
          body: Container(
            padding: EdgeInsets.all(20),
            child: Consumer<PostDetailModel>(
              builder: (context, model, child) {
                var post = model.post;
                if (post == null) {
                  return Container();
                }
                return SingleChildScrollView(
                  child: Text(
                    "${post.content}",
                    style: TextStyle(fontSize: 18, height: 1.4),
                  ),
                );
              },
            ),
          )),
    );
  }
}
