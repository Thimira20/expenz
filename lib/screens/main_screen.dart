import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/colors.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/logo.png",
            width: 100,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 20,
          ),
          const Center(
            child: Text(
              "Expenz",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: kMainColor,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
