import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Future<Object> getFavouritesProductsLocal() async{
  final prefs = await SharedPreferences.getInstance();

  final historyItems = prefs.getString('history_items') ?? '[]';

  var historyItemsArr = jsonDecode(historyItems);

  var findData = [];
  historyItemsArr.forEach( (element) => {
    if (element["isFavourite"] != null && element["isFavourite"]) {
      findData.add(element)
    }
  });

  return findData;
}