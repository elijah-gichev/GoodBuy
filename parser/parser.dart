import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

main() async {
  final response =
    await http.Client().get(Uri.parse('https://irecommend.ru/content/karamel-bayan-sulu-bs-fruitumelchennoi-formy-foto'));
    if (response.statusCode == 200) {
      var document = parse(response.body);
      var name = document.querySelector('[itemprop="name"]').innerHtml; // Название товара
      print("Название товара: " + name.toString());
      var img = document.querySelector(".productHeaderContent img").attributes["src"];
      print("Ссылка на изображение: " + img.toString());
      var rating = document.querySelector('[itemprop="ratingValue"]').innerHtml; // Рейтинг товара
      print("Рейтинг товара: " + rating.toString());
      var ratingCount = document.querySelector('[itemprop="reviewCount"]').innerHtml; // Количество отзывов
      print("Количество отзывов: " + ratingCount.toString());
      var likes = document.querySelector('.RecommendRating-like span').innerHtml; // Лайки
      print("Лайки: " + likes.toString());
      var dislikes = document.querySelector('.RecommendRating-dislike span').innerHtml; // Дизайки
      print("Дизлайки: " + dislikes.toString());
      var description = document.querySelectorAll('[itemprop="description"] div');
      var category = description[0].getElementsByTagName("a")[0].innerHtml;
      var brand = description[1].getElementsByTagName("a")[0].innerHtml;
      var type = description[2].getElementsByTagName("a")[0].innerHtml;
      print("Категория: " + category.toString());
      print("Бренд: " + brand.toString());
      print("Тип: " + type.toString());
      print("");

      var reviews = document.querySelector(".list-comments");
      var n = 0;
      var reviewsArray = []; // Массив отзывов
      reviews.children.forEach((review) {
        var obj = {};
        n++;
        print("Отзыв #" + n.toString());

        var stars = review.querySelectorAll(".starsRating .star .on").length;
        print("Количество звезд: " + stars.toString());
        obj["stars"] = stars;

        var author = review.querySelector(".authorName a").innerHtml;
        print("Автор: " + author.toString());
        obj["author"] = author;

        var authorImage = review.querySelector(".authorPhoto img").attributes["data-original"];
        print("Аватарка автора: " + authorImage.toString());
        obj["authorImage"] = authorImage;

        var date = review.querySelector(".created").innerHtml;
        print("Дата отзыва: " + date.toString());
        obj["date"] = date;

        var title = review.querySelector(".reviewTitle a").innerHtml;
        print("Заголовок отзыва: " + title.toString());
        obj["title"] = title;

        var textElem = review.querySelector(".reviewTextSnippet");
        textElem.querySelectorAll("div, a").forEach((element) {element.remove();});
        var text = textElem.innerHtml;
        text = text.replaceAll("&nbsp;", "");
        text = text.split(" ").where((element) => element != "").skip(2).join(" ");
        print("Текст отзыва: " + text.toString());
        obj["text"] = text;

        var imagesElems = review.querySelectorAll(".review-previews-imgs-items a img");
        var images = [];
        imagesElems.forEach((element) {images.add(element.attributes["data-original"]);});
        print("Ссылки на фотографии из отзыва: ");
        images.forEach((element) {print(element);});
        obj["images"] = images;
        print("");

        reviewsArray.add(obj);
      });
      print(reviewsArray);

      var productInfo = {
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

      print(productInfo);
    } else {
      throw Exception();
    }
}