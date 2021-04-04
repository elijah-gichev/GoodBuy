import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

main() async {
  final response =
    await http.Client().get(Uri.parse('https://otzovik.com/reviews/brinza_serbskaya_serbskiy_dom/'));
    if (response.statusCode == 200) {
      var document = parse(response.body);
      var name = document.querySelector('[itemprop="name"]').innerHtml; // Название товара

      var img = document.querySelector(".productHeaderContent img").attributes["src"];

      var rating = document.querySelector('[itemprop="ratingValue"]').innerHtml; // Рейтинг товара

      var ratingCount = document.querySelector('[itemprop="reviewCount"]').innerHtml; // Количество отзывов

      var likes = document.querySelector('.RecommendRating-like span').innerHtml; // Лайки

      var dislikes = document.querySelector('.RecommendRating-dislike span').innerHtml; // Дизайки

      var description = document.querySelectorAll('[itemprop="description"] div'); // Парсим все описание
      var category = description[0].getElementsByTagName("a")[0].innerHtml; // Категория
      var brand = description[1].getElementsByTagName("a")[0].innerHtml; // Бренд
      var type = description[2].getElementsByTagName("a")[0].innerHtml; // Тип

      var reviews = document.querySelector(".list-comments"); // Парсим лист отзывов
      var reviewsArray = []; // Массив отзывов
      reviews.children.forEach((review) {
        var stars = review.querySelectorAll(".starsRating .star .on").length; // Сколько звезд поставил автор отзыва

        var author = review.querySelector(".authorName a").innerHtml; // Ник автора отзыва

        var authorImage = review.querySelector(".authorPhoto img").attributes["data-original"]; // Аватарка автора отзыва

        var date = review.querySelector(".created").innerHtml; // Дата написания отзыва

        var title = review.querySelector(".reviewTitle a").innerHtml; // Заголовок отзыва

        var textElem = review.querySelector(".reviewTextSnippet"); // Парсим данные отзыва
        textElem.querySelectorAll("div, a").forEach((element) {element.remove();}); // Удаляем лишние элементы
        var text = textElem.innerHtml; // Забираем текст отзыва
        text = text.replaceAll("&nbsp;", ""); // Из текста выпиливаем html entity "неразрывный пробел"
        text = text.split(" ").where((element) => element != "").skip(2).join(" "); // Убираем пробелы и пустую строку
        // Получаем текст отзыва

        var imagesElems = review.querySelectorAll(".review-previews-imgs-items a img"); // Забираем все картинки
        var images = []; // Массив для сбора ссылок на картинки отзыва
        imagesElems.forEach((element) {images.add(element.attributes["data-original"]);}); // Записываем ссылки на картинки из отзыва

        var reviewObj = { // Все данные собираем в объект
          "author": author,
          "stars": stars,
          "authorImage": authorImage,
          "date": date,
          "title": title,
          "text": text,
          "images": images
        };

        reviewsArray.add(reviewObj); // Заполняем массив отзывов объектами
      });

      var productInfo = { // Собираем всю спарсенную информацию
        "name": name,
        "img": img,
        "rating": rating,
        "ratingCount": ratingCount,
        "likes": likes,
        "dislikes": dislikes,
        "category": category,
        "brand": brand,
        "type": type,
        "reviews": reviewsArray
      };

      print(productInfo); // Ну и посмотрим что там :)
    } else {
      throw Exception(); // Не подключились по ссылке - дропнули ошибку
    }
}