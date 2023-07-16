import 'dart:convert';
import 'dart:developer';

import 'package:find_your_lawyer/controllers/lawyers_controller.dart';
import 'package:find_your_lawyer/database/lawyer_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'details.dart';

class seeall extends StatefulWidget {
  @override
  State<seeall> createState() => _seeallState();
}

class _seeallState extends State<seeall> {
  List imagList = [
    "Lawyer-Transparent-Image",
    "35292-2-lawyer-transparent",
    "Male-Lawyer-PNG-Clipart",
    "35292-2-lawyer-transparent",
    "Lawyer-Transparent-Image",
    "35292-2-lawyer-transparent",
    "Male-Lawyer-PNG-Clipart",
    "35292-2-lawyer-transparent",
  ];

  List Name = [
    "John",
    "John",
    "John",
    "John",
    "Arun",
    "Arun",
    "Arun",
    "Arun",
    "Arun"
  ];

  List Specialization = [
    "John",
    "John",
    "John",
    "John",
    "John",
    "John",
    "John",
    "John",
  ];

  List<LawyerModel> searchResults = [];

  void _onSearchChanged(String query) {
    var lawyerProvider =
        Provider.of<LawyersController>(context, listen: false).lawyers;
    if (query.isEmpty) {
      setState(() {
        searchResults = [];
      });
      return;
    }

    List<LawyerModel> results = lawyerProvider
        .where((item) =>
            item.lawyerMastrName.toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {
      searchResults = results;
      log('search results lenght ${searchResults.length}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding:
                const EdgeInsets.only(top: 15, right: 15, bottom: 10, left: 15),
            decoration: const BoxDecoration(
                color: Color(0xFF674AEF),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0, bottom: 15),
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios_new_outlined,
                              color: Colors.white,
                            )),
                      ),
                      const Text("Find Your Lawyer",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                              wordSpacing: 2)),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5, bottom: 20),
                  width: MediaQuery.of(context).size.width,
                  height: 55,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    onChanged: (value) {
                      _onSearchChanged(value);
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search here....",
                        helperStyle:
                            TextStyle(color: Colors.black.withOpacity(0.5)),
                        prefixIcon: const Icon(
                          Icons.search,
                          size: 25,
                        )),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Consumer<LawyersController>(builder: (context, controller, child) {
            final lawyers =
                searchResults.length == 0 ? controller.lawyers : searchResults;
            return GridView.builder(
                itemCount: lawyers.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio:
                        (MediaQuery.of(context).size.height - 50 - 25) /
                            (4 * 240),
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfilePage(
                            name: lawyers[index].lawyerMastrName,
                            category: lawyers[index].lawyerMastrType,
                            image: imagList[0],
                            lawyerId: lawyers[index].lawyerMastrToken,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xFFF5F3FF)),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Center(
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    'http://117.200.73.2:7075/lawyer/public/' +
                                        lawyers[index]
                                            .lawyerMastrProfilePic
                                            .toString()),
                                backgroundColor: Colors.white,
                                radius: 50,
                              ),
                            ),
                          ),
                          Text(
                            lawyers[index].lawyerMastrName,
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Colors.black.withOpacity(0.6)),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${lawyers[index].lawyerMastrType} LAWYER",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black.withOpacity(0.5)),
                          )
                        ],
                      ),
                    ),
                  );
                });
          })
        ],
      ),
    );
  }
}
