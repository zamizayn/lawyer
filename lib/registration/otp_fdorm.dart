import 'dart:developer';

import 'package:find_your_lawyer/registration/controller.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
// import 'package:otp_text_field/otp_field.dart';
// import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';

class Otp_Form extends StatelessWidget {
  Otp_Form({super.key, required this.phoneNumber, this.skipOTP = false});
  final String phoneNumber;
  final bool skipOTP;
  String otpPin = '';
  // OtpFieldController otpController = OtpFieldController();

  @override
  Widget build(BuildContext context) {
    String phoneNumberHidden = phoneNumber.replaceRange(4, phoneNumber.length - 3, '******');
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 150,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text("Verification Code",
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 8),
            child: Row(
              children: [
                Text("We have sent verification code to",
                    style: TextStyle(
                      color: Colors.grey,
                    )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Row(
              children: [
                Text(phoneNumberHidden,
                    style: const TextStyle(
                      color: Colors.grey,
                    )),
                const SizedBox(
                  width: 10,
                ),
                const Text("Change phone number",
                    style: TextStyle(
                      color: Color(0xFF674AEF),
                    )),
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Consumer<RegisterFormController>(builder: (context, controller, child) {
            return Center(
              child: Pinput(
                length: 6,
                controller: controller.otpController,
                onChanged: (value) => otpPin = value,
                onCompleted: (pin) {
                  log("Completed: $pin");
                  otpPin = pin;
                  controller.verifyOtp(context, pin, phoneNumber);
                },
              ),
            );
          }),
          // Center(
          //   child: OTPTextField(
          //     length: 6,
          //     width: MediaQuery.of(context).size.width,
          //     fieldWidth: 60,
          //     style: const TextStyle(
          //       fontSize: 17,
          //     ),
          //     textFieldAlignment: MainAxisAlignment.spaceAround,
          //     fieldStyle: FieldStyle.underline,
          //     onChanged: (value) => otpPin = value,
          //     onCompleted: (pin) {
          //       print("Completed: " + pin);
          //       otpPin = pin;
          //       RegisterFormController.instance.verifyOtp(context, pin, phoneNumber);
          //     },
          //   ),
          // ),
          const SizedBox(
            height: 5,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Resent",
                  style: TextStyle(
                    color: Color(0xFF674AEF),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          Consumer<RegisterFormController>(builder: (context, controller, child) {
            if (controller.isOtpVerifying) {
              return const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("Verifying.."), SizedBox(width: 10), CircularProgressIndicator()],
              );
            }
            return Material(
              color: const Color(0xFF674AEF),
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: () {
                  controller.verifyOtp(context, otpPin, phoneNumber);
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => const Registration()));
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
            );
          })
        ],
      ),
    );
  }
}
