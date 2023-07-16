import 'package:find_your_lawyer/controllers/lawyers_controller.dart';
import 'package:find_your_lawyer/controllers/send_request_controller.dart';
import 'package:find_your_lawyer/registration/controller.dart';

import 'package:find_your_lawyer/screens/splash.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RegisterFormController.instance,
        ),
        ChangeNotifierProvider(
          create: (context) => LawyersController.instance,
        ),
        ChangeNotifierProvider(
          create: (context) => SendRequestController.instance,
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: const MaterialColor(0xFF674AEF, <int, Color>{
            50: Color(0xFFF6F5F5),
            100: Color(0xFF674AEF),
            200: Color(0xFF674AEF),
            300: Color(0xFF674AEF),
            400: Color(0xFF674AEF),
            500: Color(0xFF674AEF),
            600: Color(0xFF674AEF),
            700: Color(0xFF674AEF),
          }),
          // primaryColor: const Color(0xFF674AEF),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
