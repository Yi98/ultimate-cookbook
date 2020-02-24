import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:food_recipe/ingredient_autocomplete.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'sizeConfig.dart';

class TextFieldInputWidget extends StatefulWidget {
  TextFieldInputWidget(
      {Key key,
      this.textFieldHint,
      this.buttonHint,
      @required this.notifyParent})
      : super(key: key);

  final String textFieldHint;
  final String buttonHint;
  double paddingBottom;
  final Function(String) notifyParent;
  var textFieldController = TextEditingController();
  Future<IngredientAutocomplete> ingredientsAutocomplete;
  String currentText;
  Widget searchBox;
  List<String> ingredients = [];

  @override
  _TextFieldInputState createState() => _TextFieldInputState();
}

class _TextFieldInputState extends State<TextFieldInputWidget> {
  @override
  void initState() {
    super.initState();
    widget.ingredientsAutocomplete = fetchIngredients('');
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    widget.textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.buttonHint == 'Add') {
      widget.paddingBottom = SizeConfig.safeBlockVertical * 0.5;
      // widget.searchBox = SimpleAutoCompleteTextField(
      //   textChanged: (text) => {
      //     onTextChanged(text),
      //   },
      //   // textSubmitted: (text) => {
      //   //   widget.currentText = text,
      //   // },
      //   key: widget.key,
      //   suggestions: widget.ingredients,
      //   decoration: new InputDecoration(
      //     contentPadding: EdgeInsets.only(
      //       top: SizeConfig.safeBlockVertical * 1,
      //     ),
      //     focusedBorder: new UnderlineInputBorder(
      //       borderSide: new BorderSide(color: Colors.blueGrey),
      //     ),
      //     hintText: widget.textFieldHint,
      //   ),
      //   style: new TextStyle(
      //     fontSize: SizeConfig.safeBlockHorizontal * 4.5,
      //   ),
      // );
      widget.searchBox = FutureBuilder<IngredientAutocomplete>(
        future: widget.ingredientsAutocomplete,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            widget.ingredients.clear();

            for (int i = 0; i < snapshot.data.ingredients.length; i++) {
              widget.ingredients.add(
                snapshot.data.ingredients[i]['name'],
              );
            }

            print(widget.ingredients);

            return SimpleAutoCompleteTextField(
              textChanged: (text) => {
                onTextChanged(text),
              },
              key: widget.key,
              suggestions: widget.ingredients,
              decoration: new InputDecoration(
                contentPadding: EdgeInsets.only(
                  top: SizeConfig.safeBlockVertical * 1,
                ),
                focusedBorder: new UnderlineInputBorder(
                  borderSide: new BorderSide(color: Colors.blueGrey),
                ),
                hintText: widget.textFieldHint,
              ),
              clearOnSubmit: false,
              textSubmitted: (text) => {
                widget.currentText = text,
              },
              style: new TextStyle(
                fontSize: SizeConfig.safeBlockHorizontal * 4.5,
              ),
            );
          }

          return new CircularProgressIndicator();
        },
      );
    } else {
      widget.paddingBottom = SizeConfig.safeBlockVertical * 2;
      widget.searchBox = TextField(
        controller: widget.textFieldController,
        decoration: new InputDecoration(
          contentPadding: EdgeInsets.only(
            top: SizeConfig.safeBlockVertical * 1,
          ),
          focusedBorder: new UnderlineInputBorder(
            borderSide: new BorderSide(color: Colors.blueGrey),
          ),
          hintText: widget.textFieldHint,
        ),
        style: new TextStyle(
          fontSize: SizeConfig.safeBlockHorizontal * 4.5,
        ),
      );
    }

    return Container(
      padding: EdgeInsets.only(
        bottom: widget.paddingBottom,
      ),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: SizeConfig.safeBlockHorizontal,
            ),
            width: SizeConfig.safeBlockHorizontal * 65,
            child: widget.searchBox,
          ),
          Container(
            padding: EdgeInsets.only(
              top: SizeConfig.safeBlockVertical * 1.5,
              left: SizeConfig.safeBlockHorizontal * 5,
            ),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(5.0),
              ),
              elevation: 4.0,
              color: Colors.orange[300],
              child: Text(widget.buttonHint),
              onPressed: () {
                if (widget.buttonHint == 'Add') {
                  widget.notifyParent(widget.currentText);
                } else {
                  widget.notifyParent(widget.textFieldController.text);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<IngredientAutocomplete> fetchIngredients(String term) async {
    final response = await http.get(
        'https://api.spoonacular.com/food/ingredients/autocomplete?query=$term&number=10&apiKey=a2478859405e44f48b5d9037d3ec05c2');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      return IngredientAutocomplete.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load post');
    }
  }

  void onTextChanged(String term) {
    setState(
      () {
        print(widget.currentText);
        widget.currentText = term;
        widget.ingredientsAutocomplete = fetchIngredients(term);
      },
    );
  }
}
