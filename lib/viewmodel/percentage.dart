import 'package:flutter/material.dart';

class StatusPercentage extends ChangeNotifier {
  double solvedPercent = 0;
  double unsolvedPercent = 0;
  int solvedCount = 0;
  int unsolvedCount = 0;

  void setSolvedPercent(double percent) {
    solvedPercent = percent;
    notifyListeners();
  }

  void setUnsolvedPercent(double percent) {
    unsolvedPercent = percent;
    notifyListeners();
  }

  void setSolvedCount(int count) {
    solvedCount = count;
    notifyListeners();
  }
  void setunSolvedCount(int count) {
    unsolvedCount = count;
    notifyListeners();
  }
}
