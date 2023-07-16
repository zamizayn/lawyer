import 'package:camera/camera.dart';
import 'package:find_your_lawyer/controllers/lawyers_controller.dart';
import 'package:find_your_lawyer/database/db.dart';
import 'package:find_your_lawyer/main.dart';
import 'package:find_your_lawyer/registration/controller.dart';
import 'package:find_your_lawyer/screens/home_screens.dart';
import 'package:find_your_lawyer/screens/main_screen.dart';
import 'package:find_your_lawyer/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

import '../registration/camera_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToHome();
  }

  void navigateToHome() async {
    await DB.instance.init();
    await Firebase.initializeApp();
    LawyersController.instance.getLawyers();
    RegisterFormController.instance.getUserData();
    cameras = await availableCameras();
    await Future.delayed(const Duration(seconds: 3));
    // Optional delay for splash screen visibility

    if (RegisterFormController.instance.isUserRegistered) {
      if (context.mounted) {
        if (RegisterFormController.instance.isUserRegistered) {
          Provider.of<RegisterFormController>(context, listen: false)
              .setIsLogined(true);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const MainScreen()));
        } else {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        }
      }
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const WelcomeScreen(),
          // const Phn_fill(),
          // const Registration(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: scaffoldMessengerKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: CachedNetworkImage(
            imageUrl:
                'https://thumbs.dreamstime.com/b/law-firm-logo-icon-design-template-vector-law-firm-logo-icon-design-template-vector-symbol-lawyer-business-element-justice-171344440.jpg',
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            fadeInDuration: const Duration(milliseconds: 500),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
