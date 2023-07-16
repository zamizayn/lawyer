import 'package:find_your_lawyer/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class UserList extends StatelessWidget {
  List<String> profilePics = [
    "https://cdn.pixabay.com/photo/2021/04/05/12/39/man-6153298_1280.jpg",
    "https://st4.depositphotos.com/2760050/24301/i/600/depositphotos_243011410-stock-photo-man-with-bristle-on-calm.jpg",
    "https://images.pexels.com/photos/8350416/pexels-photo-8350416.jpeg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQIbXiFSs6bFoTbWt2tlmzOUuntjbnmJfjgg&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQIbXiFSs6bFoTbWt2tlmzOUuntjbnmJfjgg&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQIbXiFSs6bFoTbWt2tlmzOUuntjbnmJfjgg&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQIbXiFSs6bFoTbWt2tlmzOUuntjbnmJfjgg&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQIbXiFSs6bFoTbWt2tlmzOUuntjbnmJfjgg&usqp=CAU",
    "https://cdn.pixabay.com/photo/2021/04/05/12/39/man-6153298_1280.jpg",
    "https://st4.depositphotos.com/2760050/24301/i/600/depositphotos_243011410-stock-photo-man-with-bristle-on-calm.jpg",
    "https://images.pexels.com/photos/8350416/pexels-photo-8350416.jpeg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQIbXiFSs6bFoTbWt2tlmzOUuntjbnmJfjgg&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQIbXiFSs6bFoTbWt2tlmzOUuntjbnmJfjgg&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQIbXiFSs6bFoTbWt2tlmzOUuntjbnmJfjgg&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQIbXiFSs6bFoTbWt2tlmzOUuntjbnmJfjgg&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQIbXiFSs6bFoTbWt2tlmzOUuntjbnmJfjgg&usqp=CAU",
  ];
  List<String> filteredProfilePics = [];

  TextEditingController searchController = TextEditingController();

  UserList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Chats",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 22,
            color: Colors.white,
            fontFamily: "Roboto",
          ),
        ),
        leading: Container(
          padding: const EdgeInsets.only(left: 16, top: 3, bottom: 3),
          child: const CircleAvatar(
            backgroundColor: Colors.transparent,
          ),
        ),
        actions: <Widget>[
          CircleAvatar(
            backgroundColor: const Color.fromRGBO(51, 51, 51, 1),
            child: IconButton(
              icon: const Icon(
                Icons.photo_camera,
                size: 22,
                color: Color.fromRGBO(195, 195, 195, 1),
              ),
              onPressed: () {},
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          CircleAvatar(
            backgroundColor: const Color.fromRGBO(51, 51, 51, 1),
            child: IconButton(
              icon: const Icon(
                Icons.edit,
                size: 22,
                color: Color.fromRGBO(195, 195, 195, 1),
              ),
              onPressed: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context)=>UIone()));
              },
            ),
          ),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.only(left: 16, top: 4, bottom: 4),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Color.fromRGBO(51, 51, 51, 1),
              ),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  filterProfiles(value);
                },
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(
                    Icons.search,
                    color: Color.fromRGBO(159, 159, 159, 1),
                  ),
                  hintText: "Search",
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(159, 159, 159, 1),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 16, right: 16, top: 8),
            height: 800,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(
                          username: 'john',
                          profilePicUrl:
                              'https://cdn.pixabay.com/photo/2021/04/05/12/39/man-6153298_1280.jpg',
                          // username: "User ${index + 1}",
                          // profilePicUrl: filteredProfilePics[index],
                        ),
                      ),
                    );
                  },
                  contentPadding: const EdgeInsets.only(bottom: 10, right: 8),
                  leading: Stack(
                    children: <Widget>[
                      Container(
                        height: 60,
                        width: 60,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          color: Color.fromRGBO(51, 51, 51, 1),
                        ),
                        child: ClipOval(
                          child: Image.network(
                            profilePics[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        child: Container(
                          height: (index % 2 == 0) ? 18 : 0,
                          width: 18,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(9)),
                            color: Colors.green,
                            border: Border.all(
                              color: Colors.black,
                              width: 3,
                            ),
                          ),
                        ),
                        bottom: 0,
                        right: 0,
                      ),
                    ],
                  ),
                  title: const Padding(
                    padding: EdgeInsets.only(bottom: 6),
                    child: Text(
                      "Zidoun Mohamed",
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  subtitle: const Text(
                    "This is a message from Zidoun Mohamed",
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(123, 123, 123, 1),
                    ),
                  ),
                  trailing: Icon(
                    Icons.check_circle,
                    size: 20,
                    color: (index % 2 == 0)
                        ? const Color.fromRGBO(101, 107, 115, 1)
                        : Colors.transparent,
                  ),
                );
              },
              itemCount: 10,
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 50,
        color: Colors.black,
        padding: const EdgeInsets.only(left: 50, right: 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 40,
                  width: 40,
                  child: const Icon(
                    FontAwesomeIcons.message,
                    color: Colors.blueAccent,
                  ),
                ),
                Positioned(
                  child: Container(
                    height: 21,
                    width: 21,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10.5)),
                      color: Colors.redAccent,
                      border: Border.all(color: Colors.black, width: 3),
                    ),
                    child: const Center(
                      child: Text(
                        "2",
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  top: 2,
                  right: 0,
                ),
              ],
            ),
            Container(
              height: 40,
              width: 40,
              child: const Icon(
                FontAwesomeIcons.video,
                color: Colors.blueAccent,
              ),
            ),
            Container(
              height: 40,
              width: 40,
              child: const Icon(
                FontAwesomeIcons.person,
                color: Colors.blueAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void filterProfiles(String query) {
    filteredProfilePics.clear();

    if (query.isNotEmpty) {
      filteredProfilePics = profilePics.where((pic) => pic.contains(query.toLowerCase())).toList();
    } else {
      filteredProfilePics.addAll(profilePics);
    }

    // setState(() {}); // Remove this line as it is not required in a StatelessWidget
  }
}
