import 'package:flutter/material.dart';

class CigenDetailPage extends StatefulWidget {
  var word;

  CigenDetailPage(this.word);

  @override
  _CigenDetailPageState createState() => _CigenDetailPageState();
}

class _CigenDetailPageState extends State<CigenDetailPage> {
  bool favorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          title: Text(widget.word['word']),
        ),
        preferredSize: Size.fromHeight(44.0),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(),
          ),
          toolbarWidget()
        ],
      ),
    );
  }

  Widget toolbarWidget(){
    var favoriteIcon = Icon(Icons.favorite_border);
    if(favorite){
      favoriteIcon = Icon(Icons.favorite, color: Colors.red,);
    }
    return Container(
      padding: EdgeInsets.all(0),
      decoration: BoxDecoration(color: Colors.black12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FlatButton(child: Icon(Icons.arrow_back),onPressed: (){},),
          FlatButton(child: favoriteIcon, onPressed: (){
            favorite = !favorite;
            setState(() {

            });
          },),
          FlatButton(child: Icon(Icons.arrow_forward_ios),onPressed: (){},),
        ],
      ),
    );
  }
}
