import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //initialize widgets
  await SharedPreferences.getInstance(); //initialize shared preferences
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expemze',
      theme: ThemeData(
        fontFamily: 'Inter',
      ),
      home: OnBoardingScreen(),
    );
  }
}
