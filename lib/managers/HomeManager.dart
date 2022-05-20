import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:untitled/models/Bookmarks.dart';
import 'package:untitled/services/BookMarksService.dart';
import 'package:untitled/services/NewsFeedService.dart';

import '../models/News.dart';

class HomeManager extends ChangeNotifier {
  late bool _isLoading;
  late int _currentPage;
  late NewsFeedService _newsFeedService;
  late BookMarksService _bookMarksService;
  late List<News> _newsBasket;
  late ScrollController _scrollControl;
  late StreamSubscription _newsStream;
  late bool newsAvailable;
  late List<Bookmarks> _bookmarksBucket;
  late List<News> _bookmarkedNew;
  late final userId;
  late List<bool> isSaved;

  HomeManager(this.userId) {
    isSaved = [];
    _isLoading = true;
    _newsFeedService = NewsFeedService();
    _bookMarksService = BookMarksService(userId);
    _currentPage = 0;
    _newsBasket = [];
    _bookmarksBucket = [];
    _bookmarkedNew = [];
    _scrollControl = ScrollController();
    _scrollControl.addListener(_scrollListener);
    onLoading();
    NewsBasket();
    updateBookmarkBucket();
  }

  _scrollListener() async {
    if (_scrollControl.offset >= _scrollControl.position.maxScrollExtent &&
        !_scrollControl.position.outOfRange) {
      Future.delayed(const Duration(seconds: 2)).then((value) {
        onLoading();
        toggleLoading();
      });
    }
  }

  NewsBasket() {
    _newsStream = _newsFeedService.newsBucketStream.listen((news) {
      isSaved.add(false);
      _newsBasket.add(news);
      notifyListeners();
    });
  }

  updateBookmarkBucket() async {
    _bookmarksBucket = await _bookMarksService.allBookmarks;
    _bookmarkedNew = [];
    for (var element in _bookmarksBucket) {
      _bookmarkedNew.add(News.fromJSON(element.news as Map<String, dynamic>));
    }
    notifyListeners();
  }

  checkBookmarkStatus(News news) {
    bool f;
    f = _bookmarkedNew.contains(news) ? true : false;
    print(f);
    return f;
  }

  onLoading() async {
    _currentPage++;
    final result = await _newsFeedService.getNewsFeed(currentPage: _currentPage);
    if (result) {
      notifyListeners();
    } else {}
  }

  toggleLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  addAndRemoveBookmark(News news, String? bookmarkId) async {
    if (checkBookmarkStatus(news)) {
      bookmarkId != null
          ? _bookMarksService.removeBookmark(bookmarkId).then((value) {
              updateBookmarkBucket();
              notifyListeners();
            })
          : _bookMarksService.removeBookmarksFromNewsFeed(news.toMap(news)).then((value) {
              updateBookmarkBucket();
              notifyListeners();
            });
    } else {
      final id = await _bookMarksService.generateNewBookmark();
      _bookMarksService
          .addBookmark(bookmarkId: id, userId: userId, news: news.toMap(news))
          .then((value) {
        updateBookmarkBucket();
      });
    }
  }

  List<News> get newsBasket {
    return _newsBasket;
  }

  bool get isLoading {
    return _isLoading;
  }

  ScrollController get scrollControl {
    return _scrollControl;
  }

  List<Bookmarks> get bookmarkBucket {
    return _bookmarksBucket;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _newsStream.cancel();
  }
}
