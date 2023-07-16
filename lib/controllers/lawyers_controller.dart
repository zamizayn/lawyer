import 'package:find_your_lawyer/database/lawyer_model.dart';
import 'package:find_your_lawyer/database/quotation_model.dart';
import 'package:find_your_lawyer/registration/controller.dart';
import 'package:find_your_lawyer/services/lawyer_services.dart';
import 'package:flutter/material.dart';

class LawyersController extends ChangeNotifier {
  LawyersController._internal();
  static final instance = LawyersController._internal();

  List<LawyerModel> lawyers = [];
  List<LawyerModel> searchedLawyers = [];
  TextEditingController searchController = TextEditingController();

  String filterCategory = '';
  void setfilterCategory(String category) {
    filterCategory = category;
    notifyListeners();
  }

  Future<List<LawyerModel>> getLawyers() async {
    lawyers = await LawyerServices.getAllLawyers();
    return lawyers;
  }

  List<QuotationModel> quotationList = [];
  Future<void> getQuotationList() async {
    quotationList =
        await LawyerServices.getQuotationList(RegisterFormController.instance.userData!.token);
    notifyListeners();
  }

  List<QuoteRequest> requestsList = [];
  Future<void> getRequestsList() async {
    requestsList =
        await LawyerServices.getRequestList(RegisterFormController.instance.userData!.token);
    notifyListeners();
  }

  String? replyLoadDialogue;
  Future<void> replyQuotation(ReplyQuotation reply, int quotationID) async {
    if (reply == ReplyQuotation.accept) {
      replyLoadDialogue = "Accepting";
      notifyListeners();
      await LawyerServices.acceptQuoatation(quotationID);
    } else {
      replyLoadDialogue = "Rejecting";
      notifyListeners();
      await LawyerServices.rejectQuoatation(quotationID);
    }
    replyLoadDialogue == null;
  }

  void searchLawyers(String search) {
    searchedLawyers = lawyers
        .where((element) =>
            element.lawyerMastrName.toLowerCase().contains(search.toLowerCase()) ||
            element.lawyerMastrType.toLowerCase().contains(search.toLowerCase()))
        .toList();
    notifyListeners();
  }
}

enum ReplyQuotation {
  accept,
  reject;
}
