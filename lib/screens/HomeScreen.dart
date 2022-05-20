import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/services/NewsFeedService.dart';

import '../models/News.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: NewsFeedService.getNewsFeed(),
        builder: (context, snapshot) {
          dynamic news = snapshot.data;

          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return Center(child: Text('Some error occurred!'));
              } else {
                print(news);
                return buildNews(news);
              }
          }
        },
      ),
    );
  }

  Widget buildNews(List<News> news) {
    return ListView.builder(
         itemCount: news.length,
        itemBuilder: (context, index) {
      final n = news[index];
      return Text(n.title);
    });
  }
}
