import '../models/full_product_info.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class ReviewCard extends StatelessWidget {
  final Review review;
  ReviewCard({
    @required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      //shadowColor: Theme.of(context).accentColor,
      elevation: 5,
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              review.reviewSrc.toEnumString() + " отзыв",
              style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            // leading: Icon(
            //   Icons.home,
            //   color: Theme.of(context).accentColor,
            // ),
            title: Text(review.author ?? "null"),
            subtitle: Text(
              review.date,
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
            trailing: Text(
              '${review.rating}/5',
              style: TextStyle(
                  color: review.rating <= 3 ? Colors.red : Colors.green),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.add_circle_outline,
              color: Colors.green,
              size: 30,
            ),
            title: Text(review.textPlus),
            subtitle: Text(
              'Достоинства',
              style: TextStyle(color: Colors.green.withOpacity(0.6)),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.remove_circle_outline,
              color: Colors.red,
              size: 30,
            ),
            title: Text(review.textMinus),
            subtitle: Text(
              'Недостатки',
              style: TextStyle(color: Colors.red.withOpacity(0.6)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              review.text,
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
          MoreInfo(
            review: review,
          )
        ],
      ),
    );
  }
}

class MoreInfo extends StatefulWidget {
  final Review review;
  MoreInfo({
    @required this.review,
  });

  String _getContent() {
    if (review.reviewSrc == ReviewSource.otzovik) {
      return review.url;
    } else {
      return "Веб-версия GoodBuy reviews пока не доступна";
    }
  }

  @override
  _MoreInfoState createState() => _MoreInfoState(_getContent());
}

class _MoreInfoState extends State<MoreInfo> {
  final String content;

  _MoreInfoState(this.content);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(title: Text('Больше информации'), children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(bottom: 18.0),
        //child: Text(content),
        child: TextButton(
          child: Text(content),
          onPressed: () {
            _launchURL(content);
          },
        ),
      ),
    ]);
  }

  _launchURL(String url) async {
    //const url = 'https://flutter.io';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
