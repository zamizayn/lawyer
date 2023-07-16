import 'package:find_your_lawyer/registration/controller.dart';
import 'package:find_your_lawyer/screens/home_screens.dart';
import 'package:find_your_lawyer/screens/main_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.6,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.6,
                  decoration: const BoxDecoration(
                      color: Color(0xFF674AEF),
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(70))),
                  child: Center(
                    child: Image.asset(
                      "assets/images/image_processing20201224-16163-19o3blq.png",
                      scale: 0.8,
                    ),
                  ),
                )
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.666,
                decoration: const BoxDecoration(color: Color(0xFF674AEF)),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.666,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(70))),
                child: Column(
                  children: [
                    const Text(
                      "Find Your Lawyer",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                          wordSpacing: 2),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                          "A lawyer is a professional who is qualified to offer advice about the law or represent someone in legal matters. A lawyer can also be called an attorney, a solicitor, a counselor, a barrister, or — pejoratively — an ambulance chaser.",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15, color: Colors.black.withOpacity(0.6))),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Material(
                      color: const Color(0xFF674AEF),
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () {
                          if (RegisterFormController.instance.isUserRegistered) {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) => const MainScreen()));
                          } else {
                            Navigator.pushReplacement(
                                context, MaterialPageRoute(builder: (context) => HomeScreen()));
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 80),
                          child: const Text("Get Start",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                wordSpacing: 2,
                              )),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
