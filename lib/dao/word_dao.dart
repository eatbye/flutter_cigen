import 'package:flutter_cigen/util/database_helper.dart';

//查询
class WordDao{

  static Future<List<Map>> listWord(itemId) async {
    var db = await DatabaseHelper().db;
    String sql = 'SELECT * FROM word where cid='+itemId.toString();
    List<Map> list = await db.rawQuery(sql);
    return list;
  }

}