import 'package:flutter/material.dart';

class HistoryCard extends StatelessWidget {
  final String _imgurl;
  final String _heading;
  final double _stars;
  final int _countReviews;

  HistoryCard(this._imgurl, this._heading, this._stars, this._countReviews);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Row(children: [
        new Image.network(
          _imgurl,
          width: 100,
          height: 100,
          fit: BoxFit.cover
          ),
        new Column(children: [
          new Text(_heading),
          new Row(children: [new Text(_stars.toString()), Icon(Icons.star)],),
          new Text(_countReviews.toString() + ' отзывов'),
          ])
      ],),
    );
  }
}