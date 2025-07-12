import 'dart:async';

import 'package:flutter/material.dart';
import 'package:multigenesys_app/view/emp_list.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => EmployeeListScreen()),
      );
    });
    return Scaffold(
      body: Column(
        children: [
          Spacer(),
          Center(child: Image.asset("assets/sp_image.jpg")),
          Spacer(),

          // SizedBox(height: 100),
        ],
      ),
    );
  }
}
