import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> setFavouriteFlagByQr(String qr, bool value) async{
  if (qr == "") return;
  final prefs = await SharedPreferences.getInstance();

  final historyItems = prefs.getString('history_items') ?? '[]';

  var historyItemsArr = jsonDecode(historyItems);

  var i = 0;
  var findI = -1;
  historyItemsArr.forEach( (element) => {
    if (element["qr"] == qr) {
      findI = i
    } else {
      i++
    }
  });

  if (findI != -1) {
    historyItemsArr[findI]["isFavourite"] = value;
    prefs.setString('history_items', jsonEncode(historyItemsArr));
  }
}