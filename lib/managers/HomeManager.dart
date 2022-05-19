import 'dart:async';

import 'package:flutter/material.dart';


class HomeManager extends ChangeNotifier {
  late bool _isLoading;


  late final userId;
  HomeManager(this.userId) {

/*    _productService = ProductDataService(userId);
    _prodControl = ScrollController();
    _prodControl.addListener(_scrollListener);*/
/*    startProductBasketSubscription();*/
  }

/*  void startProductBasketSubscription() {
    _isLoading = true;
    productAvailable = true;
    notifyListeners();
    print("Hello starting item subs \n\n\n\n\n");
    _productBasketStream = _productService.productBasket.asStream().listen((productBasket) {
      _productBasket = productBasket;
      print("${productBasket.length} is \n\n\n\n");
      if (productBasket.length < 10) {
        productAvailable = false;
      }
      if (productBasket.isNotEmpty) {
        lastTime = productBasket[productBasket.length - 1].productListingTime;
        _isLoading = false;
        notifyListeners();
      }
    });
  }

  _scrollListener() async {
    if (_prodControl.offset >= _prodControl.position.maxScrollExtent &&
        !_prodControl.position.outOfRange &&
        productAvailable) {
      loadMoreProducts();
      toggleLoading();
    }
  }

  Future<void> loadMoreProducts() async {
    await _productService.getNextProductsBasket(lastTime).then((nextProductBasket) {
      _productBasket = [...productBasket, ...nextProductBasket];
      lastTime = nextProductBasket[nextProductBasket.length - 1].productListingTime;
      if (nextProductBasket.length < 10) {
        productAvailable = false;
      }
    });
    _isLoading = false;
    notifyListeners();
  }*/

  toggleLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }



  bool get isLoading {
    return _isLoading;
  }
}