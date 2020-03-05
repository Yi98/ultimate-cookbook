import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'sizeConfig.dart';
import 'card.dart';
import 'textFieldInput.dart';
import 'recipe_by_ingredient_summary.dart';
import 'details.dart';

class SearchWidget extends StatefulWidget {
  SearchWidget({Key key, this.ingredients}) : super(key: key);

  final List<String> ingredients;
  Future<RecipeByIngredientSummary> recipeByIngredientSummary;

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  String hintText = 'Add';

  @override
  void initState() {
    super.initState();
    widget.recipeByIngredientSummary = fetchRecipe();
  }

  @override
  Widget build(BuildContext context) {
    Widget showWidget;

    if (widget.ingredients.length == 0) {
      showWidget = Text('Please add ingredients');
    } else {
      showWidget = FutureBuilder<RecipeByIngredientSummary>(
        future: widget.recipeByIngredientSummary,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Widget> foodCards = [];

            for (var i = 0; i < snapshot.data.recipe.length; i++) {
              foodCards.add(
                InkWell(
                  onTap: () {
                    onViewDetails(
                      snapshot.data.recipe[i]['id'],
                      snapshot.data.recipe[i]['title'],
                      0,
                      0,
                    );
                  },
                  child: CardWidget(
                    id: snapshot.data.recipe[i]['id'],
                    title: snapshot.data.recipe[i]['title'],
                    time: 0,
                    servings: 0,
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
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.safeBlockHorizontal * 3,
      ),
      child: Column(
        children: <Widget>[
          TextFieldInputWidget(
            textFieldHint: 'Add ingredients',
            buttonHint: hintText,
            notifyParent: refresh,
          ),
          Container(
            padding: EdgeInsets.only(bottom: 10.0),
            alignment: Alignment.topLeft,
            child: Wrap(
              children: List.generate(
                widget.ingredients.length,
                (index) {
                  return Container(
                    padding: EdgeInsets.only(right: 5),
                    child: Chip(
                      backgroundColor: Colors.grey[200],
                      label: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(widget.ingredients[index]),
                      ),
                      deleteIcon: Icon(
                        Icons.close,
                      ),
                      onDeleted: () {
                        onDeleteChip(index);
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                showWidget,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<RecipeByIngredientSummary> fetchRecipe(
      {List<String> ingredients = const ['apple', 'lime']}) async {
    String existingIngredients = '';

    for (int i = 0; i < ingredients.length; i++) {
      if (i == ingredients.length - 1) {
        existingIngredients += ingredients[i];
      } else {
        existingIngredients += ingredients[i] + ',';
      }
    }

    final response = await http.get(
        'https://api.spoonacular.com/recipes/findByIngredients?ingredients=$existingIngredients&number=4&apiKey=a2478859405e44f48b5d9037d3ec05c2');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      return RecipeByIngredientSummary.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load post');
    }
  }

  void onViewDetails(id, title, time, servings) {
    Navigator.of(context).push(_createRoute(id, title, time, servings));
  }

  void onDeleteChip(index) {
    setState(() {
      widget.ingredients.removeAt(index);
    });

    onModifyIngredients();
  }

  void refresh(String newItem) {
    setState(() {
      if (newItem == null) {
        hintText = 'Add';
      } else {
        widget.ingredients.add(newItem);
        hintText = 'Clear';
      }
    });

    onModifyIngredients();
  }

  void onModifyIngredients() {
    setState(() {
      widget.recipeByIngredientSummary = fetchRecipe(
        ingredients: widget.ingredients,
      );
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
