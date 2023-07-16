import 'dart:developer';
import 'dart:io';

import 'package:find_your_lawyer/database/db.dart';
import 'package:find_your_lawyer/database/user_model.dart';
import 'package:find_your_lawyer/registration/api/registration_api.dart';
import 'package:find_your_lawyer/registration/otp_fdorm.dart';
import 'package:find_your_lawyer/registration/useer_registration_page.dart';
import 'package:find_your_lawyer/screens/main_screen.dart';
import 'package:find_your_lawyer/screens/nav_drawer.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterFormController extends ChangeNotifier {
  RegisterFormController._privateConstructor();

  static final RegisterFormController instance =
      RegisterFormController._privateConstructor();

  // final TextEditingController nameController = TextEditingController();
  // final TextEditingController emailController = TextEditingController();
  // final TextEditingController phoneController = TextEditingController();
  // final TextEditingController dobController = TextEditingController();
  // final TextEditingController typeController = TextEditingController();
  // final TextEditingController addressController = TextEditingController();
  // final TextEditingController streetController = TextEditingController();
  // final TextEditingController cityController = TextEditingController();
  // final TextEditingController stateController = TextEditingController();
  // final TextEditingController countryController = TextEditingController();
  // final TextEditingController postalCodeController = TextEditingController();

//-----profile image-------------------
  File? profileImage;
  bool isLogined = false;

  setIsLogined(bool flag) {
    this.isLogined = flag;
    notifyListeners();
  }

  void setProfile(File image) {
    profileImage = image;
    notifyListeners();
  }

  bool get isUserRegistered {
    return userData != null;
  }

  List<CountryModel>? countries;
  void getCountries() async {
    countries = await RegistrationAPI.getAllCountries();
    notifyListeners();
  }

  List<StateModel>? states;
  void getState(CountryModel countryModel) async {
    states = await RegistrationAPI.getStatesByCountry(countryModel.value);
    notifyListeners();
  }

  //-----userDataDB----------------
  UserModel? userData;
  void loadUserData() {
    userData = DB.instance.getUserData();
    notifyListeners();
  }

  Future<void> logOut(BuildContext context) async {
    Provider.of<RegisterFormController>(context, listen: false)
        .setIsLogined(false);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const LoggingOut()));
    await Future.delayed(const Duration(seconds: 2));
    await DB.instance.deleteUserData();
    userData = null;

    notifyListeners();
  }

  Future<void> saveUserData(UserModel userData) async {
    this.userData = userData;
    await DB.instance.saveUserData(userData);
    notifyListeners();
  }

  void getUserData() {
    userData = DB.instance.getUserData();
    notifyListeners();
  }

//-----Phone Verification Firebase---------------------------------------

  final _auth = FirebaseAuth.instance;
  String? verifiedNumber;
  String verificationId = '';
  bool isOtpVerifying = false;
  bool isRequestingOTP = false;
  bool _isRegistering = false;
  TextEditingController otpController = TextEditingController();

  bool get isRegistering {
    return _isRegistering;
  }

  set isRegistering(bool value) {
    _isRegistering = value;
    notifyListeners();
  }

  //! Check to turn skipOTP false in release
  bool skipOTP = true;

  Future<void> phoneVerification(
    BuildContext context,
    String phoneNo,
  ) async {
    try {
      phoneNo = phoneNo.trim();
      log(phoneNo);
      isRequestingOTP = true;
      notifyListeners();
      if (skipOTP) {
        isRequestingOTP = false;

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Otp_Form(
                      phoneNumber: phoneNo,
                      skipOTP: skipOTP,
                    )));
        await Future.delayed(const Duration(seconds: 2));
        otpController.text = "123456";
        isOtpVerifying = true;
        notifyListeners();
        log("SkipOTP True");
        await _loginIfNumberExists(context, phoneNo);
        isRequestingOTP = false;
        notifyListeners();
        return;
      }
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 100),
        verificationCompleted: (phoneAuthCredential) async {
          log("Verification Completed");
          await _auth.signInWithCredential(phoneAuthCredential);
          await _loginIfNumberExists(context, phoneNo);
          isRequestingOTP = false;
          notifyListeners();
        },
        verificationFailed: (error) {
          log("Verification Failed error:${error.code}");
          isRequestingOTP = false;
          notifyListeners();
        },
        codeSent: (verificationId, forceResendingToken) {
          log("Code Sent");
          this.verificationId = verificationId;
          isRequestingOTP = false;
          notifyListeners();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Otp_Form(
                        phoneNumber: phoneNo,
                      )));
        },
        codeAutoRetrievalTimeout: (verificationId) {
          log("Code Retrieval Time out");
          this.verificationId = verificationId;
          isRequestingOTP = false;

          notifyListeners();
        },
      );
    } catch (e) {
      isRequestingOTP = false;
      notifyListeners();
      log(e.toString());
    }
  }

  Future<void> _loginIfNumberExists(
      BuildContext context, String phoneNo) async {
    verifiedNumber = phoneNo;
    String? token = await RegistrationAPI.checkAccountExists(phoneNo);
    if (token == null) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const Registration(),
      ));
    } else {
      userData = await RegistrationAPI.getUserData(token);
      notifyListeners();
      if (userData != null) {
        await saveUserData(userData!);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const MainScreen(),
            ),
            (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Something Went Wrong")));
        Navigator.of(context).pop();
      }
    }
    otpController.clear();
    isOtpVerifying = false;
    notifyListeners();
  }

  Future<void> verifyOtp(
      BuildContext context, String code, String phoneNo) async {
    isOtpVerifying = true;
    notifyListeners();
    log("OTP: $code");
    try {
      if (skipOTP == false) {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: code);
        await _auth.signInWithCredential(credential);
        log("SignIn with Credential Completed");
      }
      Provider.of<RegisterFormController>(context, listen: false)
          .setIsLogined(true);
      await _loginIfNumberExists(context, phoneNo);
      isOtpVerifying = false;
      notifyListeners();
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
      isOtpVerifying = false;
      notifyListeners();
    }
  }
}
