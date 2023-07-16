import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          message,
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(width: 10),
        const CircularProgressIndicator()
      ],
    );
  }
}
