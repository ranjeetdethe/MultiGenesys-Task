import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:multigenesys_app/model/emp_model.dart';

class ApiService {
  static const String baseUrl =
      "https://669b3f09276e45187d34eb4e.mockapi.io/api/v1";

  static Future<List<Employee>> fetchEmployees() async {
    final response = await http.get(Uri.parse("$baseUrl/employee"));
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => Employee.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load employees");
    }
  }

  static Future<void> createEmployee(Employee employee) async {
    final response = await http.post(
      Uri.parse("$baseUrl/employee"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(employee.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception("Failed to add employee");
    }
  }
}
