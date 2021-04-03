import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

main() async {
  final response =
    await http.Client().get(Uri.parse('https://irecommend.ru/content/karamel-bayan-sulu-bs-fruitumelchennoi-formy-foto'));
    if (response.statusCode == 200) {
      var document = parse(response.body);
      var name = document.querySelector('[itemprop="name"]').innerHtml; // Название товара
      print("Название товара:");
      print(name);
      var rating = document.querySelector('[itemprop="ratingValue"]').innerHtml; // Рейтинг товара
      print("Рейтинг товара:");
      print(rating);
      var ratingCount = document.querySelector('[itemprop="reviewCount"]').innerHtml; // Количество отзывов
      print("Количество отзывов:");
      print(ratingCount);
      var likes = document.querySelector('.RecommendRating-like span').innerHtml; // Лайки
      print("Лайки:");
      print(likes);
      var dislikes = document.querySelector('.RecommendRating-dislike span').innerHtml; // Лайки
      print("Дизлайки:");
      print(dislikes);
      var description = document.querySelectorAll('[itemprop="description"] div');
      var category = description[0].getElementsByTagName("a")[0].innerHtml;
      var brand = description[1].getElementsByTagName("a")[0].innerHtml;
      var type = description[2].getElementsByTagName("a")[0].innerHtml;
      print("Категория:");
      print(category);
      print("Бренд:");
      print(brand);
      print("Тип:");
      print(type);
    } else {
      throw Exception();
    }
}