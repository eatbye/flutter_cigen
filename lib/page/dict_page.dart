// import 'package:cupertino_controllers/cupertino_controllers.dart';
import 'package:cupertino_controllers/widgets/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cigen/dao/word_dao.dart';
import 'package:flutter_cigen/page/cigen_detail_page.dart';
import 'package:flutter_cigen/widget/list_cell.dart';

class DictPage extends StatefulWidget {
  @override
  _DictPageState createState() => _DictPageState();
}

class _DictPageState extends State<DictPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  Animation<double> _animation;
  AnimationController _animationController;

  List<Map> wordList = [];

  @override
  void initState() {
    _animationController = new AnimationController(
      duration: new Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = new CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    );
    _focusNode.addListener(() {
      if (!_animationController.isAnimating) {
        _animationController.forward();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            title: Text('英汉词典'),
          ),
          preferredSize: Size.fromHeight(44.0)),
      body: Scrollbar(
        child: ListView(
          children: <Widget>[
            searchBarWidget(),
            Divider(
              height: 0.5,
            ),
            listViewWidget(),
          ],
        ),
      ),
    );
  }

  Widget searchBarWidget() {
    return CupertinoSearchBar(
      controller: _controller,
      focusNode: _focusNode,
      animation: _animation,
      onCancel: () {
        _controller.clear();
        _focusNode.unfocus();
        _animationController.reverse();
        setState(() {
          //_search = "";
        });
      },
      onClear: () {
        _controller.clear();
        setState(() {
          //_search = "";
        });
      },
      onChanged: (String value) {
        if (value != null) {
          searchWordAction(value);
        }
      },
    );
  }

  Widget listViewWidget() {
    return ListView.separated(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          var word = wordList[index];
          return InkWell(
            onTap: (){
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => CigenDetailPage(word, false)));
            },
//            child: Container(
//                padding: EdgeInsets.all(12),
//                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: <Widget>[
//                    Text(word['word']),
//                    Text(
//                      word['notes'],
//                      style: TextStyle(color: Colors.black87, fontSize: 13.0),
//                    ),
//                  ],
//                )),
              child: ListCell(word['word'], subTitle: word['notes'], showDetailArrow: true,),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            height: 0,
          );
        },
        itemCount: wordList.length);
  }

  void searchWordAction(english) async {
    print(english);
    wordList = await WordDao.searchWordList(english);
    print(wordList.length);
    setState(() {});
  }
}
