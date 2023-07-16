import 'package:find_your_lawyer/controllers/lawyers_controller.dart';
import 'package:find_your_lawyer/database/lawyer_model.dart';
import 'package:find_your_lawyer/registration/controller.dart';
import 'package:find_your_lawyer/registration/mobilenumber.dart';
import 'package:find_your_lawyer/screens/details.dart';
import 'package:find_your_lawyer/screens/nav_drawer.dart';
import 'package:find_your_lawyer/screens/see_all.dart';
import 'package:find_your_lawyer/screens/users_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  List<String> catNames = [
    "Family",
    "Criminal",
    "Intellectual",
    "General",
    "Corporate",
  ];
  List<Color> catColor = [
    const Color(0xFFFFCF2F),
    const Color(0xFF6FE08D),
    const Color(0xFF61BDFD),
    const Color(0xFFFC7C7F),
    const Color(0xFFCB84FB),
    const Color(0xFF78E667),
  ];
  List<Icon> catIcons = [
    const Icon(Icons.family_restroom, color: Colors.white, size: 30),
    const Icon(Icons.local_police, color: Colors.white, size: 30),
    const Icon(Icons.category, color: Colors.white, size: 30),
    const Icon(Icons.gavel, color: Colors.white, size: 30),
    const Icon(Icons.corporate_fare, color: Colors.white, size: 30),
  ];
  List<String> imagList = [
    "Lawyer-Transparent-Image",
    "35292-2-lawyer-transparent",
    "Male-Lawyer-PNG-Clipart",
    "35292-2-lawyer-transparent",
  ];
  List<String> Name = [
    "John",
    "John",
    "John",
    "John",
  ];
  List<String> Specialization = [
    "John",
    "John",
    "John",
    "John",
  ];

  HomeScreen({super.key});
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      key: _scaffoldKey,
      drawer: context.watch<RegisterFormController>().isUserRegistered
          ? const NavDrawer()
          : null,
      appBar: PreferredSize(
          preferredSize: const Size(0, 0),
          child: Container(
            color: const Color(0xFF674AEF),
          )),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                    top: 15, right: 15, bottom: 10, left: 15),
                decoration: const BoxDecoration(
                  color: Color(0xFF674AEF),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        context.watch<RegisterFormController>().userData == null
                            ? const SizedBox()
                            : InkWell(
                                onTap: () {
                                  if (RegisterFormController
                                      .instance.isUserRegistered) {
                                    _scaffoldKey.currentState!.openDrawer();
                                  }
                                },
                                child: const Icon(
                                  Icons.dashboard,
                                  size: 25,
                                  color: Colors.white,
                                ),
                              ),
                        const Spacer(),
                        Consumer<RegisterFormController>(
                            builder: (context, provider, _) {
                          return provider.isLogined
                              ? const Icon(
                                  Icons.notifications,
                                  size: 25,
                                  color: Colors.white,
                                )
                              : InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Phn_fill(),
                                        // const Phn_fill(),
                                        // const Registration(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                );
                        }),
                        const SizedBox(width: 15),
                        context.watch<RegisterFormController>().userData == null
                            ? const SizedBox()
                            : InkWell(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UserList())),
                                child: const Icon(
                                  Icons.chat,
                                  size: 25,
                                  color: Colors.white,
                                ),
                              ),
                        // ValueListenableBuilder(
                        //     valueListenable: DB.instance.userData.listenable(),
                        //     builder: (context, userData, child) {
                        //       if (userData.get("profileImage") == null) {
                        //         return const CircleAvatar(
                        //           backgroundImage: AssetImage("assets/images/download.png"),
                        //         );
                        //       }
                        //       return CircleAvatar(
                        //         backgroundImage: MemoryImage(userData.get("profileImage")),
                        //       );
                        //     }),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 3, bottom: 15),
                      child: Text(
                        "Find Your Lawyer",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                            wordSpacing: 2),
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
                        controller: LawyersController.instance.searchController,
                        onChanged: (value) {
                          LawyersController.instance.searchLawyers(value);
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search here....",
                            helperStyle:
                                TextStyle(color: Colors.black.withOpacity(0.5)),
                            prefixIcon: const Icon(Icons.search, size: 25)),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 10),
                child: ValueListenableBuilder(
                    valueListenable:
                        LawyersController.instance.searchController,
                    builder: (context, searchController, child) {
                      if (searchController.text.isNotEmpty) {
                        return const _SearchResult();
                      }
                      return Consumer<LawyersController>(
                          builder: (context, controller, child) {
                        return Column(
                          children: [
                            GridView.builder(
                              itemCount: catNames.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                              ),
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        if (controller.filterCategory ==
                                            catNames[index].toLowerCase()) {
                                          controller.setfilterCategory('');
                                        } else {
                                          LawyersController.instance
                                              .setfilterCategory(catNames[index]
                                                  .toLowerCase());
                                        }
                                      },
                                      child: AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 200),
                                        height: controller.filterCategory ==
                                                catNames[index].toLowerCase()
                                            ? 60
                                            : 50,
                                        width: controller.filterCategory ==
                                                catNames[index].toLowerCase()
                                            ? 60
                                            : 50,
                                        decoration: BoxDecoration(
                                            color: catColor[index],
                                            shape: BoxShape.circle),
                                        child: Center(child: catIcons[index]),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      catNames[index],
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                );
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Top Lawyers",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => seeall()));
                                  },
                                  child: const Text(
                                    "See All",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: Color(0xFF674AEF)),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Consumer<LawyersController>(
                                builder: (context, controller, child) {
                              List<LawyerModel> lawyers = controller.lawyers
                                  .where((element) => element.lawyerMastrType
                                      .toLowerCase()
                                      .contains(controller.filterCategory))
                                  .toList();
                              return GridView.builder(
                                itemCount:
                                    lawyers.length > 4 ? 4 : lawyers.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio:
                                      (MediaQuery.of(context).size.height -
                                              50 -
                                              25) /
                                          (4 * 240),
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                ),
                                itemBuilder: (context, index) {
                                  String image;
                                  if (lawyers[index].lawyerMastrProfilePic !=
                                      null) {
                                    image =
                                        "http://117.200.73.2:7075/lawyer/public/${lawyers[index].lawyerMastrProfilePic!}";
                                  } else {
                                    // image = imagList[index];
                                    image =
                                        "https://e9g2x6t2.rocketcdn.me/wp-content/uploads/2020/11/Professional-Headshot-Poses-Blog-Post.jpg";
                                  }
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProfilePage(
                                            name:
                                                lawyers[index].lawyerMastrName,
                                            category:
                                                lawyers[index].lawyerMastrType,
                                            image: image,
                                            lawyerId:
                                                lawyers[index].lawyerMastrToken,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: const Color(0xFFF5F3FF),
                                      ),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Center(
                                              // child: Image.network(
                                              //   image,
                                              //   width: 100,
                                              //   height: 100,
                                              // ),
                                              child: CircleAvatar(
                                                radius: 50,
                                                backgroundColor: Colors.white,
                                                backgroundImage:
                                                    NetworkImage(image),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            lawyers[index].lawyerMastrName,
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  Colors.black.withOpacity(0.6),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "${lawyers[index].lawyerMastrType} Lawyer",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black
                                                    .withOpacity(0.5)),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }),
                          ],
                        );
                      });
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchResult extends StatelessWidget {
  const _SearchResult();

  @override
  Widget build(BuildContext context) {
    return Consumer<LawyersController>(builder: (context, controller, child) {
      return Column(
        children: [
          Row(
            children: [
              const Text(
                "Search Result",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              TextButton(
                  onPressed: () {
                    controller.searchController.clear();
                  },
                  child: const Text("Clear"))
            ],
          ),
          ...List.generate(controller.searchedLawyers.length, (index) {
            LawyerModel lawyerModel = controller.searchedLawyers[index];
            String image;
            if (lawyerModel.lawyerMastrProfilePic != null) {
              image =
                  "http://117.200.73.2:7075/lawyer/public/${lawyerModel.lawyerMastrProfilePic!}";
            } else {
              // image = imagList[index];
              image =
                  "https://e9g2x6t2.rocketcdn.me/wp-content/uploads/2020/11/Professional-Headshot-Poses-Blog-Post.jpg";
            }
            return ListTile(
              onTap: () {
                controller.searchController.clear();

                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProfilePage(
                      name: lawyerModel.lawyerMastrName,
                      category: lawyerModel.lawyerMastrType,
                      lawyerId: lawyerModel.lawyerMastrToken,
                      image: image),
                ));
              },
              leading: CircleAvatar(backgroundImage: NetworkImage(image)),
              title: Text(controller.searchedLawyers[index].lawyerMastrName),
              subtitle: Text(
                  "category: ${controller.searchedLawyers[index].lawyerMastrType}"),
            );
          })
        ],
      );
    });
  }
}
