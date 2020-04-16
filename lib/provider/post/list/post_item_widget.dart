import 'package:flutter/material.dart';
import 'package:flutter_sample/provider/post/data/post_bean.dart';

class PostItemWidget extends StatelessWidget {
  final PostBean post;

  final void Function(BuildContext context, PostBean post) click;

  const PostItemWidget({Key key, this.post, this.click}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => click?.call(context, post),
        child: Container(
          height: 80,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  "${post?.content}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                width: 50,
                child: Icon(
                  Icons.favorite,
                  color: (post?.isLike ?? false) ? Colors.red : Colors.grey,
                ),
              ),
            ],
          ),
        ));
  }
}
