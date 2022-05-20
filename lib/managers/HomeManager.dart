import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:untitled/services/NewsFeedService.dart';

import '../models/News.dart';

class HomeManager extends ChangeNotifier {
  late bool _isLoading;
  late int _currentPage;
  late NewsFeedService _newsFeedService;
  late List<News> _newsBasket;
  late ScrollController _scrollControl;
  late StreamSubscription _newsStream;
  late bool newsAvailable;

  late final userId;
  HomeManager(this.userId) {
    _isLoading = true;
    _newsFeedService = NewsFeedService();
    _currentPage = 0;
    _newsBasket = [];
    _scrollControl = ScrollController();
    _scrollControl.addListener(_scrollListener);
    onLoading();
    NewsBasket();
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

  List<News> get newsBasket {
    return _newsBasket;
  }

  bool get isLoading {
    return _isLoading;
  }

  ScrollController get scrollControl {
    return _scrollControl;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _newsStream.cancel();
  }
}
