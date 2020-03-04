import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'recipe_summary.dart';
import 'sizeConfig.dart';
import 'details.dart';
import 'card.dart';
import 'textFieldInput.dart';

class ExploreWidget extends StatefulWidget {
  ExploreWidget({Key key}) : super(key: key);

  Future<RecipeSummary> recipeSummary;

  @override
  _ExploreWidgetState createState() => _ExploreWidgetState();
}

class _ExploreWidgetState extends State<ExploreWidget> {
  String title = 'Recommended';
  String hintText = 'Search';

  @override
  void initState() {
    super.initState();
    widget.recipeSummary = fetchRecipe();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.safeBlockHorizontal * 3,
      ),
      child: Column(
        children: <Widget>[
          TextFieldInputWidget(
            textFieldHint: 'Search for recipes...',
            buttonHint: hintText,
            notifyParent: refresh,
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(
                    bottom: SizeConfig.safeBlockVertical,
                    left: SizeConfig.safeBlockHorizontal,
                  ),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 6,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                FutureBuilder<RecipeSummary>(
                  future: widget.recipeSummary,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Widget> foodCards = [];

                      for (var i = 0; i < snapshot.data.results.length; i++) {
                        foodCards.add(
                          InkWell(
                            onTap: () {
                              onViewDetails(
                                snapshot.data.results[i]['id'],
                                snapshot.data.results[i]['title'],
                                snapshot.data.results[i]['readyInMinutes'],
                                snapshot.data.results[i]['servings'],
                              );
                            },
                            child: CardWidget(
                              id: snapshot.data.results[i]['id'],
                              title: snapshot.data.results[i]['title'],
                              time: snapshot.data.results[i]['readyInMinutes'],
                              servings: snapshot.data.results[i]['servings'],
                            ),
                          ),
                        );
                      }

                      return Column(
                        children: foodCards,
                      );
                    }

                    return Container(
                      padding: EdgeInsets.only(
                        top: SizeConfig.safeBlockVertical * 30,
                      ),
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 50.0,
                        width: 50.0,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(
                            Colors.deepOrange,
                          ),
                          strokeWidth: 4.0,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onViewDetails(id, title, time, servings) {
    Navigator.of(context).push(_createRoute(id, title, time, servings));
  }

  Future<RecipeSummary> fetchRecipe({String searchTerm = 'salad'}) async {
    final response = await http.get(
        'https://api.spoonacular.com/recipes/search?query=$searchTerm&number=3&apiKey=a2478859405e44f48b5d9037d3ec05c2');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      return RecipeSummary.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load post');
    }
  }

  void refresh(String searchTerm) {
    setState(() {
      if (searchTerm == null) {
        title = 'Recommended';
        hintText = 'Search';
      } else {
        widget.recipeSummary = fetchRecipe(searchTerm: searchTerm);
        title = 'Search results: ' + searchTerm;
        hintText = 'Clear';
      }
    });
  }

  Route _createRoute(id, title, time, servings) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => DetailsWidget(
        foodId: id,
        title: title,
        time: time,
        servings: servings,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
