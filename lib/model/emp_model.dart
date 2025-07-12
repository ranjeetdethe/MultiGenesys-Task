class Employee {
  final String id;
  final String name;
  final String position;
  final String department;

  Employee({
    this.id = '',
    required this.name,
    required this.position,
    required this.department,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      position: json['position'] ?? '',
      department: json['department'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'position': position, 'department': department};
  }
}
