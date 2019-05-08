import 'package:flutter_cigen/util/database_helper.dart';

//查询
class NotebookDao{

  static getNotebook(english) async {
    var db = await DatabaseHelper().db;
    String sql = 'select rowid,english,chinese,addTime from notebook where english=?';
    List<Map> list = await db.rawQuery(sql, [english]);
    if (list.length>0){
      return list[0];
    }else{
      return null;
    }
  }

  static saveNotebook(english, chinese, addTime) async {
    var db = await DatabaseHelper().db;
    String sql = 'insert into notebook (english,chinese,addTime) values (?,?,?)';
    await db.rawInsert(sql, [english, chinese, addTime]);
  }

  static void deleteNotebook(english) async {
    var db =  await DatabaseHelper().db;
    String sql = 'delete from notebook where english=?';
    await db.rawDelete(sql,[english]);
  }

  static noteList() async{
    var db = await DatabaseHelper().db;
    String sql = 'select * from notebook order by rowid desc';
    return await db.rawQuery(sql);
  }

}