import 'package:flutter/material.dart';
class User_profile extends StatelessWidget {
  const User_profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            child: Image.asset("assets/images/user.jpeg"),
          )
        ],
      ),
    );
  }
}
