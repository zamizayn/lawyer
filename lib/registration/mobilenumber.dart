import 'package:find_your_lawyer/registration/controller.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:provider/provider.dart';

class Phn_fill extends StatefulWidget {
  const Phn_fill({super.key});

  @override
  State<Phn_fill> createState() => _Phn_fillState();
}

class _Phn_fillState extends State<Phn_fill> {
  TextEditingController countrycode = TextEditingController();
  PhoneNumber? phoneNumber;
  final formKey = GlobalKey<FormState>();

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
        backgroundColor: Colors.grey[300],
      ),
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Icon(
                Icons.lock,
                size: 100,
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                "Welcome back you\'ve been missed",
                style: TextStyle(color: Colors.grey[700], fontSize: 16),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Container(
                    padding:
                        const EdgeInsets.only(right: 10, left: 10, top: 15),
                    margin: const EdgeInsets.only(top: 5, bottom: 20),
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Form(
                      key: formKey,
                      child: IntlPhoneField(
                        controller: countrycode,
                        decoration: const InputDecoration(
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                        ),
                        initialCountryCode: 'IN',
                        validator: (p0) {
                          if (p0 == null) {
                            return "Provide Phone number";
                          }
                          if (p0.number.length != 10) {
                            return "Inavlid Phone number";
                          }
                          return null;
                        },
                        onChanged: (phone) {
                          phoneNumber = phone;
                          print(phone.completeNumber);
                        },
                      ),
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              Consumer<RegisterFormController>(
                  builder: (context, controller, child) {
                if (controller.isRequestingOTP) {
                  return const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Requesting OTP",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(width: 20),
                      CircularProgressIndicator()
                    ],
                  );
                }
                return Material(
                  color: const Color(0xFF674AEF),
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        FocusScope.of(context).unfocus();
                        var controller = context.read<RegisterFormController>();
                        controller.phoneVerification(
                            context, phoneNumber!.completeNumber);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 80),
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
        ),
      ),
    );
  }
}
