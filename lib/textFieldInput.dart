import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:food_recipe/ingredient_autocomplete.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'sizeConfig.dart';

class TextFieldInputWidget extends StatefulWidget {
  TextFieldInputWidget({
    Key key,
    this.textFieldHint,
    this.buttonHint,
    @required this.notifyParent,
  }) : super(key: key);

  final String textFieldHint;
  final String buttonHint;
  double paddingBottom;
  final Function(String) notifyParent;
  Future<IngredientAutocomplete> ingredientsAutocomplete;
  String currentText;
  Widget searchBox;
  List<String> ingredients = [];

  @override
  _TextFieldInputState createState() => _TextFieldInputState();
}

class _TextFieldInputState extends State<TextFieldInputWidget> {
  var textFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.paddingBottom = SizeConfig.safeBlockVertical;
    widget.searchBox = TextField(
      controller: textFieldController,
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
                if (widget.buttonHint == 'Clear') {
                  textFieldController.text = '';
                  widget.notifyParent(null);
                  return;
                }
                widget.notifyParent(textFieldController.text);
              },
            ),
          ),
        ],
      ),
    );
  }
}
