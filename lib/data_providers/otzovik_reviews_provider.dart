import '../models/full_product_info.dart';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart';

class ProductReviewsProvider {
  Future<FullProductInfo> readData(String url) async {
    final response = await http.Client().get(Uri.parse(url));

    print(response.statusCode);
    print(url);
    if (response.statusCode == 200) {
      var document = parse(response.body);
      var name = document
          .querySelector('.product-name [itemprop="name"]')
          .innerHtml; // Название товара

      // var img = document
      //     .querySelector('.product-photo [itemprop="image"]')
      //     .attributes["src"];

      var rating = double.parse(document
          .querySelector('.product-rating')
          .attributes['title']
          .replaceAll("Общий рейтинг: ", ""));

      var ratingCount = int.parse(document
          .querySelector('.reviews-counter .votes')
          .innerHtml); // Количество отзывов

      var reviews = document.querySelector(
          ".otz_product_reviews_left .review-list-2"); // Парсим лист отзывов
      List<Review> reviewsList = []; // Массив отзывов
      reviews.children.forEach((review) {
        if (review.attributes["class"] != "otz_panel_inpage") {
          var stars = review
              .querySelectorAll(".icon-star-1")
              .length; // Сколько звезд поставил автор отзыва

          var author = review
              .querySelector('.user-login span')
              .innerHtml; // Ник автора отзыва

          // var authorImage = review
          //     .querySelector(".avatar img")
          //     .attributes["data-original"]; // Аватарка автора отзыва

          var date = review
              .querySelector(".review-postdate span")
              .innerHtml; // Дата написания отзыва

          var title = review
              .querySelector(".review-title")
              .innerHtml; // Заголовок отзыва

          var textPlus = review
              .querySelector(".review-plus")
              .innerHtml; // "Достоинства" продукта

          var textMinus = review
              .querySelector(".review-minus")
              .innerHtml; // "Недостатки продукта"

          var text = review
              .querySelector(".review-teaser")
              .innerHtml; // Парсим данные отзыва

          // Все данные собираем в объект
          Review reviewObj = Review(
              url: url,
              reviewSrc: ReviewSource.otzovik,
              author: author,
              rating: stars,
              date: date,
              title: title,
              textPlus: textPlus,
              textMinus: textMinus,
              text: text);

          reviewsList.add(reviewObj); // Заполняем массив отзывов объектами
        }
      });

      //List<Review> reviewsList = [];
      return FullProductInfo(
          title: name,
          generalRating: rating,
          countRating: ratingCount,
          reviews: reviewsList);
    } else {
      throw SomethingWrongWithOtzovikException(); // Не подключились по ссылке - дропнули ошибку
    }
  }

  Future<FullProductInfo> emulateReadData(String qr) async {
    FullProductInfo res;

    List<Review> reviewsList = [
      Review(
          url: "google.com",
          reviewSrc: ReviewSource.otzovik,
          author: "Anton",
          rating: 5,
          date: "now1",
          title: "all OK",
          textPlus: "all OK",
          textMinus: "all bad",
          text: "lorum 1"),
      Review(
          url: "google.com",
          reviewSrc: ReviewSource.otzovik,
          author: "Evgen",
          rating: 2,
          date: "now12",
          title: "all OK2",
          textPlus: "all OK2",
          textMinus: "all bad2",
          text: "lorum 12"),
      Review(
          url: "google.com",
          reviewSrc: ReviewSource.otzovik,
          author: "Alex",
          rating: 4,
          date: "now123",
          title: "all OK23",
          textPlus: "all OK23",
          textMinus: "all bad23",
          text: "lorum 1233333"),
      Review(
          url: "google.com",
          reviewSrc: ReviewSource.otzovik,
          author: "Elijah",
          rating: 1,
          date: "now1233",
          title: "all OK23323",
          textPlus: "all OK2323asas",
          textMinus: "all bad2sas",
          text: "lorum 12sasasas"),
    ];

    await Future.delayed(Duration(milliseconds: 500), () {
      res = FullProductInfo(
          title: "emulate name; qr",
          generalRating: 1,
          countRating: 666,
          reviews: reviewsList);
    });

    //return res;
    return FullProductInfo(
        title: "emulate name; qr",
        generalRating: 1,
        countRating: 666,
        reviews: []);
  }
}

class SomethingWrongWithOtzovikException implements Exception {
  String errMsg() => 'Something Wrong With Otzovik';
}
