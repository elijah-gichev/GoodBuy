import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Future<Object> getDataLocalByQr(String qr) async{
  if (qr == "") return {};
  final prefs = await SharedPreferences.getInstance();

  final historyItems = prefs.getString('history_items') ?? '[]';

  var historyItemsArr = jsonDecode(historyItems);

  var findData = {};
  historyItemsArr.forEach( (element) => {
    if (element["qr"] == qr) {
      findData = element
    }
  });

  return findData;
}