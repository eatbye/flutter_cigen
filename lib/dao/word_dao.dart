import 'package:flutter_cigen/util/database_helper.dart';

//查询
class WordDao{

  static Future<List<Map>> listWord(itemId) async {
    var db = await DatabaseHelper().db;
    String sql = 'SELECT rowid, * FROM word where cid='+itemId.toString();
    List<Map> list = await db.rawQuery(sql);
    return list;
  }

  static preWord(rowid, cid) async {
    var db = await DatabaseHelper().db;
    String sql = 'select rowid,* from word where cid=? and rowId<? order by rowid desc';
    List<Map> list = await db.rawQuery(sql, [cid, rowid]);
    //print(sql);
    //print(list.length);
    if (list.length>0){
      return list[0];
    }else{
      return null;
    }
  }

  static nextWord(rowid, cid) async {
    var db = await DatabaseHelper().db;
    String sql = 'select rowid,* from word where cid=? and rowId>? order by rowid asc';
    List<Map> list = await db.rawQuery(sql, [cid, rowid]);
    //print(sql);
    //print(list.length);
    if (list.length>0){
      return list[0];
    }else{
      return null;
    }
  }

  static getWord(english) async {
    var db = await DatabaseHelper().db;
    String sql = 'select rowid,* from word where word=?';
    List<Map> list = await db.rawQuery(sql, [english]);
    if (list.length>0){
      return list[0];
    }else{
      return null;
    }
  }

  static searchWordList(String english) async {
    var db = await DatabaseHelper().db;
    String sql = 'select rowid,cid,word,notes,vid,voiceflag,detail,sentence from word where word like ?';
    List<Map> list = await db.rawQuery(sql, [english + '%']);
    return list;
  }

}