import 'dart:async';

import 'package:admin/models/customerModel.dart';

class PriorityService {
  static int highPriorityCount = 0;
  static int mediumPriorityCount = 0;
  static int lowPriorityCount = 0;

  static final StreamController<Map<String, int>> _priorityController =
      StreamController<Map<String, int>>.broadcast();

  static Stream<Map<String, int>> get priorityStream =>
      _priorityController.stream;

  static void updateCounts(List<CustomerDetail> customerDetails) {
    highPriorityCount = 0;
    mediumPriorityCount = 0;
    lowPriorityCount = 0;

    for (var detail in customerDetails) {
      switch (detail.priority.toLowerCase()) {
        case 'high':
          print("this is working");
          highPriorityCount++;
          break;
        case 'medium':
          mediumPriorityCount++;
          break;
        case 'low':
          lowPriorityCount++;
          break;
      }
    }

    _priorityController.add({
      'highPriorityCount': highPriorityCount,
      'mediumPriorityCount': mediumPriorityCount,
      'lowPriorityCount': lowPriorityCount,
    });
  }
}
