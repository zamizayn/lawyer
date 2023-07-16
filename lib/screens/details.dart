import 'package:find_your_lawyer/registration/controller.dart';
import 'package:find_your_lawyer/screens/chat_screen.dart';
import 'package:find_your_lawyer/screens/send_request.dart';
import 'package:flutter/material.dart';

import '../registration/mobilenumber.dart';

class ProfilePage extends StatefulWidget {
  final String name;
  final String category;
  final String image;
  final String lawyerId;

  const ProfilePage(
      {super.key,
      required this.name,
      required this.category,
      required this.image,
      required this.lawyerId});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final double coverHeight = 280;
  final double profile = 144;
  final top = 450;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          buildTop(),
          buildContent(),
        ],
      ),
    );
  }

  Widget buildCoverImage() => Container(
        color: Colors.grey,
        child: Stack(
          children: [
            Image.network(
              widget.image,
              width: double.infinity,
              height: coverHeight,
              fit: BoxFit.cover,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      );

  Widget buildProfilePicture() => CircleAvatar(
        radius: 60,
        // backgroundColor: Colors.grey.shade800,
        backgroundImage: AssetImage(
          widget.image,
        ),
      );

  Widget buildTop() {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 40),
          child: buildCoverImage(),
        ),
        Positioned(
          top: 200,
          child: buildProfilePicture(),
        ),
      ],
    );
  }

  Widget buildContent() => Column(
        children: [
          const SizedBox(height: 8),
          Text(
            widget.name,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            "Criminal Lawyer",
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Material(
                  color: Colors.blue[700],
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    onTap: () {
                      if (RegisterFormController.instance.userData == null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Phn_fill()));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SendRequest(
                                      lawyerId: widget.lawyerId,
                                    )));
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      child: const Center(
                        child: Text("Request",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              wordSpacing: 2,
                            )),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        radius: 18,
                        child: Material(
                          shape: const CircleBorder(),
                          clipBehavior: Clip.hardEdge,
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              if (RegisterFormController.instance.userData ==
                                  null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Phn_fill()),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChatScreen(
                                            username: widget.name,
                                            profilePicUrl: widget.image,
                                          )),
                                );
                              }
                            },
                            child: const Center(child: Icon(Icons.message)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          const SizedBox(height: 10),
          buildProfileInfo('Law Firm Name', 'Michael Law Firm'),
          buildProfileInfo('Specialization', 'Criminal'),
          buildProfileInfo(
              'Address', '123 Main St, City 1, State 1, Zip 1, Country 1'),
          buildProfileInfo('Country', 'India'),
          buildProfileInfo('State', 'State 1'),
          buildProfileInfo('City', 'City 1'),
        ],
      );

  Widget buildProfileInfo(String label, String value) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Text(
              '$label: ',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Expanded(
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      );
}
