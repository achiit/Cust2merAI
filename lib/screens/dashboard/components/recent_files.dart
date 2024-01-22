// Import your CustomerDetail model and the PriorityService
import 'dart:convert';

import 'package:admin/models/customerModel.dart';
import 'package:admin/viewmodel/priority_provider.dart';
import 'package:admin/viewmodel/solved_status_provider.dart';
import 'package:admin/viewmodel/status_count_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../constants.dart';

class RecentFiles extends StatefulWidget {
  final List<CustomerDetail> customerDetails;

  const RecentFiles({
    Key? key,
    required this.customerDetails,
  }) : super(key: key);

  @override
  State<RecentFiles> createState() => _RecentFilesState();
}

class _RecentFilesState extends State<RecentFiles> {
  @override
  Widget build(BuildContext context) {
    // Sort the customerDetails list by priority (high to low)
    widget.customerDetails
        .sort((a, b) => priorityToInt(b.priority) - priorityToInt(a.priority));

    // Update priority counts in PriorityService
    StatusService.updateCounts(widget.customerDetails);
    PriorityService.updateCounts(widget.customerDetails);

    return ChangeNotifierProvider(
      create: (context) => SolvedStatusProvider(),
      child: Container(
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
                      DataColumn(
                        label: Text("Solved"),
                      ),
                    ],
                    rows: List.generate(
                      widget.customerDetails.length,
                      (index) => customerDetailDataRow(
                        context,
                        widget.customerDetails[index],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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

DataRow customerDetailDataRow(
    BuildContext context, CustomerDetail customerDetail) {
  final solvedStatusProvider = Provider.of<SolvedStatusProvider>(context);

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
      DataCell(
        DropdownButton<String>(
          value: customerDetail.solved == true ? "Solved" : "Unsolved",
          onChanged: (newValue) {
            // Show an AlertDialog when the user changes the dropdown value
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Confirm Resolution'),
                  content: Text('Are you sure the complaint is resolved?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the AlertDialog
                      },
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () async {
                        String orderId = customerDetail.orderId;
                        // Update the solved status when the user confirms

                        Navigator.of(context).pop(); // Close the AlertDialog
                        await updateSolvedStatusAPI(
                            orderId, solvedStatusProvider.solved);
                        // You may want to perform additional logic or update the database here
                      },
                      child: Text('Yes'),
                    ),
                  ],
                );
              },
            );
          },
          items: ['Unsolved', 'Solved']
              .map<DropdownMenuItem<String>>(
                (String value) => DropdownMenuItem<String>(
                  value: value,
                  child: Center(child: Text(value)),
                ),
              )
              .toList(),
        ),
      ),
    ],
  );
}

Future<void> updateSolvedStatusAPI(String orderId, bool solvedStatus) async {
  final apiUrl =
      'https://twilio-backend-4rh3.onrender.com/update-solved-status';
  print("the orderid to be updated is $orderId");
  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'orderId': orderId, 'solvedStatus': !solvedStatus}),
    );

    if (response.statusCode == 200) {
      print('Solved status updated successfully');
    } else if (response.statusCode == 404) {
      print('Order not found');
    } else {
      print('Failed to update solved status');
    }
  } catch (e) {
    print('Error updating solved status: $e');
  }
}
