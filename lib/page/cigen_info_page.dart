import 'package:flutter/material.dart';
import 'package:flutter_cigen/dao/word_dao.dart';
import 'package:flutter_cigen/widget/title_widget.dart';
import 'package:weui/weui.dart';

class CigenInfoPage extends StatefulWidget {
  var item;

  CigenInfoPage(this.item);

  @override
  _CigenInfoPageState createState() => _CigenInfoPageState();
}

class _CigenInfoPageState extends State<CigenInfoPage> {
  var wordList = [];


  @override
  void initState() {
    super.initState();
    getWordList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            title: Text('词根词缀'),
          ),
          preferredSize: Size.fromHeight(44.0)),

        body: ListView(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          /*
          WeForm(
            children: <Widget>[
//            WeCell(
//                content: Text(widget.item['desc']),
//            )
              Container(
                  padding: EdgeInsets.all(12),
                  child: Text(widget.item['desc']))
            ],
          ),
          */
          Divider(height: 0),
          Container(
              decoration: BoxDecoration(color: Colors.white),
              padding: EdgeInsets.all(12),
              child: Text(widget.item['desc'])),
          Divider(height: 0),
          SizedBox(
            height: 20,
          ),
          Divider(height: 0),
          wordListWidget(),
          Divider(height: 0)
//          Expanded(child: wordListWidget(),)
//          Expanded(child: WeForm(children: <Widget>[
//            wordListWidget()
//          ]))
        ],
      ),

      //body: wordListWidget()
    );
  }

  void getWordList() async {
    int rowid = widget.item['rowid'];
    wordList = await WordDao.listWord(rowid);
    setState(() {});
  }

  Widget wordListWidget() {
    return Container(
        child: ListView.separated(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              var word = wordList[index];
              return Container(
                  decoration: BoxDecoration(color: Colors.white),
                  padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                  child: Text(word['word']));
            },
            separatorBuilder: (context, index) {
              return Divider(height: 0, color: Colors.black26,);
            },
            itemCount: wordList.length));
  }
}
