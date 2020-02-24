import 'package:flutter/material.dart';

import 'sizeConfig.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    Key key,
    this.id,
    this.title,
    this.time,
    this.servings,
  }) : super(key: key);

  final int id;
  final String title;
  final int time;
  final int servings;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            SizeConfig.safeBlockHorizontal * 2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  SizeConfig.safeBlockHorizontal * 2,
                ),
                topRight: Radius.circular(
                  SizeConfig.safeBlockHorizontal * 2,
                ),
              ),
              child: Image.network(
                'https://spoonacular.com/recipeImages/$id-636x393.jpg',
                fit: BoxFit.cover,
                height: SizeConfig.blockSizeVertical * 18,
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(
                top: SizeConfig.safeBlockVertical * 1.5,
                bottom: SizeConfig.safeBlockVertical,
                left: SizeConfig.safeBlockHorizontal * 3,
              ),
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: SizeConfig.safeBlockHorizontal * 5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              padding:
                  EdgeInsets.only(bottom: SizeConfig.safeBlockVertical * 1.5),
              child: Row(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(
                      left: SizeConfig.safeBlockHorizontal * 3,
                    ),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.access_time,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: SizeConfig.safeBlockHorizontal * 0.5,
                          ),
                          child: Text(
                            '$time\'',
                            style: TextStyle(
                              fontSize: SizeConfig.safeBlockHorizontal * 3.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(
                      left: SizeConfig.safeBlockHorizontal * 4,
                    ),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.people,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: SizeConfig.safeBlockHorizontal * 0.5,
                          ),
                          child: Text(
                            '$servings servings',
                            style: TextStyle(
                              fontSize: SizeConfig.safeBlockHorizontal * 3.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
