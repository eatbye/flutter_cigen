import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cigen/dao/notebook_dao.dart';
import 'package:flutter_cigen/dao/word_dao.dart';
import 'package:flutter_cigen/page/cigen_detail_page.dart';
import 'package:flutter_cigen/util/counter.dart';
import 'package:flutter_cigen/widget/list_cell.dart';
import 'package:provide/provide.dart';

//生词本列表
class FavoriteListPage extends StatefulWidget {
  @override
  _FavoriteListPageState createState() => _FavoriteListPageState();
}

class _FavoriteListPageState extends State<FavoriteListPage> {
  List<Map> notebookList = [];
  int favoriteValue = 0;

  @override
  void initState() {
    super.initState();
    getNotebook();
  }

  @override
  Widget build(BuildContext context) {
    return Provide<Counter>(builder: (context, child, counter) {
      if (counter.favoriteValue != favoriteValue) {
        favoriteValue = counter.favoriteValue;
        getNotebook();
      }
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
              onTap: () {
                detailPage(notebook['english']);
              },
              child: Dismissible(
                //滑动删除
                key: Key(notebook['english'].toString()),
                direction: DismissDirection.endToStart,
                //从右侧向左滑动
                onDismissed: (direction)  {
                  //从生词本中移除
                  removeNotebook(notebook['english']);
                  setState(() {
                    notebookList.removeAt(index);
                  });
                },
                background: stackBehindDismiss(),
                //滑动后显示的背景内容
                child: ListCell(
                  notebook['english'],
                  subTitle: notebook['chinese'],
                  showDetailArrow: true,
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Divider(height: 0);
          },
          itemCount: notebookList.length,
        ),
      );
    });
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
    var dbNotebookList = await NotebookDao.noteList();
    //数据库查询后需要转换存放到原来的list中，否则remove方法无法调用
    notebookList.clear();
    notebookList.addAll(dbNotebookList);
    setState(() {});
  }

  void removeNotebook(english) async {
    await NotebookDao.deleteNotebook(english);
  }

  void detailPage(english) async {
    var word = await WordDao.getWord(english);
    if (word != null) {
      Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => CigenDetailPage(word, false)));
    }
  }
}
