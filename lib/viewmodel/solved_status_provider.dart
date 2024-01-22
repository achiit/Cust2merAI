import 'package:flutter/foundation.dart';

class SolvedStatusProvider extends ChangeNotifier {
  bool _solved = false;

  bool get solved => _solved;

  set solved(bool value) {
    _solved = value;
    notifyListeners();
  }
}
