/// id : 1
/// content : "sdsdsd"
/// isLike : false

class PostBean {
  int id = 0;
  String content = "";
  bool isLike = false;

  PostBean.value(this.id, this.isLike, this.content);

  PostBean(this.id, this.content, this.isLike);

  PostBean.map(dynamic obj) {
    id = obj["id"];
    content = obj["content"];
    isLike = obj["isLike"];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["content"] = content;
    map["isLike"] = isLike;
    return map;
  }
}
