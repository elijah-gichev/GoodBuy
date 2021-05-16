import 'package:firebase_database/firebase_database.dart';
import '../../models/full_product_info.dart';

void addReview(String qr, Review review) {
  DatabaseReference ref = FirebaseDatabase.instance.reference().child(qr);

  ref.push().set(review.toJson());
}
