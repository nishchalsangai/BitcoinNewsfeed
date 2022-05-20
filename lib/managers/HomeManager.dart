import 'dart:async';

import 'package:flutter/material.dart';
import 'package:untitled/services/NewsFeedService.dart';

import '../models/News.dart';

class HomeManager extends ChangeNotifier {
  late bool _isLoading;

  late NewsFeedService _newsFeedService;
  late ScrollController _newsControl;
  late bool newsAvailable;
  late StreamSubscription _newsBasketStream;
  late List<News> _newsBasket;

  late final userId;
  HomeManager(this.userId) {
    // _newsFeedService = NewsFeedService();
    _newsControl = ScrollController();
    _newsControl.addListener(_scrollListener);
    _newsBasket = [];
    // startNewsBasketSubscription();
  }

  _scrollListener() async {
    if (_newsControl.offset >= _newsControl.position.maxScrollExtent &&
        !_newsControl.position.outOfRange &&
        newsAvailable) {
/*      loadMoreNews();*/
      toggleLoading();
    }
  }

  // void startNewsBasketSubscription() {
  //   _isLoading = true;
  //   newsAvailable = true;
  //   notifyListeners();
  //   print("Hello starting item subs \n\n\n\n\n");
  //   _newsBasketStream = _newsFeedService.getNewsFeed().asStream().listen((newsBasket) {
  //     if (newsBasket != null) {
  //       _newsBasket = newsBasket;
  //       print("${_newsBasket.length} is \n\n\n\n");
  //       if (newsBasket.length < 10) {
  //         newsAvailable = false;
  //       }
  //       if (newsBasket.isNotEmpty) {
  //         // lastTime = productBasket[productBasket.length - 1].productListingTime;
  //         _isLoading = false;
  //         notifyListeners();
  //       }
  //     } else {}
  //   });
  // }

  Future<void> loadMoreProducts() async {
    /* await _newsFeedService.getNextProductsBasket(lastTime).then((nextProductBasket) {
      _productBasket = [...productBasket, ...nextProductBasket];
      lastTime = nextProductBasket[nextProductBasket.length - 1].productListingTime;
      if (nextProductBasket.length < 10) {
        productAvailable = false;
      }
    });*/
    _isLoading = false;
    notifyListeners();
  }

  toggleLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  bool get isLoading {
    return _isLoading;
  }
}
