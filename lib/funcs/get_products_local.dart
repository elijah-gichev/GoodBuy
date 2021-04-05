import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Future<Object> getProductsLocal() async{
  final prefs = await SharedPreferences.getInstance();

  final historyItems = prefs.getString('history_items') ?? '[]';

  var historyItemsArr = jsonDecode(historyItems);

  return historyItemsArr;
}