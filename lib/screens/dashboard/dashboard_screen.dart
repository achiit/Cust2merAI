import 'dart:convert';

import 'package:admin/models/customerModel.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/my_fields.dart';
import 'package:admin/viewmodel/percentage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../constants.dart';
import 'components/header.dart';

import 'components/recent_files.dart';
import 'components/storage_details.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<CustomerDetail> customerDetails = []; // Add this line
  StatusPercentage statusPercentage = StatusPercentage();
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  int solvedCount = 0;
  int unsolvedCount = 0;
  double solvedPercentage = 0;
  double unsolvedPercentage = 0;
  Future<void> fetchData() async {
    final apiUrl = 'https://twilio-backend-4rh3.onrender.com/get-all-data';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<CustomerDetail> fetchedDetails =
            data.map((json) => CustomerDetail.fromJson(json)).toList();
        solvedCount = fetchedDetails.where((detail) => detail.solved).length;
        unsolvedCount = fetchedDetails.length - solvedCount;

        // Calculate the percentage
        solvedPercentage = (solvedCount / fetchedDetails.length) * 100;
        unsolvedPercentage = (unsolvedCount / fetchedDetails.length) * 100;

        // Print the results
        print('Solved Count: $solvedCount');
        print('Unsolved Count: $unsolvedCount');
        print('Solved Percentage: $solvedPercentage%');
        print('Unsolved Percentage: $unsolvedPercentage%');
        setState(() {
          customerDetails = fetchedDetails;
        });
        statusPercentage.setSolvedCount(solvedCount);
        statusPercentage.setunSolvedCount(unsolvedCount);
        statusPercentage.setSolvedPercent(solvedPercentage);
        statusPercentage.setUnsolvedPercent(unsolvedPercentage);
        print("the value of set is ${statusPercentage.solvedCount}");
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 7,
                  child: Column(
                    children: [
                      MyFiles(),
                      SizedBox(height: defaultPadding),
                      if (customerDetails.isEmpty) // Show loading indicator
                        CircularProgressIndicator()
                      else
                        RecentFiles(
                          customerDetails: customerDetails,
                        ),
                      if (Responsive.isMobile(context))
                        SizedBox(height: defaultPadding),
                      if (Responsive.isMobile(context)) StorageDetails(),
                    ],
                  ),
                ),
                if (!Responsive.isMobile(context))
                  SizedBox(width: defaultPadding),
                // On Mobile means if the screen is less than 850 we don't want to show it
                if (!Responsive.isMobile(context))
                  Expanded(
                    flex: 2,
                    child: StorageDetails(),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
