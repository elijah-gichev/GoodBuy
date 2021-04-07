import 'package:meta/meta.dart';

class FullProductInfo {
  final String title;
  final String urlProductImg;
  final double generalRating;
  final int countRating;
  //final List<dynamic> specs
  final List<Review> reviews;

  FullProductInfo(
      {@required this.title,
      @required this.urlProductImg,
      @required this.generalRating,
      @required this.countRating,
      @required this.reviews});
}

class Review {
  final String author;
  final int rating;
  final String urlAuthorImg;
  final String date;
  final String title;
  final String textPlus;
  final String textMinus;
  final String text;

  Review(
      {@required this.author,
      @required this.rating,
      @required this.urlAuthorImg,
      @required this.date,
      @required this.title,
      @required this.textPlus,
      @required this.textMinus,
      @required this.text});
}
