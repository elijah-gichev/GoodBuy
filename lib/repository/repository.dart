import 'dart:convert';
import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'package:firebase_database/firebase_database.dart';

import '../models/full_product_info.dart';
import '../funcs/pref_helper/save_product_local.dart';

class Repository {
  final LinkProvider linkProvider = LinkProvider();

  final ProductReviewsProvider productReviewsProvider =
      ProductReviewsProvider();

  Future<FullProductInfo> getAllDataThatMeetsRequirements(String qr) async {
    //final FetchedLink linkInfo =
    //    await linkProvider.readData(qr); //получили с бд ссылку на товары

    FullProductInfo reviewsInfo;
    try {
      //reviewsInfo = await productReviewsProvider.readData(linkInfo.link);
      reviewsInfo = await productReviewsProvider.emulateReadData(qr);

      saveProductLocal(reviewsInfo.title, reviewsInfo.generalRating,
          reviewsInfo.urlProductImg, reviewsInfo.countRating, qr);
    } catch (ec) {
      print("Exception in productReviewsProvider");
    }

    return reviewsInfo;
  }
}

class NotFoundException implements Exception {
  String errMsg() => 'product not found in the DB';
}

class LinkProvider {
  Future<FetchedLink> readData(String qr) async {
    final response = await http.Client()
        .get('https://goodbuyapi2.azurewebsites.net/Entries/Details/$qr');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return FetchedLink(
          id: data['id'].toString(),
          name: data['name'],
          link: data['link'],
          createdDate: data['createdDate']);
    } else {
      print(response.statusCode);
      throw NotFoundException();
    }
  }
}

class SomethingWrongWithOtzovikException implements Exception {
  String errMsg() => 'Something Wrong With Otzovik';
}

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

      var img = document
          .querySelector('.product-photo [itemprop="image"]')
          .attributes["src"];

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

          var authorImage = review
              .querySelector(".avatar img")
              .attributes["data-original"]; // Аватарка автора отзыва

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
              reviewSrc: ReviewSource.goodBuy,
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
          urlProductImg: img,
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
          reviewSrc: ReviewSource.otzovik,
          author: "Anton",
          rating: 5,
          date: "now1",
          title: "all OK",
          textPlus: "all OK",
          textMinus: "all bad",
          text: "lorum 1"),
      Review(
          reviewSrc: ReviewSource.otzovik,
          author: "Evgen",
          rating: 2,
          date: "now12",
          title: "all OK2",
          textPlus: "all OK2",
          textMinus: "all bad2",
          text: "lorum 12"),
      Review(
          reviewSrc: ReviewSource.otzovik,
          author: "Alex",
          rating: 4,
          date: "now123",
          title: "all OK23",
          textPlus: "all OK23",
          textMinus: "all bad23",
          text: "lorum 1233333"),
      Review(
          reviewSrc: ReviewSource.otzovik,
          author: "Elijah",
          rating: 1,
          date: "now1233",
          title: "all OK23323",
          textPlus: "all OK2323asas",
          textMinus: "all bad2sas",
          text: "lorum 12sasasas"),
    ];

    reviewsList.addAll(await FirebaseReviewsProvider.readData(
        qr)); //добавление отзывов из фаербейс

    await Future.delayed(Duration(milliseconds: 500), () {
      res = FullProductInfo(
          title: "emulate name; qr",
          urlProductImg: "There must be url img",
          generalRating: 1,
          countRating: 666,
          reviews: reviewsList);
    });

    return res;
  }
}

class FirebaseReviewsProvider {
  static Future<List<Review>> readData(String qr) async {
    DatabaseReference ref = FirebaseDatabase.instance.reference().child(qr);

    Map<dynamic, dynamic> rawReviews = (await ref.once()).value;

    // if (rawReviews == null) {
    //   throw NotFoundException();
    // } else {
    //   List<Review> reviews = [];
    //   rawReviews.forEach((key, value) {
    //     Map<dynamic, dynamic> review = value;
    //     Review nRev = Review(
    //       reviewSrc: ReviewSource.goodBuy,
    //       author: review['author'],
    //       rating: review['rating'],
    //       date: "there must be date",
    //       title: review['title'],
    //       textPlus: "there must be textPlus",
    //       textMinus: "there must be textMinus",
    //       text: review['text'],
    //     );
    //     reviews.add(nRev);
    //   });
    //   return reviews;
    // }
    if (rawReviews == null) {
      return [];
    }

    List<Review> reviews = [];
    rawReviews.forEach((key, value) {
      Map<dynamic, dynamic> review = value;
      Review nRev = Review(
        reviewSrc: ReviewSource.goodBuy,
        author: review['author'],
        rating: review['rating'],
        date: review['date'],
        title: review['title'],
        textPlus: review['textPlus'],
        textMinus: review['textMinus'],
        text: review['text'],
      );
      reviews.add(nRev);
    });
    return reviews;
  }
}

// class NotFoundException implements Exception {
//   String errMsg() => 'product not found in the DB';
// }

class FetchedLink {
  final String id;
  final String name;
  final String link;
  final String createdDate;

  FetchedLink(
      {@required this.id,
      @required this.name,
      @required this.link,
      @required this.createdDate});
}
