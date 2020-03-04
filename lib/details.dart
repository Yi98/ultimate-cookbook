import 'package:flutter/material.dart';
import 'package:food_recipe/preparation_summary.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'sizeConfig.dart';
import 'ingredient.dart';
import 'equipment.dart';
import 'preparation.dart';
import 'ingredient_summary.dart';
import 'equipement_summary.dart';
import 'preparation_summary.dart';

class DetailsWidget extends StatefulWidget {
  const DetailsWidget(
      {Key key, this.foodId, this.title, this.time, this.servings})
      : super(key: key);

  final int foodId;
  final String title;
  final int time;
  final int servings;

  @override
  _DetailsWidgetState createState() => _DetailsWidgetState();
}

class _DetailsWidgetState extends State<DetailsWidget>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  Future<IngredientSummary> ingredientSummary;
  Future<EquipmentSummary> equipmentSummary;
  Future<PreparationSummary> preparationSummary;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Image.network(
                  'https://spoonacular.com/recipeImages/${widget.foodId}-636x393.jpg',
                  fit: BoxFit.cover,
                  height: SizeConfig.safeBlockVertical * 35.0),
              Container(
                padding: EdgeInsets.only(
                  top: 10,
                  left: 5,
                ),
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  iconSize: 30,
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      35.0,
                    ),
                    topRight: Radius.circular(
                      35.0,
                    ),
                  ),
                ),
                width: SizeConfig.safeBlockHorizontal * 100,
                margin: EdgeInsets.only(
                  top: SizeConfig.safeBlockVertical * 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          top: SizeConfig.safeBlockVertical * 4,
                          bottom: SizeConfig.safeBlockVertical * 1.5,
                          left: SizeConfig.safeBlockHorizontal * 5,
                          right: SizeConfig.safeBlockHorizontal * 4),
                      child: Text(
                        widget.title,
                        overflow: TextOverflow.visible,
                        style: TextStyle(
                          fontSize: SizeConfig.safeBlockHorizontal * 5,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: SizeConfig.safeBlockHorizontal * 5,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                                right: SizeConfig.safeBlockHorizontal),
                            child: Icon(
                              Icons.access_time,
                            ),
                          ),
                          Text(
                            '${widget.time}\'',
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              left: SizeConfig.safeBlockHorizontal * 5,
                              right: SizeConfig.safeBlockHorizontal,
                            ),
                            child: Icon(
                              Icons.people,
                            ),
                          ),
                          Text(
                            '${widget.servings} portions',
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        top: SizeConfig.safeBlockVertical * 3,
                        left: SizeConfig.safeBlockHorizontal * 3,
                      ),
                      child: TabBar(
                        controller: _controller,
                        indicator: UnderlineTabIndicator(
                          borderSide:
                              BorderSide(width: 3.0, color: Colors.redAccent),
                          insets: EdgeInsets.symmetric(horizontal: 30.0),
                        ),
                        isScrollable: true,
                        labelPadding: EdgeInsets.all(
                          SizeConfig.safeBlockHorizontal * 2.5,
                        ),
                        tabs: [
                          Text(
                            'Ingredients',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: SizeConfig.safeBlockHorizontal * 4.0,
                            ),
                          ),
                          Text(
                            'Equipments',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: SizeConfig.safeBlockHorizontal * 4.0,
                            ),
                          ),
                          Text(
                            'Preparations',
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
                        padding: EdgeInsets.only(
                          top: SizeConfig.safeBlockVertical * 2,
                          // left: SizeConfig.safeBlockHorizontal * 5.5,
                        ),
                        child: TabBarView(
                          controller: _controller,
                          children: <Widget>[
                            FutureBuilder(
                              future: fetchIngredient(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  List ingredients;

                                  ingredients = snapshot.data.ingredients;

                                  return IngredientWidget(
                                    ingredients: ingredients,
                                  );
                                }

                                return Center(
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
                            FutureBuilder(
                              future: fetchEquipment(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  List equipments;

                                  equipments = snapshot.data.equipments;

                                  return EquipmentWidget(
                                    equipments: equipments,
                                  );
                                }

                                return Center(
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
                            FutureBuilder(
                              future: fetchPreparations(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  List preparations;

                                  preparations = snapshot.data.preparations;

                                  return PreparationWidget(
                                      preparations: preparations);
                                }

                                return Center(
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
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<IngredientSummary> fetchIngredient() async {
    final response = await http.get(
        'https://api.spoonacular.com/recipes/${widget.foodId}/ingredientWidget.json?apiKey=a2478859405e44f48b5d9037d3ec05c2');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      return IngredientSummary.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load post');
    }
  }

  Future<EquipmentSummary> fetchEquipment() async {
    final response = await http.get(
        'https://api.spoonacular.com/recipes/${widget.foodId}/equipmentWidget.json?apiKey=a2478859405e44f48b5d9037d3ec05c2');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      return EquipmentSummary.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load post');
    }
  }

  Future<PreparationSummary> fetchPreparations() async {
    final response = await http.get(
        'https://api.spoonacular.com/recipes/${widget.foodId}/analyzedInstructions?apiKey=a2478859405e44f48b5d9037d3ec05c2');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      return PreparationSummary.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load post');
    }
  }
}
