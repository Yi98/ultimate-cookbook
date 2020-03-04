import 'package:flutter/material.dart';

import 'sizeConfig.dart';
import 'explore.dart';
import 'search.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ultimate Cookbook',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  final List<String> ingredients = [];

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // Important: Include this to use sizeConfig
    SizeConfig().init(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                top: SizeConfig.safeBlockVertical * 1.5,
                left: SizeConfig.safeBlockHorizontal * 1.5,
                bottom: SizeConfig.safeBlockVertical,
              ),
              alignment: Alignment.topLeft,
              child: TabBar(
                controller: _controller,
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
                    'Find by ingredients',
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
                color: Colors.grey[50],
                child: TabBarView(
                  controller: _controller,
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
