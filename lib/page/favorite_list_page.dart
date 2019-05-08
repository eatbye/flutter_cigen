import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cigen/dao/notebook_dao.dart';
import 'package:flutter_cigen/dao/word_dao.dart';
import 'package:flutter_cigen/page/cigen_detail_page.dart';

//生词本列表
class FavoriteListPage extends StatefulWidget {
  @override
  _FavoriteListPageState createState() => _FavoriteListPageState();
}

class _FavoriteListPageState extends State<FavoriteListPage> {
  List<Map> notebookList = [];

  @override
  void initState() {
    super.initState();
    getNotebook();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            title: Text('生词本'),
          ),
          preferredSize: Size.fromHeight(44.0)),
      body: ListView.separated(
        itemBuilder: (context, index) {
          var notebook = notebookList[index];
          return InkWell(
            onTap: (){
              print(notebook['english']);
              detailPage(notebook['english']);
            },
            child: Dismissible(  //滑动删除
              key: Key(notebook['english']),
              direction: DismissDirection.endToStart, //从右侧向左滑动
              onDismissed: (direction) {
                //从生词本中移除
                NotebookDao.deleteNotebook(notebook['english']);
              },
              background: stackBehindDismiss(), //滑动后显示的背景内容
              child: Container(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(notebook['english']),
                      Text(
                        notebook['chinese'],
                        style: TextStyle(color: Colors.black87, fontSize: 13.0),
                      ),
                    ],
                  )),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(height: 0);
        },
        itemCount: notebookList.length,
      ),
    );
  }

  Widget stackBehindDismiss() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20.0),
      color: Colors.red,
      child: Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }

  void getNotebook() async {
    notebookList = await NotebookDao.noteList();
    print(notebookList.length);
    setState(() {});

  }

  void detailPage(english) async {
    var word = await WordDao.getWord(english);
    if(word!=null){
      Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => CigenDetailPage(word, false)));
    }
  }
}
