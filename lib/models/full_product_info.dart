import 'package:meta/meta.dart';

class FullProductInfo {
  final String title;
  final String urlProductImg;
  final double generalRating;
  final int countRating;
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
  final String date;
  final String title;
  final String textPlus;
  final String textMinus;
  final String text;

  Review(
      {@required this.author,
      @required this.rating,
      @required this.date,
      @required this.title,
      @required this.textPlus,
      @required this.textMinus,
      @required this.text});

  Review.fromJson(Map<String, dynamic> json)
      : author = json['author'],
        rating = json['rating'],
        date = json['date'],
        title = json['title'],
        textPlus = json['textPlus'],
        textMinus = json['textMinus'],
        text = json['text'];

  Map<String, dynamic> toJson() => {
        'author': author,
        'rating': rating,
        'date': date,
        'title': title,
        'textPlus': textPlus,
        'textMinus': textMinus,
        'text': text,
      };

  @override
  String toString() {
    String out = "";

    out += "'author': $author \n";
    out += "'rating': $rating \n";
    out += "'date': $date \n";
    out += "'title': $title \n";
    out += "'textPlus': $textPlus \n";
    out += "'textMinus': $textMinus \n";
    out += "'text': $text \n";
    return out;
  }
}
