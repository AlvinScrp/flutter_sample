import 'package:flutter_sample/provider/post/data/post_bean.dart';
import 'package:collection/collection.dart';

class PostServer {
  var posts = List<PostBean>.empty();
  static late PostServer _instance;

  static PostServer instance() {
    if (_instance == null) {
      _instance = PostServer._();
    }
    return _instance;
  }

  PostServer._() {
    posts = List<PostBean>.empty();
    posts.add(PostBean.value(
      0,
      true,
      """
      水调歌头·明月几时有
明月几时有？把酒问青天。不知天上宫阙，今夕是何年。我欲乘风归去，又恐琼楼玉宇，高处不胜寒。起舞弄清影，何似在人间。(何似 一作：何时；又恐 一作：惟 / 唯恐)
转朱阁，低绮户，照无眠。不应有恨，何事长向别时圆？人有悲欢离合，月有阴晴圆缺，此事古难全。但愿人长久，千里共婵娟。(长向 一作：偏向) """,
    ));
    posts.add(PostBean.value(
      1,
      true,
      """
      声声慢·寻寻觅觅
寻寻觅觅，冷冷清清，凄凄惨惨戚戚。乍暖还寒时候，最难将息。三杯两盏淡酒，怎敌他、晚来风急！雁过也，正伤心，却是旧时相识。
满地黄花堆积，憔悴损，如今有谁堪摘？守着窗儿，独自怎生得黑！梧桐更兼细雨，到黄昏、点点滴滴。这次第，怎一个愁字了得！（守着窗儿 一作：守著窗儿）
      """,
    ));
    posts.add(PostBean.value(
      2,
      true,
      """
      凤凰台上忆吹箫·香冷金猊
香冷金猊，被翻红浪，起来慵自梳头。任宝奁尘满，日上帘钩。生怕离怀别苦，多少事、欲说还休。新来瘦，非干病酒，不是悲秋。
休休，这回去也，千万遍《阳关》，也则难留。念武陵人远，烟锁秦楼。惟有楼前流水，应念我、终日凝眸。凝眸处，从今又添，一段新愁。(版本一)

香冷金猊，被翻红浪，起来人未梳头。任宝奁闲掩，日上帘钩。生怕闲愁暗恨，多少事、欲说还休。今年瘦，非干病酒，不是悲秋。
明朝，者回去也，千万遍阳关，也即难留。念武陵春晚，云锁重楼。记取楼前绿水，应念我、终日凝眸。凝眸处，从今更数，几段新愁。(版本二)
      """,
    ));
    posts.add(PostBean.value(
      3,
      true,
      """
      绮寮怨·上马人扶残醉
上马人扶残醉，晓风吹未醒。映水曲、翠瓦朱檐，垂杨里、乍见津亭。当时曾题败壁，蛛丝罩、淡墨苔晕青。念去来、岁月如流，徘徊久、叹息愁思盈。
去去倦寻路程。江陵旧事，何曾再问杨琼。旧曲凄清。敛愁黛、与谁听。尊前故人如在，想念我、最关情。何须渭城。歌声未尽处，先泪零。 """,
    ));
    posts.add(PostBean.value(
      4,
      true,
      """
      满江红·小院深深
小院深深，悄镇日、阴晴无据。春未足，闺愁难寄，琴心谁与？曲径穿花寻蛱蝶，虚阑傍日教鹦鹉。笑十三杨柳女儿腰，东风舞。
云外月，风前絮。情与恨，长如许。想绮窗今夜，为谁凝伫？洛浦梦回留佩客，秦楼声断吹箫侣。正黄昏时候杏花寒，廉纤雨。""",
    ));
    posts.add(PostBean.value(
      5,
      true,
      """
      花心动·春词
仙苑春浓，小桃开，枝枝已堪攀折。乍雨乍晴，轻暖轻寒，渐近赏花时节。柳摇台榭东风软，帘栊静，幽禽调舌。断魂远，闲寻翠径，顿成愁结。
此恨无人共说。还立尽黄昏，寸心空切。强整绣衾，独掩朱扉，枕簟为谁铺设。夜长更漏传声远，纱窗映、银缸明灭。梦回处，梅梢半笼残月。
      """,
    ));
    posts.add(PostBean.value(
      6,
      true,
      """
        安公子·远岸收残雨
远岸收残雨。雨残稍觉江天暮。拾翠汀洲人寂静，立双双鸥鹭。望几点、渔灯隐映蒹葭浦。停画桡、两两舟人语。道去程今夜，遥指前村烟树。
游宦成羁旅。短樯吟倚闲凝伫。万水千山迷远近，想乡关何处。自别后、风亭月榭孤欢聚。刚断肠、惹得离情苦。听杜宇声声，劝人不如归去。
""",
    ));
  }

  Future<List<Map<String, dynamic>>> loadPosts() async {
    await Future.delayed(Duration(milliseconds: 300));
    return posts.map(((post) => post.toMap())).toList();
  }

  Future<Map<String, dynamic>> getPostDetail(int id) async {
    await Future.delayed(Duration(milliseconds: 300));
    return posts
            .firstWhereOrNull(
              (post) => post.id == id,
            )
            ?.toMap() ??
        Map();
  }

  Future<Map<String, dynamic>> like(int id, bool toLike) async {
    await Future.delayed(Duration(milliseconds: 300));
    PostBean? post = posts.firstWhereOrNull((post) => post.id == id);
    if (post != null) {
      post.isLike = toLike;
      return {"success": true};
    }
    return {"success": false};
  }
}
