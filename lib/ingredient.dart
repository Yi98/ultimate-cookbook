import 'package:flutter/material.dart';
import 'package:food_recipe/listItem.dart';

import 'sizeConfig.dart';
import 'listItem.dart';

class IngredientWidget extends StatelessWidget {
  const IngredientWidget({Key key, this.ingredients}) : super(key: key);

  final List ingredients;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
                bottom: SizeConfig.safeBlockVertical,
              ),
              child: ListView(
                children: List.generate(
                  ingredients.length,
                  (index) {
                    return ListItem(
                      name: ingredients[index]['name'],
                      amount: ingredients[index]['amount']['metric']['value'],
                      unit: ingredients[index]['amount']['metric']['unit'],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
