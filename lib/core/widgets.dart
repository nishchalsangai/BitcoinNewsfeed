import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'AppTheme.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({
    Key? key,
    required this.title,
    required this.sourceName,
    required this.publishedAt,
    required this.imgurl,
    required this.summary,
    required this.addOrRemove,
    required this.iconSwitch,
  }) : super(key: key);
  final String title;
  final String sourceName;
  final String publishedAt;
  final String imgurl;
  final String summary;
  final dynamic addOrRemove;
  final bool iconSwitch;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 13.h),
      decoration: AppTheme.inputContainer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
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
                          text: sourceName,
                          style: AppTheme.caption2,
                        ),
                      ]),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 2.h),
                    child: RichText(
                      text: TextSpan(text: "Published At ", style: AppTheme.caption, children: [
                        TextSpan(
                          text: publishedAt,
                          style: AppTheme.caption2,
                        )
                      ]),
                    ),
                  ),
                ],
              ),
              IconButton(
                  onPressed: addOrRemove,
                  icon: iconSwitch
                      ? const Icon(Icons.bookmark)
                      : const Icon(Icons.bookmark_add_outlined))
            ],
          ),
          SizedBox(
            height: 8.h,
          ),
          imgurl != "unknown"
              ? CachedNetworkImage(
                  fit: BoxFit.contain,
                  imageUrl: imgurl,
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
          summary != "unknown"
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                  child: Text(
                    summary,
                    style: AppTheme.body2,
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
