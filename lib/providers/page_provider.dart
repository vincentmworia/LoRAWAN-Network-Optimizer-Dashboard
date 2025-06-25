import 'package:flutter/material.dart';

import '../models/enum_my_pages.dart';

class PageProvider with ChangeNotifier {
  MyPage _currentPage = MyPage.home;

  MyPage get currentPage => _currentPage;

  void setPage(MyPage newPage) {
    if (_currentPage != newPage) {
      _currentPage = newPage;
      notifyListeners();
    }
  }
}
