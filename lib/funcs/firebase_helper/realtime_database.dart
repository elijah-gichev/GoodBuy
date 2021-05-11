import 'package:firebase_database/firebase_database.dart';
import '../../models/full_product_info.dart';

void addReview(String qr, Review review) {
  DatabaseReference ref = FirebaseDatabase.instance.reference().child(qr);

  // Review nRev = Review(
  //     author: "Elijah Gichev",
  //     rating: 5,
  //     date: "there must be date",
  //     title: "Everything is Not OK",
  //     textPlus: "there must be textPlus",
  //     textMinus: "there must be textMinus",
  //     text: "lorem ipsum bsdhdjgjsgdsvsdjvg");
  // print("fbReview: $review");

  ref.push().set(review.toJson());
}

Future<List<Review>> getReviews(String qr) async {
  DatabaseReference ref = FirebaseDatabase.instance.reference().child(qr);

  Map<dynamic, dynamic> rawReviews = (await ref.once()).value;

  if (rawReviews == null) {
    throw NotFoundException();
  } else {
    List<Review> reviews = [];
    rawReviews.forEach((key, value) {
      Map<dynamic, dynamic> review = value;
      Review nRev = Review(
        author: review['author'],
        rating: review['rating'],
        date: "there must be date",
        title: review['title'],
        textPlus: "there must be textPlus",
        textMinus: "there must be textMinus",
        text: review['text'],
      );
      reviews.add(nRev);
    });
    return reviews;
  }
}

class NotFoundException implements Exception {
  String errMsg() => 'product not found in the DB';
}
