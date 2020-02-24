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
            buttonHint: 'Search',
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
                    'Recommended',
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
                    } else {
                      return InkWell(
                        onTap: () {
                          onViewDetails(
                            220,
                            'Test',
                            12,
                            6,
                          );
                        },
                        child: CardWidget(
                          id: 220,
                          title: 'Test',
                          time: 12,
                          servings: 6,
                        ),
                      );
                    }

                    return new CircularProgressIndicator();
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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsWidget(
            foodId: id, title: title, time: time, servings: servings),
      ),
    );
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
    print(searchTerm);
    setState(() {
      widget.recipeSummary = fetchRecipe(searchTerm: searchTerm);
    });
  }
}
