import 'package:flutter/material.dart';
import 'package:flutter_sample/provider/post/data/post_bean.dart';
import 'package:flutter_sample/provider/post/list/post_item_notifier.dart';
import 'package:provider/provider.dart';

class PostItemWidget2 extends StatelessWidget {
  final PostBean? post;

  final void Function(BuildContext context, PostBean? post)? click;

  const PostItemWidget2({Key? key, this.post, this.click}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("PostItemWidget2:build");
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
                child: Selector<PostNotifier, bool>(
                    selector: (context, itemChange) => post?.isLike ?? false,
                    shouldRebuild: (pre, next) => pre != next,
                    builder: (context, isLike, child) {
                      return Icon(
                        Icons.favorite,
                        color: (isLike) ? Colors.red : Colors.grey,
                      );
                    }),
              ),
            ],
          ),
        ));
  }
}
