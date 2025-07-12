import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter/services.dart'; // For exit(0)

class Employee {
  final String name;
  final String position;
  final String department;

  Employee({
    required this.name,
    required this.position,
    required this.department,
  });
}

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  final List<Employee> _employees = [
    Employee(
      name: "Sarthak Deshmukh",
      position: "No Position",
      department: "No Department",
    ),
    Employee(
      name: "Gaurav Tambe",
      position: "Data Science",
      department: "Development Department",
    ),
    Employee(
      name: "Shritej",
      position: "FrontEnd Developer",
      department: "Multigenesys Lead",
    ),
    Employee(name: "Sumit", position: "Flutter Developer", department: "IT"),
    Employee(name: "Monika", position: "Flutter Developer", department: "IT"),
    Employee(
      name: "Nitin Jadhav",
      position: "No Position",
      department: "No Department",
    ),
    Employee(
      name: "Sanjay Dutta",
      position: "No Position",
      department: "No Department",
    ),
  ];

  List<Employee> _filteredEmployees = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredEmployees = List.from(_employees);
  }

  void _filterEmployees(String query) {
    setState(() {
      _filteredEmployees = _employees.where((e) {
        final nameMatch = e.name.toLowerCase().contains(query.toLowerCase());
        final positionMatch = e.position.toLowerCase().contains(
          query.toLowerCase(),
        );
        final departmentMatch = e.department.toLowerCase().contains(
          query.toLowerCase(),
        );
        return nameMatch || positionMatch || departmentMatch;
      }).toList();
    });
  }

  void _addEmployeeDialog() {
    final nameCtrl = TextEditingController();
    final posCtrl = TextEditingController();
    final deptCtrl = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.fromLTRB(
          16,
          16,
          16,
          MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Add New Employee",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(
                labelText: "Full Name",
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: posCtrl,
              decoration: const InputDecoration(
                labelText: "Position",
                prefixIcon: Icon(Icons.work),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: deptCtrl,
              decoration: const InputDecoration(
                labelText: "Department",
                prefixIcon: Icon(Icons.apartment),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (nameCtrl.text.isEmpty ||
                    posCtrl.text.isEmpty ||
                    deptCtrl.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please fill all fields")),
                  );
                  return;
                }

                setState(() {
                  final newEmp = Employee(
                    name: nameCtrl.text,
                    position: posCtrl.text,
                    department: deptCtrl.text,
                  );
                  _employees.add(newEmp);
                  _filteredEmployees = List.from(_employees);
                  _searchController.clear();
                });

                Navigator.pop(context);
              },
              child: const Text(
                "Add Employee",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 45),
                backgroundColor: Colors.blue.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEmployeeDetails(Employee emp) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(radius: 30, child: Text(emp.name[0].toUpperCase())),
            const SizedBox(height: 12),
            Text(
              emp.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(emp.position),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.apartment, color: Colors.grey),
                  const SizedBox(width: 8),
                  Expanded(child: Text(emp.department)),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    final shouldExit = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Exit App"),
        content: const Text("Are you sure you want to exit the app?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text("No", style: TextStyle(color: Colors.black)),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text("Yes", style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
    return shouldExit ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F6FA),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () async {
              final exit = await _onBackPressed();
              if (exit) SystemNavigator.pop();
            },
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
          title: const Text(
            "Employee List",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue.shade700,
          centerTitle: true,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                controller: _searchController,
                onChanged: _filterEmployees,
                decoration: InputDecoration(
                  hintText: 'Search employees...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredEmployees.length,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemBuilder: (context, index) {
                  final emp = _filteredEmployees[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue.shade100,
                        child: Text(
                          emp.name[0].toUpperCase(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      title: Text(
                        emp.name,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Text(emp.position), Text(emp.department)],
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () => _showEmployeeDetails(emp),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _addEmployeeDialog,
          icon: const Icon(Icons.person_add, color: Colors.white),
          label: const Text(
            'Add Employee',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue.shade700,
        ),
      ),
    );
  }
}
