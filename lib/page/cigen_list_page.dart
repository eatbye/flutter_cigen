import 'package:flutter/material.dart';
import 'package:flutter_cigen/dao/item_dao.dart';

class CigenListPage extends StatefulWidget {
  String type;

  CigenListPage(this.type);

  @override
  _CigenListPageState createState() => _CigenListPageState(type);
}

class _CigenListPageState extends State<CigenListPage> with AutomaticKeepAliveClientMixin{
  String type;
  List<Map> itemList = [];

  _CigenListPageState(this.type);

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    getItemList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      body: Center(child: Text(type)),
      body: ListView.separated(
          itemBuilder: (context, index){
            var item = itemList[index];
            return Container(
                padding: EdgeInsets.fromLTRB(10,6,10,6),
                child: Text(item['desc']));
//            return ListTile(title: Text(item['desc']),);
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemCount: itemList.length),
    );
  }

  //数据库查询
  void getItemList() async {
    itemList = await ItemDao.listItem(type);
    setState(() {});
    print(itemList.length);
  }
}
