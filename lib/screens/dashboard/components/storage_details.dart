import 'package:admin/viewmodel/priority_provider.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'chart.dart';
import 'storage_info_card.dart';

class StorageDetails extends StatelessWidget {
  const StorageDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Priority Details",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: defaultPadding),
          Chart(),
          StorageInfoCard(
            svgSrc: primaryColor,
            title: "High",
            amountOfFiles: PriorityService.highPriorityCount.toString(),
            numOfFiles: 1328,
          ),
          StorageInfoCard(
            svgSrc: Color(0xFF26E5FF),
            title: "Medium",
            amountOfFiles: PriorityService.mediumPriorityCount.toString(),
            numOfFiles: 1328,
          ),
          StorageInfoCard(
            svgSrc: Color(0xFFFFCF26),
            title: "Low",
            amountOfFiles: PriorityService.lowPriorityCount.toString(),
            numOfFiles: 1328,
          ),
        ],
      ),
    );
  }
}
