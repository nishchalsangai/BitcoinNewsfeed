import 'dart:async';

import 'package:untitled/core/Secret.dart';

import '../models/News.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsFeedService {
  late Map _error;
  late StreamController<News> _newsBucket = StreamController();

  NewsFeedService() {
    _error = {};
  }

  Stream<News> get newsBucketStream => _newsBucket.stream;

  Future<bool> getNewsFeed({int currentPage = 1}) async {
    try {
      var response = await http.get(Uri.parse(
          'https://newsapi.org/v2/everything?q=bitcoin&page=$currentPage&pageSize=6&apiKey=${Secret.newsApiKey}'));
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)["status"];
        if (status == "error") {
          _error = jsonDecode(response.body);
          print(_error);
          return false;
        } else {
          List<dynamic> raw = jsonDecode(response.body)["articles"];
          raw.map((e) {
            _newsBucket.add(News.fromJSON(e));
          }).toList();
          return true;
        }
      } else {
        _error = jsonDecode(response.body);
        return false;
      }
    } catch (ex) {
      print(ex);
      return false;
    }
  }
}
