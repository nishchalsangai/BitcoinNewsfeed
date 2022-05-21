import 'dart:async';

import 'package:flutter/material.dart';
import 'package:untitled/core/toasts.dart';
import 'package:untitled/models/Bookmarks.dart';
import 'package:untitled/services/BookMarksService.dart';
import 'package:untitled/services/NewsFeedService.dart';

import '../core/AppTheme.dart';
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
  late final _userId;

  final GlobalKey<ScaffoldState> _scaffoldKey=  GlobalKey<ScaffoldState>();

  HomeManager(this._userId) {
    _isLoading = true;
    _newsFeedService = NewsFeedService();
    _bookMarksService = BookMarksService(_userId);
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


   tryAgain(){
    HomeManager(_userId);
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
    } else {
      toggleLoading();
    }
  }

  toggleLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  addAndRemoveBookmark(News news, String? bookmarkId) async {
    if (checkBookmarkStatus(news)) {
      bookmarkId != null
          ? _bookMarksService.removeBookmark(bookmarkId).then((value) {
              ShowToast(value.toString(), AppTheme.nearlyGreen, 1);
              updateBookmarkBucket();
              notifyListeners();
            })
          : _bookMarksService.removeBookmarksFromNewsFeed(news.toMap(news)).then((value) {
              ShowToast(value.toString(), AppTheme.nearlyGreen, 1);
              updateBookmarkBucket();
              notifyListeners();
            });
    } else {
      final id = await _bookMarksService.generateNewBookmark();
      _bookMarksService
          .addBookmark(bookmarkId: id, userId: _userId, news: news.toMap(news))
          .then((value) {
        ShowToast(value.toString(), AppTheme.nearlyGreen, 1);
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

  Key get scaffoldKey {
    return _scaffoldKey;
  }



  void showInSnackBarNewsFeed(String value) {
    _scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(value)));
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _newsStream.cancel();
  }
}
