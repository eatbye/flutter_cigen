import 'package:flutter_cigen/util/database_helper.dart';

//词根词缀数据库查询
class ItemDao{

  static Future<List<Map>> listItem(type) async {
    var db = await DatabaseHelper().db;
    String sql = 'SELECT * FROM items';
    if(type=='1'){ //前缀
      sql = sql + ' where vid=1 or vid=2';
    }else if(type=='2'){ //后缀
      sql = sql + ' where vid=4 or vid=5';
    }else if(type=='3'){ //词根
      sql = sql + ' where vid=3';
    }else{ //词缀
      sql = sql + ' where vid=6';
    }
    List<Map> list = await db.rawQuery(sql);
    return list;
  }

}