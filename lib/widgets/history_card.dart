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
      padding: EdgeInsets.fromLTRB(25, 15, 25, 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color.fromRGBO(189, 189, 189, 1)
          )
        )
      ),
      child: Row(children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color.fromRGBO(39, 174, 96, 1)),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            child:  Image.network(
              _imgurl,
              width: 76,
              height: 76,
              fit: BoxFit.cover,
            ),
          )
        ),
        Container(
          padding: EdgeInsets.only(left: 23),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 5),
              child: Text(_heading, style: TextStyle(fontSize: 20)),
            ),
            Row(
              children: [
              Text(_stars.toString(), style: TextStyle(fontSize: 18)), 
              Icon(Icons.star)],),
            Text(_countReviews.toString() + ' отзывов', style: TextStyle(fontSize: 12, color: Color.fromRGBO(189, 189, 189, 1))),
          ])
        )
      ],),
    );
  }
}