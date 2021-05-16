import 'package:flutter/material.dart';

class HistoryCard extends StatelessWidget {
  final String title;
  final double stars;
  final String imgUrl;
  final int reviews;
  final String qr; //TODO extended info

  HistoryCard(this.title, this.stars, this.imgUrl, this.reviews, this.qr);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            //leading: Icon(Icons.arrow_drop_down_circle),
            title: Text(title ?? "null"),
            subtitle: Text(
              qr ?? "qr",
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
            trailing: Text(
              '${stars.toStringAsFixed(2)}/5',
              style: TextStyle(color: stars <= 3 ? Colors.red : Colors.green),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Оценка состоит из $reviews отзывов",
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
        ],
      ),
    );
  }
}
