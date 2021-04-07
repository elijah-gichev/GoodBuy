import 'dart:convert';
import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart';

import '../models/product_model.dart';

class Repository {
  final String qr = "40409801";

  final LinkProvider linkProvider = LinkProvider();

  final ProductReviewsProvider productReviewsProvider =
      ProductReviewsProvider();

  Future<dynamic> getAllDataThatMeetsRequirements() async {
    final FetchedLink linkInfo =
        await linkProvider.readData(qr); //получили с бд ссылку на товары

    FullProductInfo reviewsInfo;
    try {
      reviewsInfo = await productReviewsProvider.readData(linkInfo.link);
    } catch (ec) {
      print("Exception in productReviewsProvider");
    }

    //print("linkInfo.link: ${linkInfo.link}");
    //print("reviewsInfo.name: ${reviewsInfo['name']}");
    print("reviewsInfo.title");
    return reviewsInfo;
  }
}

class LinkProvider {
  Future<FetchedLink> readData(String qr) async {
    final response = await http.Client()
        .get('https://goodbuyapi2.azurewebsites.net/Entries/Details/$qr');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      // print(data['id'].toString());
      // print(data['name'] is String);
      // print(data['link'] is String);
      // print(data['createdDate'] is String);
      return FetchedLink(
          id: data['id'].toString(),
          name: data['name'],
          link: data['link'],
          createdDate: data['createdDate']);
    } else {
      throw Exception('error fetching posts');
    }
  }
}

class ProductReviewsProvider {
  Future<FullProductInfo> readData(String url) async {
    final response = await http.Client().get(Uri.parse(url));
    //final response = await http.Client().get(url);
    //
    //Uri.parse(url)

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

      /*
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

      */

      return FullProductInfo(
          title: name,
          urlProductImg: img,
          generalRating: rating,
          countRating: ratingCount);
      //reviews: reviewsList);
    } else {
      print("parse exception");
      throw Exception(); // Не подключились по ссылке - дропнули ошибку

    }
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
      this.reviews});
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
