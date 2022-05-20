import 'package:untitled/core/Secret.dart';

import '../models/News.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsFeedService {
  NewsFeedService._();

  static Future<List<News>?> getNewsFeed() async {
    try {
      var response = await http.get(
          Uri.parse('https://newsapi.org/v2/everything?q=bitcoin&page=2&pageSize=50&apiKey=${Secret.newsApiKey}'));
      String status = jsonDecode(response.body)["status"];
      if (status == "error") {
        String code = jsonDecode(response.body)["code"];
        String message = jsonDecode(response.body)["message"];
        print(status);
        print(code);
        print(message);
      } else {
        List<dynamic> raw = jsonDecode(response.body)["articles"];
        return raw.map((e) => News.fromJSON(e)).toList();
      }
    } catch (ex) {
      print(ex);
    }
  }
}
