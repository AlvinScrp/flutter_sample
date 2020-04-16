/// id : 1
/// content : "sdsdsd"
/// isLike : false

class PostBean {
  int id;
  String content;
  bool isLike;

  PostBean.value(this.id, this.isLike, this.content);

  PostBean(this.id, this.content, this.isLike);

  PostBean.map(dynamic obj) {
    this.id = obj["id"];
    this.content = obj["content"];
    this.isLike = obj["isLike"];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["content"] = content;
    map["isLike"] = isLike;
    return map;
  }
}
