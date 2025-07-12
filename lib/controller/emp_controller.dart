import 'package:get/get.dart';
import 'package:multigenesys_app/model/emp_model.dart';

import '../services/api_ser.dart';

class EmployeeController extends GetxController {
  var employees = <Employee>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchEmployees();
    super.onInit();
  }

  void fetchEmployees() async {
    try {
      isLoading(true);
      final result = await ApiService.fetchEmployees();
      employees.assignAll(result);
    } catch (e) {
      Get.snackbar("Error", "Failed to load employees");
    } finally {
      isLoading(false);
    }
  }

  void addEmployee(Employee emp) async {
    try {
      await ApiService.createEmployee(emp);
      fetchEmployees();
      Get.back();
      Get.snackbar("Success", "Employee added");
    } catch (e) {
      Get.snackbar("Error", "Failed to add employee");
    }
  }
}
