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
  late StreamSubscription _newsStream;
  late RefreshController refreshController;

  late final userId;
  HomeManager(this.userId) {
    _newsFeedService = NewsFeedService();
    _currentPage = 1;
    _newsBasket = [];
    refreshController = RefreshController(initialRefresh: true);
    NewsBasket();
  }

  NewsBasket() {
    _newsStream = _newsFeedService.newsBucketStream.listen((news) {
      _newsBasket.add(news);
      notifyListeners();
    });
  }

  onRefresh() async {
    final result = await _newsFeedService.getNewsFeed(isRefresh: true);
    if (result) {
      refreshController.refreshCompleted();
    } else {
      refreshController.refreshFailed();
    }
  }

  onLoading() async {
    _currentPage++;
    final result = await _newsFeedService.getNewsFeed(currentPage: _currentPage);
    if (result) {
      refreshController.loadComplete();
      notifyListeners();
    } else {
      refreshController.loadFailed();
    }
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

}
