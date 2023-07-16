import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:find_your_lawyer/database/user_model.dart';
import 'package:find_your_lawyer/registration/api/registration_api.dart';
import 'package:find_your_lawyer/registration/camera_view.dart';
import 'package:find_your_lawyer/registration/controller.dart';
import 'package:find_your_lawyer/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class EditUserDetails extends StatefulWidget {
  const EditUserDetails({Key? key, required this.userData}) : super(key: key);

  final UserModel userData;
  @override
  EditUserDetailsState createState() => EditUserDetailsState();
}

class EditUserDetailsState extends State<EditUserDetails> {
  final formKey = GlobalKey<FormState>();

  CountryModel? countryModel;
  StateModel? stateModel;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  // TextEditingController phoneNumberController = TextEditingController();
  // TextEditingController dobController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController postalController = TextEditingController();

  File? _passportImage;

  @override
  void initState() {
    super.initState();
    fillData();
  }

  void fillData() async {
    await Future.delayed(const Duration(milliseconds: 10));
    nameController.text = widget.userData.name;
    emailController.text = widget.userData.email;
    addressController.text = widget.userData.address;
    stateController.text = widget.userData.state;
    streetController.text = widget.userData.street ?? "";
    cityController.text = widget.userData.city;
    postalController.text = widget.userData.postal;
    // _passportImage = File.fromRawPath(widget.userData.passport);

    //----------Profile-------------------------
    final tempDir = await getTemporaryDirectory();
    File profileFile = await File('${tempDir.path}/image.png').create();
    profileFile.writeAsBytesSync(widget.userData.profile);
    RegisterFormController.instance.setProfile(profileFile);
    //---------Passport---------------------------

    File passportFile = await File('${tempDir.path}/passport.png').create();
    passportFile.writeAsBytesSync(widget.userData.passport);
    setState(() {
      _passportImage = passportFile;
    });
  }

