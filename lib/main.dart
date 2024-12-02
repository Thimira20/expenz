import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/onboarding_screen.dart';
import 'package:flutter_application_1/services/user_details_service.dart';
import 'package:flutter_application_1/widgets/wrapper.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //initialize widgets
  await SharedPreferences.getInstance(); //initialize shared preferences
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Expemze',
//       theme: ThemeData(
//         fontFamily: 'Inter',
//       ),
//       home: OnBoardingScreen(),
//     );
//   }
// }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: UserService.checkUsername(),
        builder: (context, snapshot) {
          //build the app
          if (snapshot.connectionState == ConnectionState.waiting) {
            //wait for the future to complete
            return const CircularProgressIndicator();
          } else {
            bool hasUserName =
                snapshot.data ?? false; //get the value of the future
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                fontFamily: 'Inter',
              ),
              home: Wrapper(
                showMainScreen: hasUserName,
              ),
            );
          }
        });
  }
}
