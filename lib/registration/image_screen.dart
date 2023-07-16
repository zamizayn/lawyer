import 'dart:io';

import 'package:find_your_lawyer/registration/controller.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageScreen extends StatelessWidget {
  final XFile image;
  const ImageScreen({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Stack(
        children: [
          Image.file(
            File(image.path),
            width: size.width,
            height: size.height,
            fit: BoxFit.contain,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.cancel,
                        color: Colors.white,
                        size: 50,
                      )),
                  IconButton(
                      onPressed: () {
                        RegisterFormController.instance.setProfile(File(image.path));
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.done,
                        color: Colors.white,
                        size: 50,
                      ))
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
