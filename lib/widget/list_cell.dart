import 'package:flutter/material.dart';

class ListCell extends StatelessWidget {
  String title = '';
  String subTitle = '';
  bool showDetailArrow = false;
  Widget icon;

  ListCell(this.title, {this.subTitle = '', this.showDetailArrow = false, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(12),
        child: Row(
          children: <Widget>[
            iconWidget(),
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
            detailArrowWidget(),
          ],
        ));
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

  Widget detailArrowWidget(){
    if(showDetailArrow){
      return Padding(
        padding: const EdgeInsets.only(left: 4),
        child: Icon(Icons.arrow_forward_ios, color: Colors.black54, size: 14,),
      );
    }else{
      return Container();
    }
  }

  Widget iconWidget(){
    if(icon == null){
      return Container();
    }else{
      return Padding(
        padding: const EdgeInsets.only(right: 6),
        child: icon,
      );
    }
  }
}
