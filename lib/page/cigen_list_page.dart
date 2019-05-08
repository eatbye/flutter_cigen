import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cigen/dao/item_dao.dart';
import 'package:flutter_cigen/page/cigen_info_page.dart';
import 'package:flutter_cigen/widget/list_cell.dart';

class CigenListPage extends StatefulWidget {
  String type;

  CigenListPage(this.type);

  @override
  _CigenListPageState createState() => _CigenListPageState();
}

class _CigenListPageState extends State<CigenListPage>
    with AutomaticKeepAliveClientMixin {
  List<Map> itemList = [];

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
      body: ListView.separated(
          itemBuilder: (context, index) {
            var item = itemList[index];
            return InkWell(
//              child: Container(
//                  padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
//                  child: Text(item['desc'])
//              ),
              child: ListCell(item['desc']),
              onTap: (){
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => CigenInfoPage(item)));
              },
            );
//            return ListTile(title: Text(item['desc']),);
            /*
            return ListTile(
              title: Text(item['desc']),
              trailing: Icon(Icons.keyboard_arrow_right),
              contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),

            );
            */
          },
          separatorBuilder: (context, index) {
            return Divider(height: 0);
          },
          itemCount: itemList.length),
    );
  }

  //数据库查询
  void getItemList() async {
    itemList = await ItemDao.listItem(widget.type);
    setState(() {});
  }

}
