import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveDataLocal(String title, double stars, String img, int reviews, String qr) async{
  if (title == "" || stars < 0 || img == "" || reviews < 0 || qr == "") return;

  final prefs = await SharedPreferences.getInstance();

  final historyItems = prefs.getString('history_items') ?? '[]';
  // set value
  // prefs.setInt('counter', counter);

  var historyItemsArr = jsonDecode(historyItems);

  historyItemsArr.add({
    "title": title,
    "stars": stars,
    "img": img,
    "reviews": reviews,
    "qr": qr
  });

  prefs.setString('history_items', jsonEncode(historyItemsArr));
}