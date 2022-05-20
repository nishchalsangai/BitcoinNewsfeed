import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../core/widgets.dart';
import '../managers/HomeManager.dart';

class newsFeed extends StatelessWidget {
  const newsFeed({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeManager>(builder: (context, homeManager, child) {
      return SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: homeManager.scrollControl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: homeManager.newsBasket.length,
                itemBuilder: (context, index) {
                  final n = homeManager.newsBasket[index];
                  return NewsCard(
                    title: homeManager.newsBasket[index].title,
                    sourceName: homeManager.newsBasket[index].sourceName,
                    publishedAt: homeManager.newsBasket[index].publishedAt,
                    imgurl: homeManager.newsBasket[index].urlToImage,
                    summary: homeManager.newsBasket[index].content,
                    addOrRemove: () =>
                        homeManager.addAndRemoveBookmark(homeManager.newsBasket[index], null),
                    iconSwitch: false,
                  );
                }),
            SizedBox(
              height: 30.h,
            ),
            homeManager.isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF075E54),
                      strokeWidth: 1,
                    ),
                  )
                : const SizedBox(),
            SizedBox(
              height: 30.h,
            ),
          ],
        ),
      );
    });
  }
}
