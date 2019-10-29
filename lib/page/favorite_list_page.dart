import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cigen/dao/notebook_dao.dart';
import 'package:flutter_cigen/dao/word_dao.dart';
import 'package:flutter_cigen/page/cigen_detail_page.dart';
import 'package:flutter_cigen/util/counter.dart';
import 'package:flutter_cigen/widget/list_cell.dart';
import 'package:provider/provider.dart';
//import 'package:provide/provide.dart';

//生词本列表
class FavoriteListPage extends StatefulWidget {
  @override
  _FavoriteListPageState createState() => _FavoriteListPageState();
}

class _FavoriteListPageState extends State<FavoriteListPage> {
  List<Map> notebookList = [];
  int favoriteValue = 0;
  int noteboolListCount = -1; //单词数量，默认-1代表未知

  @override
  void initState() {
    super.initState();
    getNotebook();
  }

  @override
  Widget build(BuildContext context) {
    /*
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
        body: mainWidget(),
      );
    });

     */

    var providerFavoriteValue = Provider.of<Counter>(context).favoriteValue;
    if(providerFavoriteValue != favoriteValue){
      favoriteValue = providerFavoriteValue;
      getNotebook();
    }

    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            title: Text('生词本'),
          ),
          preferredSize: Size.fromHeight(44.0)),
      body: mainWidget(),
    );
  }

  //主界面
  Widget mainWidget(){
    if(noteboolListCount == 0){
      return blankWidget();
    }else{
      return listViewWidget();
    }
  }

  //空白页面
  Widget blankWidget(){
    return Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Image.asset('assets/image/empty.png', height: 140, width: 140, fit: BoxFit.fill,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('暂无生词'),
        ),
        SizedBox(height: 40,)
      ],
    ),);
  }

  //列表页面
  Widget listViewWidget(){
    return Scrollbar(
      child: ListView.separated(
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
    noteboolListCount = notebookList.length;
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
