import 'package:flutter/material.dart';

class ListCell extends StatelessWidget {
  String title = '';
  String subTitle = '';
  bool showDetail = false;

  ListCell(this.title, {this.subTitle, this.showDetail});

  @override
  Widget build(BuildContext context) {
    if(showDetail == false) {
      return Container(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title),
              subTitleWidget(),
            ],
          ));
    }else{
      return Container(
          padding: EdgeInsets.all(12),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(title),
                    subTitleWidget(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Icon(Icons.arrow_forward_ios, color: Colors.black54, size: 14,),
              ),
            ],
          ));
    }
  }

  Widget subTitleWidget(){
    if(subTitle == null || subTitle == ''){
      return Container();
    }else{
      return Text(
        subTitle,
        style: TextStyle(color: Colors.black87, fontSize: 13.0),
      );
    }
  }
}
