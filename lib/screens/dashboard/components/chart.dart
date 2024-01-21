import 'package:admin/viewmodel/priority_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class Chart extends StatelessWidget {
  const Chart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Access priority counts from PriorityService
    int highPriorityCount = PriorityService.highPriorityCount;
    int mediumPriorityCount = PriorityService.mediumPriorityCount;
    int lowPriorityCount = PriorityService.lowPriorityCount;

    // Calculate total count for percentage calculation
    int totalCount = highPriorityCount + mediumPriorityCount + lowPriorityCount;

    // Calculate percentage for each priority level
    double highPriorityPercentage = (highPriorityCount / totalCount) * 100;
    double mediumPriorityPercentage = (mediumPriorityCount / totalCount) * 100;
    double lowPriorityPercentage = (lowPriorityCount / totalCount) * 100;

    // Generate PieChartSectionData based on the percentages
    List<PieChartSectionData> pieChartSelectionData = [
      PieChartSectionData(
        color: primaryColor,
        value: highPriorityPercentage,
        showTitle: false,
        radius: 25,
      ),
      PieChartSectionData(
        color: Color(0xFF26E5FF),
        value: mediumPriorityPercentage,
        showTitle: false,
        radius: 22,
      ),
      PieChartSectionData(
        color: Color(0xFFFFCF26),
        value: lowPriorityPercentage,
        showTitle: false,
        radius: 19,
      ),
    ];

    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 70,
              startDegreeOffset: -90,
              sections: pieChartSelectionData,
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: defaultPadding),
                Text(
                  "${totalCount}",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        height: 0.5,
                      ),
                ),
                Text("Total Count")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
