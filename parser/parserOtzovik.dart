import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

main() async {
  final response =
    await http.Client().get(Uri.parse('https://otzovik.com/reviews/brinza_serbskaya_serbskiy_dom/'));
    if (response.statusCode == 200) {
      var document = parse(response.body);
      var name = document.querySelector('.product-name [itemprop="name"]').innerHtml; // Название товара

      var img = document.querySelector('.product-photo [itemprop="image"]').attributes["src"];

      var rating = document.querySelector('.recommend-ratio span').innerHtml; // Рейтинг товара

      var ratingCount = document.querySelector('.reviews-counter .votes').innerHtml; // Количество отзывов

      var specsElem = document.querySelectorAll('.product-rating-details .rating-item');
      var specs = [];
      specsElem.forEach((element) {
        var arr = element.attributes["title"].split(" ");
        var name = arr[0].replaceAll(":", "");
        specs.add({
          "name": name,
          "rate": arr[1]
        });
      });

      var reviews = document.querySelector(".otz_product_reviews_left .review-list-2"); // Парсим лист отзывов
      var reviewsArray = []; // Массив отзывов
      reviews.children.forEach((review) {
        if (review.attributes["class"] != "otz_panel_inpage") {
          var stars = review.querySelectorAll(".icon-star-1").length; // Сколько звезд поставил автор отзыва

          var author = review.querySelector('.user-login span').innerHtml; // Ник автора отзыва
          
          var authorImage = review.querySelector(".avatar img").attributes["data-original"]; // Аватарка автора отзыва

          var date = review.querySelector(".review-postdate span").innerHtml; // Дата написания отзыва

          var title = review.querySelector(".review-title").innerHtml; // Заголовок отзыва

          var textPlus = review.querySelector(".review-plus").innerHtml;

          var textMinus = review.querySelector(".review-minus").innerHtml;

          var text = review.querySelector(".review-teaser").innerHtml; // Парсим данные отзыва

          var reviewObj = { // Все данные собираем в объект
            "author": author,
            "stars": stars,
            "authorImage": authorImage,
            "date": date,
            "title": title,
            "textPlus": textPlus,
            "textMinus": textMinus,
            "text": text
          };

          reviewsArray.add(reviewObj); // Заполняем массив отзывов объектами
        }
      });

      var productInfo = { // Собираем всю спарсенную информацию
        "name": name,
        "img": img,
        "rating": rating,
        "ratingCount": ratingCount,
        "specs": specs,
        "reviews": reviewsArray
      };

      print(productInfo); // Ну и посмотрим что там :)
    } else {
      throw Exception(); // Не подключились по ссылке - дропнули ошибку
    }
}