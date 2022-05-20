import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../core/AppTheme.dart';
import '../managers/HomeManager.dart';

class newsFeed extends StatelessWidget {
  const newsFeed({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeManager>(builder: (context, homeManager, child) {
      return SmartRefresher(
        controller: homeManager.refreshController,
        enablePullUp: true,
        onRefresh: homeManager.onRefresh,
        onLoading: homeManager.onLoading,
        child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: homeManager.newsBasket.length,
            itemBuilder: (context, index) {
              final n = homeManager.newsBasket[index];
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
                        homeManager.newsBasket[index].title,
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
                                    text: homeManager.newsBasket[index].sourceName,
                                    style: AppTheme.caption2,
                                  ),
                                ]),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 2.h),
                              child: RichText(
                                text: TextSpan(
                                    text: "Published At ",
                                    style: AppTheme.caption,
                                    children: [
                                      TextSpan(
                                        text: homeManager.newsBasket[index].publishedAt,
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
                    homeManager.newsBasket[index].urlToImage != "unknown"
                        ? CachedNetworkImage(
                      fit: BoxFit.contain,
                      imageUrl: homeManager.newsBasket[index].urlToImage,
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
                    homeManager.newsBasket[index].content != "unknown"
                        ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                      child: Text(
                        homeManager.newsBasket[index].content,
                        style: AppTheme.body2,
                      ),
                    )
                        : const SizedBox(),
                  ],
                ),
              );
            }),
      );
    });
  }
}