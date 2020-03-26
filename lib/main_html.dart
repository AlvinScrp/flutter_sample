import 'package:css_text/css_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample/flutter_widget_from_html_core/src/core_html_widget.dart';

import 'flutter_html/base/log.dart';
import 'dart:math' as math;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'html test',
      home: MyHomepage(),
    );
  }
}

class MyHomepage extends StatefulWidget {
  @override
  _MyHomepageState createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    final _transformRegExp = RegExp(r'^(rotate)\(((-?[0-9]+)deg)\)$');
    Iterable<RegExpMatch> matchs =
        _transformRegExp.allMatches("rotate(-90deg)");
    for (final m in matchs) {
      print("m0 ${m[0]}  m1 ${m[1]}  m2 ${m[2]} m3 ${m[3]}");
    }

    final m = matchs.elementAt(0);
    int deg = int.tryParse(m[3]);
    double radians = 2 * math.pi * (deg / 360.0);
    print("deg:$deg , radians:$radians");

    return Scaffold(
      appBar: AppBar(
        title: Text("html test $count"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () => setState(() {
                    count++;
                  }))
        ],
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(15.0),
        child: SingleChildScrollView(
//          child: HtmlWrapperWidget(),
          child: HtmlWidget(htmlData2),
//          child: Html2(
//            data: htmlData,
//            useRichText: false,
//          ),
//          child: HTML.toRichText(
//            context,
//            htmlData,
//          ),
        ),
      ),
    );
  }
}

const htmlData2 = """
<section style="margin-top: 10px; margin-left:15px;background-color: #ffff00">
<section style="display: inline-block;text-align: center;padding: 0.1em 0.1em 0em;color: #ffffff;background: #fcb42b;transform: rotate(3deg);">
          <section style="width: 200px;height: 2px;border: 0.1em solid #be7e03;transform: rotate(30deg);" >
          </section>
          <section style="padding: 10px 20px;box-sizing: border-box;">
           <p><span style="color:#ff00ff">TIPS2</span></p>
          </section>
         </section>
<p style="background-color:#ff0000;margin-left:35px; margin-top: 59px;padding: 1em; border:15px solid #7cfc00; border-radius:15px;box-shadow: 3px 3px 3px 3px #F4AAB9;">
<span style="font-size: 15px;text-align: justify;  color: #595959;">母婴店的人把乳铁蛋白吹得特别神奇，要不要给宝宝吃添了乳铁蛋白的奶粉增强下抵抗力？
</span>
</p>
<p style="transform:rotate(10deg);background-color:#ff0000;margin-left:35px; margin-top: 59px;padding: 1em; border:15px solid #7cfc00; border-radius:15px;box-shadow: 3px 3px 3px 3px #F4AAB9;">
<span style="font-size: 15px;text-align: justify;  color: #595959;">母婴店的人把乳铁蛋白吹得特别神奇，要不要给宝宝吃添了乳铁蛋白的奶粉增强下抵抗力？
</span>
</p>
<p style="margin-top: 10px; margin-bottom: 1px; text-align: justify; line-height: 1.75em; letter-spacing: 1px;">
						<span style="font-size: 15px; color: #ff0000;background-color: #C1FFC1;">所以如果真想给孩
							<span style="background-color: #0000ff;"><strong>添加乳铁蛋白的奶粉</strong></span>
							<span style="background-color: #CD2990;"><strong>是比较合适的选择，而不要选择蛋白粉、</strong></span>
							固体饮料之类的营养品。合适的选合适的选
						</span>
					</p>
</section>""";

