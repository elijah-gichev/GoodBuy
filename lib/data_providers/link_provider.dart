import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/fetched_link.dart';

class LinkProvider {
  Future<FetchedLink> readData(String qr) async {
    final response = await http.Client()
        .get('https://goodbuyapi2.azurewebsites.net/Entries/Details/$qr');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return FetchedLink(
          id: data['id'].toString(),
          name: data['name'],
          link: data['link'],
          createdDate: data['createdDate']);
    } else {
      print(response.statusCode);
      throw LinkNotFoundException();
    }
  }
}

class LinkNotFoundException implements Exception {
  String errMsg() => 'link not found in the DB';
}
