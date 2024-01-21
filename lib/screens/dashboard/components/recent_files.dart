// Import your CustomerDetail model and the PriorityService
import 'package:admin/models/customerModel.dart';
import 'package:admin/viewmodel/priority_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../constants.dart';

class RecentFiles extends StatelessWidget {
  final List<CustomerDetail> customerDetails; // Add this property

  const RecentFiles({
    Key? key,
    required this.customerDetails, // Add this parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sort the customerDetails list by priority (high to low)
    customerDetails
        .sort((a, b) => priorityToInt(b.priority) - priorityToInt(a.priority));

    // Update priority counts in PriorityService
    PriorityService.updateCounts(customerDetails);

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
            "Recent Customers", // Update the title
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                DataTable(
                  columnSpacing: defaultPadding,
                  columns: [
                    DataColumn(
                      label: Text("Name"),
                    ),
                    DataColumn(
                      label: Text("Order ID"),
                    ),
                    DataColumn(
                      label: Text("Issue"),
                    ),
                    DataColumn(
                      label: Text("Created At"),
                    ),
                    DataColumn(
                      label: Text("Priority"),
                    ),
                  ],
                  rows: List.generate(
                    customerDetails.length,
                    (index) => customerDetailDataRow(customerDetails[index]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

int priorityToInt(String priority) {
  switch (priority.toLowerCase()) {
    case 'high':
      return 3;
    case 'medium':
      return 2;
    case 'low':
      return 1;
    default:
      return 0;
  }
}

DataRow customerDetailDataRow(CustomerDetail customerDetail) {
  return DataRow(
    cells: [
      DataCell(
        Text(customerDetail.name),
      ),
      DataCell(
        Text(customerDetail.orderId),
      ),
      DataCell(
        Container(width: 200, child: Text(customerDetail.issue)),
      ),
      DataCell(
        Text(customerDetail.createdAt.toString().substring(0, 19)),
      ),
      DataCell(
        Text(customerDetail.priority),
      ),
    ],
  );
}