  Future<void> _takePassportPhoto() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _passportImage = File(image.path);
      });
    }
  }

  Future<void> _captureImage() async {
    // final image = await ImagePicker().pickImage(source: ImageSource.camera);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const CameraView(
                  initialDirection: CameraLensDirection.front,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.only(left: 10, right: 10),
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Colors.black,
                    )),
              ),
              const SizedBox(height: 90),
              Center(
                child: InkWell(
                  onTap: _captureImage,
                  child: context.watch<RegisterFormController>().profileImage == null
                      ? const CircleAvatar(
                          backgroundColor: Color(0xFF674AEF),
                          radius: 50,
                          backgroundImage: AssetImage("assets/images/download.png"),
                          //backgroundImage: _image,
                        )
                      : CircleAvatar(
                          backgroundColor: const Color(0xFF674AEF),
                          radius: 50,
                          backgroundImage:
                              FileImage(File(RegisterFormController.instance.profileImage!.path)),
                        ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null) {
                    return "Name is required";
                  }
                  if (value.isEmpty) {
                    return "Name is required";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null) {
                    return "Email is required";
                  }
                  if (value.isEmpty) {
                    return "Email is required";
                  }
                  return null;
                },
              ),
              // const SizedBox(height: 10),
              // TextFormField(
              //   controller: phoneNumberController,
              //   decoration: const InputDecoration(
              //     labelText: 'Phone Number',
              //     border: OutlineInputBorder(),
              //   ),
              //   validator: (value) {
              //     if (value == null) {
              //       return "Phone number is required";
              //     }
              //     if (value.isEmpty) {
              //       return "Phone number is required";
              //     }
              //     return null;
              //   },
              // ),
              // const SizedBox(height: 10),
              // TextFormField(
              //   controller: dobController,
              //   decoration: const InputDecoration(
              //     labelText: 'Date of Birth (YYYY)',
              //     border: OutlineInputBorder(),
              //   ),
              //   validator: (value) {
              //     if (value == null) {
              //       return "Date of Birth is required";
              //     }
              //     if (value.isEmpty) {
              //       return "Date of Birth is required";
              //     }
              //     return null;
              //   },
              // ),
              const SizedBox(height: 10),
              TextFormField(
                controller: addressController,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null) {
                    return "Address is required";
                  }
                  if (value.isEmpty) {
                    return "address is required";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // Consumer<RegisterFormController>(
              //   builder: (context, controller, child) {
              //     if (controller.countries == null) {
              //       controller.getCountries();
              //       return const Center(child: CircularProgressIndicator());
              //     }
              //     for (var element in controller.countries!) {
              //       if (element.value == widget.userData.country) {
              //         countryModel = element;
              //         break;
              //       }
              //     }
              //     return Container(
              //       padding: const EdgeInsets.only(left: 5),
              //       decoration: BoxDecoration(
              //           border: Border.all(color: Colors.grey),
              //           borderRadius: BorderRadius.circular(5)),
              //       child: DropdownButton(
              //         items: controller.countries!
              //             .map((e) => DropdownMenuItem<CountryModel>(
              //                   value: e,
              //                   child: Text(e.name),
              //                 ))
              //             .toList(),
              //         value: countryModel,
              //         hint: const Text("Select Country"),
              //         onChanged: (value) {
              //           log("Country drop down onChanged called");
              //           setState(() {
              //             countryModel = value;
              //             log(countryModel!.name);
              //           });
              //         },
              //       ),
              //     );
              //   },
              // ),
              // const SizedBox(height: 10),
              // countryModel == null
              //     ? const SizedBox()
              //     : Consumer<RegisterFormController>(
              //         builder: (context, controller, child) {
              //           log("coutnry Model selected");
              //           if (controller.states == null) {
              //             controller.getState(countryModel!);
              //             return const Center(child: CircularProgressIndicator());
              //           }
              //           for (var element in controller.states!) {
              //             if (element.stateValue == widget.userData.state) {
              //               stateModel = element;
              //               break;
              //             }
              //           }
              //           return Container(
              //             padding: const EdgeInsets.only(left: 5),
              //             decoration: BoxDecoration(
              //                 border: Border.all(color: Colors.grey),
              //                 borderRadius: BorderRadius.circular(5)),
              //             child: DropdownButton(
              //               hint: const Text("Select State"),
              //               items: controller.states!
              //                   .map((e) =>
              //                       DropdownMenuItem<StateModel>(value: e, child: Text(e.stateName)))
              //                   .toList(),
              //               value: stateModel,
              //               onChanged: (value) {
              //                 setState(() {
              //                   stateModel = value;
              //                 });
              //               },
              //             ),
              //           );
              //         },
              //       ),
              const SizedBox(height: 10),
              // TextFormField(
              //   controller: stateController,
              //   decoration: const InputDecoration(
              //     labelText: 'State',
              //     border: OutlineInputBorder(),
              //   ),
              //   validator: (value) {
              //     if (value == null) {
              //       return "State is required";
              //     }
              //     if (value.isEmpty) {
              //       return "State is required";
              //     }
              //     return null;
              //   },
              // ),
              // const SizedBox(height: 10),
              TextFormField(
                controller: streetController,
                decoration: const InputDecoration(
                  labelText: 'Street',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null) {
                    return "Street is required";
                  }
                  if (value.isEmpty) {
                    return "Street is required";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: cityController,
                decoration: const InputDecoration(
                  labelText: 'City',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null) {
                    return "City is required";
                  }
                  if (value.isEmpty) {
                    return "City is required";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: postalController,
                decoration: const InputDecoration(
                  labelText: 'Postal Code',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null) {
                    return "Postal Code is required";
                  }
                  if (value.isEmpty) {
                    return "Postal Code is required";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: _takePassportPhoto,
                child: Container(
                  margin: const EdgeInsets.only(right: 10, left: 10),
                  color: Colors.grey[300],
                  width: 70.0,
                  height: 70.0,
                  child: Center(
                    child: Row(
                      children: [
                        SizedBox(
                            width: 200,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: _passportImage == null
                                  ? const Text("Attach Passport")
                                  : Image.file(
                                      File(_passportImage!.path),
                                      height: 60,
                                    ),
                            )),
                        const Icon(Icons.add)
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const SizedBox(
                height: 10,
              ),
              context.watch<RegisterFormController>().isRegistering
                  ? const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Updating",
                          style: TextStyle(fontSize: 20),
                        ),
                        CircularProgressIndicator()
                      ],
                    )
                  : Material(
                      color: const Color(0xFF674AEF),
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: _registerUser,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 80),
                          child: const Center(
                            child: Text("Update",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  wordSpacing: 2,
                                )),
                          ),
                        ),
                      ),
                    ),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }

