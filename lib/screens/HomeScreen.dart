import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/core/AppTheme.dart';
import 'package:untitled/services/NewsFeedService.dart';

import '../models/News.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
          print(news[index].urlToImage);
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 13.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: AppTheme.grey.withOpacity(0.2),
                  blurRadius: 16,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    news[index].title,
                    style: AppTheme.title,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 2.h),
                          child: RichText(
                            text: TextSpan(text: "Source ", style: AppTheme.caption, children: [
                              TextSpan(
                                text: news[index].sourceName,
                                style: AppTheme.caption2,
                              ),
                            ]),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 2.h),
                          child: RichText(
                            text:
                                TextSpan(text: "Published At ", style: AppTheme.caption, children: [
                              TextSpan(
                                text: news[index].publishedAt,
                                style: AppTheme.caption2,
                              )
                            ]),
                          ),
                        ),
                      ],
                    ),
                    IconButton(onPressed: () {}, icon: Icon(Icons.bookmark_add_outlined))
                  ],
                ),
                SizedBox(
                  height: 8.h,
                ),
                news[index].urlToImage != "unknown"
                    ? CachedNetworkImage(
                        fit: BoxFit.contain,
                        imageUrl: news[index].urlToImage,
                        width: MediaQuery.of(context).size.width,
                        progressIndicatorBuilder: (context, url, downloadProgress) => Center(
                            child: CircularProgressIndicator(
                          value: downloadProgress.progress,
                          strokeWidth: 1,
                        )),
                        errorWidget: (context, url, error) => const SizedBox(),
                      )
                    : const SizedBox(),
                SizedBox(
                  height: 8.h,
                ),
                news[index].content != "unknown"
                    ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                        child: Text(
                          news[index].content,
                          style: AppTheme.body2,
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          );
        });
  }
}
