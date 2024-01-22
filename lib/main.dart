import 'package:admin/constants.dart';
import 'package:admin/controllers/MenuAppController.dart';
import 'package:admin/data/apiService.dart';
import 'package:admin/models/customerModel.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:admin/viewmodel/percentage.dart';
import 'package:admin/viewmodel/solved_status_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

void main() async {
  final apiService = ApiService();

  try {
    List<CustomerDetail> customerDetails = await apiService.getAllData();
    customerDetails.forEach((customer) {
      print(customer.name);
      print(customer.orderId);
      // Add other properties as needed
    });
  } catch (e) {
    print('Error: $e');
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Admin Panel',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => MenuAppController(),
          ),
          ChangeNotifierProvider(
            create: (context) => SolvedStatusProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => StatusPercentage(),
          ),
        ],
        child: MainScreen(),
      ),
    );
  }
}
