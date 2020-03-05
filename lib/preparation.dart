import 'package:flutter/material.dart';

import 'sizeConfig.dart';

class PreparationWidget extends StatelessWidget {
  const PreparationWidget({Key key, this.preparations}) : super(key: key);

  final List preparations;

  @override
  Widget build(BuildContext context) {
    if (preparations.length == 0) {
      return Container(
        alignment: Alignment.center,
        child: Text('Preparations not found'),
      );
    } else {
      return Container(
        child: ListView(
          children: List.generate(
            preparations[0]['steps'].length,
            (index) {
              return Container(
                padding: EdgeInsets.only(
                  bottom: SizeConfig.safeBlockVertical * 2,
                  left: SizeConfig.safeBlockHorizontal * 5.5,
                  right: SizeConfig.safeBlockHorizontal * 5.5,
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        preparations[0]['steps'][index]['number'].toString() +
                            '. ' +
                            preparations[0]['steps'][index]['step'],
                        style: TextStyle(
                          fontSize: SizeConfig.safeBlockHorizontal * 4,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );
    }
  }
}
