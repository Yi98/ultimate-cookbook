import 'package:flutter/material.dart';

import 'sizeConfig.dart';

class ListItem extends StatelessWidget {
  ListItem({Key key, this.name, this.amount, this.unit}) : super(key: key);

  final String name;
  final double amount;
  final String unit;
  String itemText;

  @override
  Widget build(BuildContext context) {
    if (unit == 'none') {
      itemText = name;
    } else {
      itemText = amount.toString() + unit + ' ' + name;
    }

    return Container(
      padding: EdgeInsets.only(
        bottom: SizeConfig.safeBlockVertical,
        left: SizeConfig.safeBlockHorizontal * 5.5,
      ),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              right: 8.0,
            ),
            child: Icon(
              Icons.check,
            ),
          ),
          Text(
            itemText,
            style: TextStyle(
              fontSize: SizeConfig.safeBlockHorizontal * 4,
            ),
          ),
        ],
      ),
    );
  }
}
