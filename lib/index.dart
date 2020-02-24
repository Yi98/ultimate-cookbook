import 'package:flutter/material.dart';

import 'sizeConfig.dart';
import 'explore.dart';
import 'search.dart';

class IndexWidget extends StatefulWidget {
  IndexWidget({Key key}) : super(key: key);

  TabController _controller;
  final List<String> ingredients = [];

  @override
  _IndexWidgetState createState() => _IndexWidgetState();
}

class _IndexWidgetState extends State<IndexWidget> with SingleTickerProviderStateMixin{
  @override
  void initState() {
    super.initState();
    widget._controller = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                top: SizeConfig.safeBlockVertical * 1.5,
                left: SizeConfig.safeBlockHorizontal * 1.5,
                bottom: SizeConfig.safeBlockVertical,
              ),
              alignment: Alignment.topLeft,
              child: TabBar(
                controller: widget._controller,
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                    width: 3.0,
                    color: Colors.redAccent,
                  ),
                  insets: EdgeInsets.symmetric(horizontal: 30.0),
                ),
                isScrollable: true,
                labelPadding: EdgeInsets.all(
                  SizeConfig.safeBlockHorizontal * 2.5,
                ),
                tabs: [
                  Text(
                    'Explore',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: SizeConfig.safeBlockHorizontal * 4.0,
                    ),
                  ),
                  Text(
                    'What\'s in the fridge',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: SizeConfig.safeBlockHorizontal * 4.0,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: TabBarView(
                  controller: widget._controller,
                  children: <Widget>[
                    ExploreWidget(),
                    SearchWidget(ingredients: widget.ingredients),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
