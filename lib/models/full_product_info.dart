import 'package:meta/meta.dart';

class FullProductInfo {
  final String title;
  double generalRating;
  int countRating;
  final List<Review> reviews;

  FullProductInfo(
      {@required this.title,
      @required this.generalRating,
      @required this.countRating,
      @required this.reviews});
}

enum ReviewSource {
  otzovik,
  goodBuy,
}

extension ParseToString on ReviewSource {
  String toEnumString() {
    return this.toString().split('.').last;
  }
}

class Review {
  final String url;
  final ReviewSource reviewSrc;
  final String author;
  final int rating;
  final String date;
  final String title;
  final String textPlus;
  final String textMinus;
  final String text;

  Review(
      {@required this.url,
      @required this.reviewSrc,
      @required this.author,
      @required this.rating,
      @required this.date,
      @required this.title,
      @required this.textPlus,
      @required this.textMinus,
      @required this.text});

  Review.fromJson(Map<String, dynamic> json)
      : url = json['url'],
        reviewSrc = json['reviewSrc'],
        author = json['author'],
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
    out += "'reviewSrc': ${reviewSrc.toEnumString()} \n";
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
