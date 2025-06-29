import 'package:flutter/foundation.dart';

class TimestampProvider with ChangeNotifier {
  DateTime? _lastUpdated;
  bool _justUpdated = false;

  DateTime? get lastUpdated => _lastUpdated;

  bool get justUpdated => _justUpdated;

  void updateTime(DateTime? timestamp) {
    _lastUpdated = timestamp;
    _justUpdated = true;
    notifyListeners();

    Future.delayed(const Duration(seconds: 1), () {
      _justUpdated = false;
      notifyListeners();
    });
  }
}
