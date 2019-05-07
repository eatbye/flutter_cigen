import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cigen/dao/word_dao.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CigenDetailPage extends StatefulWidget {
  var word;

  CigenDetailPage(this.word);

  @override
  _CigenDetailPageState createState() => _CigenDetailPageState();
}

class _CigenDetailPageState extends State<CigenDetailPage> {
  bool favorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          title: Text(widget.word['word']),
        ),
        preferredSize: Size.fromHeight(44.0),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: detailContentWidget(),
          ),
          toolbarWidget()
        ],
      ),
    );
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
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  Widget detailWidget() {
    return ListView(
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
    var favoriteIcon = Icon(Icons.favorite_border);
    if (favorite) {
      favoriteIcon = Icon(
        Icons.favorite,
        color: Colors.red,
      );
    }
    return Container(
      padding: EdgeInsets.all(0),
      decoration: BoxDecoration(color: Colors.black12),
      child: Row(
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
              favorite = !favorite;
              setState(() {});
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
      setState(() {});
    }
  }

  void playVoiceAction(){

  }
}
