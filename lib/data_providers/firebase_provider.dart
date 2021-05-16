import '../models/full_product_info.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseReviewsProvider {
  Future<List<Review>> readData(String qr) async {
    DatabaseReference ref = FirebaseDatabase.instance.reference().child(qr);

    Map<dynamic, dynamic> rawReviews = (await ref.once()).value;

    if (rawReviews == null) {
      return [];
    }

    List<Review> reviews = [];
    rawReviews.forEach((key, value) {
      Map<dynamic, dynamic> review = value;
      Review nRev = Review(
        url: "Firebase",
        reviewSrc: ReviewSource.goodBuy,
        author: review['author'] ?? "null",
        rating: review['rating'] ?? 0,
        date: review['date'] ?? "null",
        title: review['title'] ?? "null",
        textPlus: review['textPlus'] ?? "null",
        textMinus: review['textMinus'] ?? "null",
        text: review['text'] ?? "null",
      );
      reviews.add(nRev);
    });
    return reviews;
  }
}
