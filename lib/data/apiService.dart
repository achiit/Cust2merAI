import 'dart:convert';
import 'package:admin/models/customerModel.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiUrl = "https://twilio-backend-4rh3.onrender.com/get-all-data";

  Future<List<CustomerDetail>> getAllData() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      print(data);
      return data.map((json) => CustomerDetail.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
