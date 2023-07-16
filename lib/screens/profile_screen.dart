import 'dart:developer';
import 'package:find_your_lawyer/registration/edit_user.dart';
import 'package:find_your_lawyer/utils/utils.dart';
import 'package:flutter/material.dart';
import '../database/user_model.dart';
import '../registration/controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    UserModel userData = RegisterFormController.instance.userData!;
    log(userData.token);
    Size size = MediaQuery.of(context).size;
    return ColoredBox(
      color: Colors.transparent,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                // ColoredBox(
                //   color: Colors.white,
                //   child: Padding(
                //     padding: const EdgeInsets.all(10),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.end,
                //       children: [
                //         InkWell(
                //             onTap: () {
                //               log("Navigating to Edit Screen");
                //               Navigator.of(context).push(MaterialPageRoute(
                //                 builder: (context) =>
                //                     EditUserDetails(userData: userData),
                //               ));
                //             },
                //             child: const Icon(
                //               Icons.edit,
                //               size: 30,
                //               color: Colors.white,
                //             ))
                //       ],
                //     ),
                //   ),
                // ),

                Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://blog.ipleaders.in/wp-content/uploads/2014/07/Tulsa-family-court.jpg'),
                          fit: BoxFit.cover),
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(20)),
                      color: Color(0xFF674AEF)),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                EditUserDetails(userData: userData),
                          ));
                        },
                        child: Align(
                          alignment: Alignment.topRight,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.edit,
                                color: Color(0xFF674AEF),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          radius: size.width / 6,
                          backgroundImage: MemoryImage(userData.profile),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        userData.name,
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(color: Colors.white),
                      ),
                      Text("${userData.city},${userData.state}",
                          style: const TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 22,
                              color: Colors.white)),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: FittedBox(
                          child: OutlinedButton.icon(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                padding: MaterialStatePropertyAll(
                                    EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5)),
                                iconSize: MaterialStatePropertyAll(35),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FullScreenImage(
                                              path: userData.passport,
                                              fileType: FileType.Memory,
                                            )));
                              },
                              icon: const Icon(Icons.wallet),
                              label: const Text(
                                "View Passport",
                                style: TextStyle(fontSize: 20),
                              )),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const SizedBox(height: 20),
                      _infoBuilder(
                          iconData: Icons.email,
                          title: "Email:",
                          value: userData.email),
                      _infoBuilder(
                          title: "Phone:",
                          value: userData.phone,
                          iconData: Icons.phone),
                      _infoBuilder(
                          title: "Address:",
                          value: userData.address,
                          iconData: Icons.place),
                      _infoBuilder(
                          title: "Postal:",
                          value: userData.postal,
                          iconData: Icons.location_city),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoBuilder(
      {required String title, required value, required IconData iconData}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                iconData,
                color: const Color(0xFF674AEF),
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              const Spacer(),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
          const Divider(thickness: 2),
        ],
      ),
    );
  }
}
