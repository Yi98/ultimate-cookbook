import 'package:flutter/material.dart';

import 'sizeConfig.dart';
import 'listItem.dart';

class EquipmentWidget extends StatelessWidget {
  const EquipmentWidget({Key key, this.equipments}) : super(key: key);

  final List equipments;

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
              child: Container(
                padding: EdgeInsets.only(
                  bottom: SizeConfig.safeBlockVertical,
                ),
                child: ListView(
                  children: List.generate(
                    equipments.length,
                    (index) {
                      return ListItem(
                      name: equipments[index]['name'],
                      amount: 0,
                      unit: 'none',
                    );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