// ...

  Future<void> _registerUser() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    if ( //stateModel == null ||
        RegisterFormController.instance.profileImage == null || _passportImage == null) {
      return;
    }
    RegisterFormController.instance.isRegistering = true;
    final url = Uri.parse('http://117.200.73.2:7075/lawyer/public/api/updateUser');

    final name = nameController.text;
    final email = emailController.text;
    // final phoneNumber = phoneNumberController.text;
    final phoneNumber = widget.userData.phone;
    // final dob = dobController.text;
    final address = addressController.text;

    final street = streetController.text;
    final city = cityController.text;
    final postal = postalController.text;

    final request = http.MultipartRequest('POST', url);

    final passportImageFile = await http.MultipartFile.fromPath(
      'passport',
      _passportImage!.path,
    );
    request.files.add(passportImageFile);

    final profileImageFile = await http.MultipartFile.fromPath(
      'profile',
      RegisterFormController.instance.profileImage!.path,
    );
    request.files.add(profileImageFile);

    request.fields['name'] = name;
    request.fields['email'] = email;
    request.fields['phone'] = phoneNumber;
    request.fields['dob'] = "";
    request.fields['address'] = address;
    request.fields['country'] =
        countryModel != null ? countryModel!.value : widget.userData.country;
    request.fields['state'] = stateModel != null ? stateModel!.stateValue : widget.userData.state;
    request.fields['street'] = street;
    request.fields['city'] = city;
    request.fields['postal'] = postal;
    request.fields['token'] = widget.userData.token;

    try {
      log('=========LOG==============================');
      log(request.toString());
      log('=========================================');

      for (var element in request.fields.keys) {
        log("$element: ${request.fields[element] ?? ''}");
      }
      for (var element in request.files) {
        log("${element.field}: ${element.filename ?? ''}");
      }
      log('==========================================');
      final response = await request.send();
      log("Status Code: ${response.statusCode}");
      log(response.reasonPhrase.toString());
      log('==========================================');
      http.Response httpResponse = await http.Response.fromStream(response);
      var json = jsonDecode(httpResponse.body);
      if (response.statusCode == 200) {
        log('Registration successful');

        if (json["STATUS"] == "ERROR") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(json["MSG"])));
          return;
        }
        // String token = json["TOKEN"];
        RegisterFormController.instance.saveUserData(UserModel(
            name: name,
            address: address,
            city: city,
            // dob: dob,
            email: email,
            passport: await _passportImage!.readAsBytes(),
            phone: phoneNumber,
            postal: postal,
            profile: await RegisterFormController.instance.profileImage!.readAsBytes(),
            state: stateModel != null ? stateModel!.stateValue : widget.userData.state,
            country: countryModel != null ? countryModel!.value : widget.userData.country,
            street: street,
            token: widget.userData.token));
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const ProfileScreen(),
        ));
      } else {
        log('Updation failed');
        log(json["MSG"] ?? "");
      }
    } on http.ClientException {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("ClientException: Connection Reset by Peer\nPlease Try Again")));
      }
    } catch (e) {
      log('Error during Updation: $e');
    }
    RegisterFormController.instance.isRegistering = false;
  }
}
