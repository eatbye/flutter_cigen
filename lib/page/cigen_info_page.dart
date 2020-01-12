import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cigen/dao/item_dao.dart';
import 'package:flutter_cigen/dao/word_dao.dart';
import 'package:flutter_cigen/page/cigen_detail_page.dart';
import 'package:flutter_cigen/util/counter.dart';
import 'package:flutter_cigen/widget/list_cell.dart';
import 'package:flutter_cigen/widget/title_widget.dart';
//import 'package:provide/provide.dart';
import 'package:provider/provider.dart';
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
    setReadFlag();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            title: Text('词根词缀'),
          ),
          preferredSize: Size.fromHeight(44.0)),

        body: Scrollbar(
          child: ListView(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Divider(height: 0),
            Container(
//                decoration: BoxDecoration(color: Colors.white),
                padding: EdgeInsets.all(12),
                child: Text(widget.item['desc'])),
            Divider(height: 0),
            SizedBox(
              height: 20,
            ),
            Divider(height: 0),
            wordListWidget(),
            Divider(height: 0)
          ],
      ),
        ),

      //body: wordListWidget()
    );
  }

  void getWordList() async {
    int rowid = widget.item['rowid'];
    wordList = await WordDao.listWord(rowid);
    setState(() {});
  }

  //设置为已读
  void setReadFlag() async {
    int rowid = widget.item['rowid'];
    ItemDao.updateItemFlag(rowid,1);


  }

  Widget wordListWidget() {
    return Container(
        child: ListView.separated(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              var word = wordList[index];
              return Container(
//                  decoration: BoxDecoration(color: Colors.white),
                  child: InkWell(
                    child: ListCell(word['word'], subTitle:word['notes'], showDetailArrow: true,),
                    onTap: (){
                      //状态更新(已读)
//                      Provider.value<Counter>(context).read();
                        Provider.of<Counter>(context, listen: false).read();
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => CigenDetailPage(word)));
                    },
                  ));
            },
            separatorBuilder: (context, index) {
              return Divider(height: 0);
            },
            itemCount: wordList.length));
  }
}
