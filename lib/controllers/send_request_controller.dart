import 'package:find_your_lawyer/registration/controller.dart';
import 'package:find_your_lawyer/services/lawyer_services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SendRequestController extends ChangeNotifier {
  static final instance = SendRequestController._internal();
  SendRequestController._internal();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController caseTitle = TextEditingController();
  TextEditingController caseDescription = TextEditingController();
  XFile? attachment;
  SendRequestType sendRequestType = SendRequestType.askOpinion;
  bool isSubmitting = false;

  void setRequestType(SendRequestType sendRequestType) {
    this.sendRequestType = sendRequestType;
    notifyListeners();
  }

  void submit(BuildContext context, String lawyerId) async {
    FocusScope.of(context).unfocus();
    if (!formKey.currentState!.validate()) {
      return;
    }
    if (attachment == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Please Add attachment!")));
      return;
    }
    isSubmitting = true;
    bool isSuccess = await LawyerServices.sendRequest(
        title: caseTitle.text,
        description: caseDescription.text,
        attachment: attachment!,
        token: RegisterFormController.instance.userData!.token,
        lawyerId: lawyerId);

    if (isSuccess && context.mounted) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Request Success")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Request failed!!")));
    }

    isSubmitting = false;
    notifyListeners();
  }

  void addAttachment() async {
    attachment = await ImagePicker().pickImage(source: ImageSource.gallery);
    notifyListeners();
  }
}

enum SendRequestType { askOpinion, assignCase }
