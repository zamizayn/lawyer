import 'package:find_your_lawyer/registration/controller.dart';
import 'package:find_your_lawyer/screens/case_request.dart';
import 'package:find_your_lawyer/screens/cause_qoutation.dart';
import 'package:find_your_lawyer/screens/home_screens.dart';
import 'package:find_your_lawyer/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Request.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget currentScreen = navScreenList[0];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentScreen,
      bottomNavigationBar: Consumer<RegisterFormController>(builder: (context, controller, child) {
        return BottomNavigationBar(
          currentIndex: currentIndex,
          showUnselectedLabels: true,
          iconSize: 25,
          selectedItemColor: const Color(0xFF674AEF),
          selectedFontSize: 18,
          unselectedItemColor: Colors.grey,
          onTap: (value) => setState(() {
            currentIndex = value;
            currentScreen = navScreenList[value];
          }),
          items: [
            const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            const BottomNavigationBarItem(icon: Icon(Icons.request_page), label: "Request"),
            ...controller.userData == null
                ? []
                : [
                    BottomNavigationBarItem(
                        icon: CircleAvatar(
                            backgroundImage: MemoryImage(controller.userData!.profile)),
                        label: "Profile")
                  ]
          ],
        );
      }),
    );
  }
}

List navScreenList = [
  HomeScreen(),
  const CaseRequestsSentPage(),
  const ProfileScreen(),
];
