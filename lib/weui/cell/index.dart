import 'package:flutter/material.dart';
import '../theme/index.dart';
// 间距
const double labelSpacing = 20.0;

class WeCells extends StatelessWidget {
  final bool boxBorder;
  final double spacing;
  final List<Widget> children;

  WeCells({
    this.boxBorder = true,
    this.spacing = labelSpacing,
    @required this.children,
  });

  @override
  Widget build(BuildContext context) {
    // 边框
    final Color borderColor = WeUi.getTheme(context).defaultBorderColor;
    final Divider _border = Divider(height: 1, color: borderColor);
    final List<Widget> newChildren = [];

    children.forEach((item) {
      if (item != children[0]) {
        newChildren.add(
          Padding(
            padding: EdgeInsets.only(left: spacing),
            child: _border
          )
        );
      }
      newChildren.add(item);
    });

    // 判断是否添加容器边框
    if (boxBorder) {
      newChildren.add(_border);
      newChildren.insert(0, _border);
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white
      ),
      child: _WeCellsScope(
        weCells: this,
        child: Column(
          children: newChildren
        ),
      )
    );
  }
}

class WeCell extends StatelessWidget {
  // label
  final Widget label;
  // 内容
  final Widget content;
  // footer
  final Widget footer;
  // 对齐方式
  final Alignment align;
  // 间距
  final double spacing;
  // 最小高度
  final double minHeight;
  // 点击
  final Function onClick;

  WeCell({
    label,
    content,
    this.footer,
    this.align = Alignment.centerRight,
    this.spacing = labelSpacing,
    this.minHeight = 46.0,
    this.onClick
  }):
    this.label = label is String ? Text(label) : label,
    this.content = content is String ? Text(content) : content;

  // 点击
  void onTap() {
    onClick();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    final _WeCellsScope weCellsScope = _WeCellsScope.of(context);
    final double _spacing = weCellsScope == null ? spacing : weCellsScope.weCells.spacing;

    // label
    if (label is Widget) {
      children = [
        label
      ];

      if (content is Widget) {
        children.add(
          Expanded(
            flex: 1,
            child: Align(
              alignment: align,
              child: content
            )
          )
        );
      }
    } else {
      children = [
        Expanded(
          flex: 1,
          child: content
        )
      ];
    }

    // footer
    if (footer != null) {
      children.add(
        Padding(
          padding: EdgeInsets.only(left: 5),
          child: footer
        )
      );
    }

    final child = Container(
      constraints: BoxConstraints(
        minHeight: minHeight
      ),
      child: DefaultTextStyle(
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.black
        ),
        child: Padding(
          padding: EdgeInsets.only(left: _spacing, right: _spacing),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: children
          )
        )
      )
    );

    if (onClick == null) {
      return child;
    }

    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        child: child
      )
    );
  }
}

class _WeCellsScope extends InheritedWidget {
  final WeCells weCells;

  _WeCellsScope({
    Key key,
    child,
    this.weCells,
  }) : super(key: key, child: child);

  static _WeCellsScope of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_WeCellsScope>();
  }

  @override
  bool updateShouldNotify(_WeCellsScope oldWidget) {
    return true;
  }
}

