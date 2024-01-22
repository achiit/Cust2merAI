import 'dart:async';

import 'package:admin/models/customerModel.dart';

class StatusService {
  static int solvedCount = 0;
  static int unsolvedCount = 0;

  static final StreamController<Map<String, int>> _statusController =
      StreamController<Map<String, int>>.broadcast();

  static Stream<Map<String, int>> get priorityStream =>
      _statusController.stream;

  static void updateCounts(List<CustomerDetail> customerDetails) {
    solvedCount = 0;
    unsolvedCount = 0;

    for (var detail in customerDetails) {
      switch (detail.solved) {
        case true:
          solvedCount++;
          print("incremented");
          break;
        case false:
          unsolvedCount++;
          break;
      }
    }
    print(solvedCount);
    _statusController.add({
      'solvedCount': solvedCount,
      'unsolvedCount': unsolvedCount,
    });
  }
}