const htmlData = """

<section  style="border: 0px none;box-sizing: border-box;" data-color="rgb(252, 180, 43)">
      <section class="_135editor" data-tools="135编辑器" data-id="87704" style="border: 0px none;box-sizing: border-box;" data-color="rgb(252, 180, 43)" data-custom="rgb(252, 180, 43)">
       <section class="layout">
        <section style="margin: 15px 6px; box-shadow: rgb(99, 99, 99) 0px 0px 12.8px 0px; overflow: hidden; box-sizing: border-box; padding: 1em; text-align: justify;">
         <section style="display: inline-block;text-align: center;padding: 0.1em 0.1em 0em;color: #ffffff;background: #fcb42b;transform: rotate(0deg);-webkit-transform: rotate(0deg);-moz-transform: rotate(0deg);-o-transform: rotate(0deg);">
          <section style="width: 90%;height: 1px;border-top-width: 0.3em;border-top-style: solid;border-color: #be7e03;margin-top: -0.2em;margin-left: -1px;transform: rotate(-3deg) !important;transform: rotate(-3deg);-webkit-transform: rotate(-3deg);-moz-transform: rotate(-3deg);-o-transform: rotate(-3deg);" data-bcless="darken" data-bclessp="20%" data-width="90%"></section>
          <section style="padding: 0.5em 0.8em;box-sizing: border-box;">
           <p><span class="135brush" data-brushtype="text">TIPS</span></p>
          </section>
         </section>
         <section style="width: auto;height: auto;margin-top: -1em;margin-right: auto;margin-left: auto;overflow: hidden;border-top-width: 0.1em;border-top-style: dashed;border-top-color: #fcb42b;padding-top: 1em;padding-right: 0.5em;padding-left: 0.5em;font-size: 1em;line-height: 1.4em;box-sizing: border-box;">
          <section style="padding-top: 10px;padding-bottom: 10px;box-sizing: border-box;" class="135brush" data-style="font-size:14px;">
           <p style="text-align: justify;line-height: 1.75em;letter-spacing: 2px;"><strong><span style="font-size: 15px;letter-spacing: 1px;white-space: pre-wrap;">手指食物：</span></strong></p>
           <p style="text-align: justify;margin-top: 15px;margin-bottom: 15px;line-height: 1.75em;"><span style="font-size: 15px;color: #595959;letter-spacing: 1px;">就是能够让宝宝用手抓着吃的食物，选择的余地还是很多的。蒸熟的南瓜块、土豆块，软软的好嚼的自制煎饼，还有磨牙棒，都是不错的手指食物。</span></p>
          </section>
         </section>
        </section>
       </section>
      </section>
     </section>

<p style="text-align: justify; color: #595959;">
	<span style="letter-spacing: 1px; text-align: justify; color: #FFC000;"><strong>Q：</strong></span>

	<span style=" text-align: justify; font-size: 15px; color: #FFC000;" >母婴店的人把乳铁蛋白吹得特别神奇，要不要给宝宝吃添了乳铁蛋白的奶粉增强下抵抗力？
	</span>

</p>

<p></p>
<p>
	<section class="_135editor" data-tools="135编辑器" data-id="92620" style="border: 0px none; box-sizing: border-box;">
		<section style="padding-right: 3px; padding-bottom: 3px; box-sizing: border-box;">
			<section style="padding: 20px 15px; border-width: 1px; border-style: solid; border-color: rgb(255, 231, 90); box-shadow: rgb(255, 231, 90) 3px 	3px 0px 0px; box-sizing: border-box;">
				<section class="135brush" style="margin-top: 110px; color: rgb(255, 231, 90); font-size: 14px;">
					<p style=" text-align: justify; line-height: 1.75em; letter-spacing: 15px; background-color:#ffff00ff; padding: 20px 15px; border-width: 1px; border-style: solid; border-color: rgb(255, 231, 90); box-shadow: rgb(255, 231, 90) 3px 	3px 0px 0px; box-sizing: border-box; ">
						<span style="color: #FFC000; font-size: 16px;"><strong>A：</strong></span>
						<span style="font-size: 15px; color: #595959;">乳铁蛋白本身的确是母乳中一大重要的
							<span style="color: #0C0C0C;"><strong>免疫蛋白</strong>，<strong>参与铁吸收与运输、抑制有害菌</strong>、</span>
							帮助宝宝建立抵抗体系。
						</span>
					</p>
					<p style="margin-top: 1px; margin-bottom: 1px; text-align: justify; line-height: 1.75em; letter-spacing: 1px;">
						<span style="font-size: 15px; color: #595959;">所以如果真想给孩子补点乳铁蛋白，那
							<span style="color: #0C0C0C;"><strong>添加乳铁蛋白的奶粉</strong></span>
							是比较合适的选择，而不要选择蛋白粉、固体饮料之类的营养品。
						</span>
					</p>
					<p style="margin-top: 1px; margin-bottom: 1px; text-align: justify; line-height: 1.75em; letter-spacing: 1px;">
						<span style="font-size: 15px; color: #595959;">不过，别太指望吃这样的奶粉就能让宝宝抵抗力增强，少生病。想要身体棒还是要靠全面的营养和锻炼哦。
						</span>
					</p>
				</section>
			</section>
		</section>
	</section>
</p>
<p><br/></p>
<p style="text-align: justify; line-height: 1.75em; letter-spacing: 1px;">
	<br/>
</p>
<p style="text-align: justify; line-height: 1.75em; letter-spacing: 1px;">
	<br style="white-space: normal;"/>
</p>
<p><br/></p>""";

class HtmlWrapperWidget extends StatefulWidget {
  final String url =
      'https://staticimg.ngmm365.com/sd_EC0A3A6BD3C57E5933C476C48642A550';

//  final String url='https://staticimg.ngmm365.com/sd_B6C2ABAF97B7F496114D28B7CEE759CA';

  String _htmlData = "";

  @override
  _HtmlWrapperWidgetState createState() => _HtmlWrapperWidgetState();
}

class _HtmlWrapperWidgetState extends State<HtmlWrapperWidget> {
  void _loadHtmlData() async {
    var response = await Dio().get(widget.url);
    if (response.statusCode == 200) {
      setState(() {
        widget._htmlData = response.data;
        Log.i(widget._htmlData);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadHtmlData();
  }

  @override
  Widget build(BuildContext context) {
    if (widget._htmlData.isEmpty) {
      return Container();
    }
//    return Html2(data: widget._htmlData,useRichText: false, );
    return HTML.toRichText(
      context,
      widget._htmlData,
    );
//    return HtmlWidget(htmlData);
  }
}
