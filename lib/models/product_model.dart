import 'package:meta/meta.dart';

class Product {
  final String title;
  final double stars;
  final String imgUrl;
  final int reviews;
  final String qr;
  bool isFavourite = false;

  Product(
      {@required this.title,
      @required this.stars,
      @required this.imgUrl,
      @required this.reviews,
      @required this.qr,
      this.isFavourite});
}
