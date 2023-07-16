import 'package:find_your_lawyer/database/user_model.dart';
import 'package:find_your_lawyer/registration/controller.dart';
import 'package:find_your_lawyer/screens/cause_qoutation.dart';
import 'package:find_your_lawyer/screens/home_screens.dart';
import 'package:find_your_lawyer/screens/main_screen.dart';
import 'package:find_your_lawyer/screens/my_causes.dart';
import 'package:find_your_lawyer/screens/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import 'case_quotation.dart';
import 'case_request.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel userData = RegisterFormController.instance.userData!;
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        child: Drawer(
            backgroundColor: Colors.white,
            child: ListView(padding: EdgeInsets.zero, children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: const BoxDecoration(
                  color: Color(0xFF674AEF),
                ),
                accountName: Text(userData.name),
                accountEmail: Text(userData.email),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: MemoryImage(userData.profile),
                  backgroundColor: const Color(0xFF674AEF),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.request_page),
                title: const Text('Case Request'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const CaseRequestsSentPage()));
                  // Navigate to the profile screen
                },
              ),
              ListTile(
                leading: const Icon(Icons.question_answer_outlined),
                title: const Text("Case Quotation"),
                onTap: () {
                  // Navigate to the home screen
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const CauseQuatation();
                  }));
                },
              ),
              ListTile(
                leading: const Icon(Icons.library_books),
                title: const Text('My Cases'),
                onTap: () {
                  // Navigate to the my cases screen
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => const MyCauses()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const RequestSendingPage()));
                  // Navigate to the messages screen
                },
              ),
              ListTile(
                  leading: const Icon(Icons.login_outlined),
                  title: const Text("LogOut"),
                  onTap: () async {
                    await RegisterFormController.instance.logOut(context);
                    if (context.mounted) {
                      if (RegisterFormController.instance.isUserRegistered) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const MainScreen()),
                          (route) => false,
                        );
                      } else {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                          (route) => false,
                        );
                      }
                    }
                  }),
            ])));
  }
}

class LoggingOut extends StatefulWidget {
  const LoggingOut({super.key});

  @override
  State<LoggingOut> createState() => _LoggingOutState();
}

class _LoggingOutState extends State<LoggingOut> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Loading(message: "Logging Out"),
      ),
    );
  }
}
