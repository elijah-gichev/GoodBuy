import '../models/full_product_info.dart';
import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  final Review review;
  ReviewCard({
    @required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            //leading: Icon(Icons.arrow_drop_down_circle),
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              review.text,
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
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
        ],
      ),
    );
  }
}
