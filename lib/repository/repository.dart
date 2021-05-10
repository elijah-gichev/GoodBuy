import 'dart:convert';
import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart';

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
      reviewsInfo = await productReviewsProvider.emulateReadData();

      saveProductLocal(reviewsInfo.title, reviewsInfo.generalRating,
          reviewsInfo.urlProductImg, reviewsInfo.countRating, qr);
    } catch (ec) {
      print("Exception in productReviewsProvider");
    }

    //print(reviewsInfo.countRating);
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
    //_reloadTimestamp();  !!!!!!!!!!!!!!!!!!!
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

      /*
      var specsElem = document.querySelectorAll(
          '.product-rating-details .rating-item'); // Все характеристики
      var specs = []; // Массив характеристик
      specsElem.forEach((element) {
        // Перебираем все характеристики
        var arr = element.attributes["title"].split(
            " "); // Разбиваем тайтл, чтобы достать оценку и название характеристики
        var name = arr[0].replaceAll(
            ":", ""); // Забираем название характеристики и убираем двоеточие
        specs.add({
          // Зависываем в массив характеристику
          "name": name,
          "rate": arr[1]
        });
      });
      */

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
              author: author,
              rating: stars,
              urlAuthorImg: authorImage,
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

  Future<FullProductInfo> emulateReadData() async {
    FullProductInfo res;

    List<Review> reviewsList = [
      Review(
          author: "Anton",
          rating: 5,
          urlAuthorImg: "url img",
          date: "now1",
          title: "all OK",
          textPlus: "all OK",
          textMinus: "all bad",
          text: "lorum 1"),
      Review(
          author: "Evgen",
          rating: 2,
          urlAuthorImg: "url img2",
          date: "now12",
          title: "all OK2",
          textPlus: "all OK2",
          textMinus: "all bad2",
          text: "lorum 12"),
      Review(
          author: "Alex",
          rating: 4,
          urlAuthorImg: "alex img",
          date: "now123",
          title: "all OK23",
          textPlus: "all OK23",
          textMinus: "all bad23",
          text: "lorum 1233333"),
      Review(
          author: "Elijah",
          rating: 1,
          urlAuthorImg: "elijah img",
          date: "now1233",
          title: "all OK23323",
          textPlus: "all OK2323asas",
          textMinus: "all bad2sas",
          text: "lorum 12sasasas"),
    ];
    await Future.delayed(Duration(milliseconds: 500), () {
      res = FullProductInfo(
          title: "emulate name; qr",
          urlProductImg: "emulate img",
          generalRating: 1,
          countRating: 666,
          reviews: reviewsList);
    });

    return res;
  }
}

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
