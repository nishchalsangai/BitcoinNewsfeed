import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../core/widgets.dart';
import '../managers/HomeManager.dart';
import '../models/News.dart';

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeManager>(builder: (context, homeManager, child) {
      return SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: homeManager.bookmarkBucket.length,
                itemBuilder: (context, index) {
                  final bookmarkNews =
                      News.fromJSON(homeManager.bookmarkBucket[index].news as Map<String, dynamic>);
                  return NewsCard(
                    title: bookmarkNews.title,
                    sourceName: bookmarkNews.sourceName,
                    publishedAt: bookmarkNews.publishedAt,
                    imgurl: bookmarkNews.urlToImage,
                    summary: bookmarkNews.content,
                    addOrRemove: () => homeManager.addAndRemoveBookmark(
                        bookmarkNews, homeManager.bookmarkBucket[index].bookMarksId),
                    iconSwitch: homeManager.checkBookmarkStatus(bookmarkNews),
                    onPressFlag: homeManager.bookmarkFlag,
                  );
                }),
            SizedBox(
              height: 30.h,
            ),
          ],
        ),
      );
    });
  }
}
