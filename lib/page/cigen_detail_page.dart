import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cigen/dao/notebook_dao.dart';
import 'package:flutter_cigen/dao/word_dao.dart';
import 'package:flutter_cigen/util/counter.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:audioplayer/audioplayer.dart';
import 'package:intl/intl.dart';
//import 'package:provide/provide.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_media_player/flutter_media_player.dart';
import 'package:provider/provider.dart';

class CigenDetailPage extends StatefulWidget {
  var word;
  var showToolBar = true;

  CigenDetailPage(this.word, [this.showToolBar = true]);

  @override
  _CigenDetailPageState createState() => _CigenDetailPageState();
}

class _CigenDetailPageState extends State<CigenDetailPage> {
  bool favorite = false;
  //AudioPlayer audioPlayer = new AudioPlayer();
  final Connectivity _connectivity = Connectivity();


  @override
  void initState() {
    super.initState();
    getWordInfo();
    initConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          title: Text(widget.word['word']),
        ),
        preferredSize: Size.fromHeight(44.0),
      ),
      body: Container(
//        color: Colors.black12,
//        decoration: BoxDecoration(color: Colors.black12),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: detailContentWidget(),
              ),
              toolbarWidget()
            ],
          ),
        ),
      ),
    );
  }

  //从数据库查询是否在收藏夹中
  void getWordInfo() async {
    var notebook = await NotebookDao.getNotebook(widget.word['word']);
    if (notebook == null){
      favorite = false;
    }else{
      favorite = true;
    }
    setState(() {

    });
  }


  Widget detailContentWidget() {
    return Stack(
      children: <Widget>[
        detailWidget(),
        Positioned(
          top: 10,
          right: 0,
          child: FlatButton(
            onPressed: () {
              playVoiceAction();
            },
            child: Icon(
              CupertinoIcons.volume_up,
              size: 36,
//              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  Widget detailWidget() {
    return Container(
//      decoration: BoxDecoration(color: Colors.white),
      child: ListView(
        padding: EdgeInsets.all(12),
        children: <Widget>[
          Text(
            widget.word['word'],
            style: TextStyle(fontSize: 22.0),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '词根词缀',
            style: TextStyle(color: Colors.blue, fontSize: 16.0),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
            child: Text(widget.word['notes']),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '词典释义',
            style: TextStyle(color: Colors.blue, fontSize: 16.0),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
            child: Text(widget.word['detail']),
          ),
          SizedBox(
            height: 10,
          ),
          sentenceWidget(),
        ],
      ),
    );
  }

  Widget sentenceWidget() {
    String sentence = widget.word['sentence'];
    if (sentence == null) {
      sentence = '';
    }
    sentence = sentence.replaceAll('<em>', '');
    sentence = sentence.replaceAll('</em>', '');
    //print(sentence);
    if (sentence != '') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '单词例句',
            style: TextStyle(color: Colors.blue, fontSize: 16.0),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
            //child: Text(widget.word['sentence']),
            child: Html(
//            padding: EdgeInsets.all(12.0),
              data: sentence,
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  Widget toolbarWidget() {
    if(widget.showToolBar == false){
      return Container();
    }

    var favoriteIcon = Icon(Icons.favorite_border);
    if (favorite) {
      favoriteIcon = Icon(
        Icons.favorite,
        color: Colors.red,
      );
    }
    return Container(
      padding: EdgeInsets.all(0),
//      decoration: BoxDecoration(color: Colors.black12),
//      color: Colors.black12,
      child: Column(
        children: <Widget>[
          Divider(height: 0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton(
                child: Icon(Icons.arrow_back),
                onPressed: () {
                  preAction();
                },
              ),
              FlatButton(
                child: favoriteIcon,
                onPressed: () {
                  favoriteAction();
                },
              ),
              FlatButton(
                child: Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  nextAction();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void preAction() async {
    var rowid = widget.word['rowid'];
    var cid = widget.word['cid'];

    var word = await WordDao.preWord(rowid, cid);

    if (word == null) {
      //print('已经到本类别第一个单词');
      Fluttertoast.showToast(
        msg: "已经到本类别第一个单词",
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
      );
    } else {
      widget.word = word;
      getWordInfo();
      setState(() {});
    }
  }

  void nextAction() async {
    var rowid = widget.word['rowid'];
    var cid = widget.word['cid'];

    var word = await WordDao.nextWord(rowid, cid);

    if (word == null) {
      //print('已经到本类别最后一个单词');
      Fluttertoast.showToast(
        msg: "已经到本类别最后一个单词",
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
      );
    } else {
      widget.word = word;
      getWordInfo();
      setState(() {});
    }
  }

  void playVoiceAction() async{
    String url = 'http://dict.youdao.com/dictvoice?audio='+widget.word['word']+'&type=2';
    //await audioPlayer.play(url);
    await FlutterMediaPlayer.play(url);
    var volume = await FlutterMediaPlayer.getVolume();
    //print(volume);
    if(volume <= 0.1) {
      Fluttertoast.showToast(
        msg: "音量过小，建议调节音量",
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
      );
    }
  }

  //加入收藏、取消收藏
  void favoriteAction() async{

    var notebook = await NotebookDao.getNotebook(widget.word['word']);
    if (notebook == null){
      //加入收藏
      favorite = true;
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(now);
      await NotebookDao.saveNotebook(widget.word['word'], widget.word['detail'], formattedDate);

      Fluttertoast.showToast(
        msg: "成功将单词加入生词本",
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
      );
    }else{
      //移出收藏
      favorite = false;
      await NotebookDao.deleteNotebook(widget.word['word']);


      Fluttertoast.showToast(
        msg: "将单词从生词本中移出",
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
      );
    }

    //状态更新（收藏）
    Provider.of<Counter>(context, listen: false).favorite();

    setState(() {});

  }

  Future<Null> initConnectivity() async {
    ConnectivityResult result;
    bool success = true;
    //平台消息可能会失败，因此我们使用Try/Catch PlatformException。
    try {
      result = await _connectivity.checkConnectivity();
    } on Exception catch (e) {
      success = false;
      print(e.toString());
    }

    print(result);

    if(result== ConnectivityResult.none){
      success = false;
    }

    if(success == false){
      Fluttertoast.showToast(
        msg: "网络连接失败，单词发音不可用，请打开网络",
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
      );

    }

    //print(connectionStatus);

    // 如果在异步平台消息运行时从树中删除了该小部件，
    // 那么我们希望放弃回复，而不是调用setstate来更新我们不存在的外观。
    //if (!mounted) {
    //  return;
    //}

  }


}
