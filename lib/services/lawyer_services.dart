import 'dart:convert';
import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:find_your_lawyer/database/lawyer_model.dart';
import 'package:find_your_lawyer/database/quotation_model.dart';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

class LawyerServices {
  static Future<List<LawyerModel>> getAllLawyers() async {
    List<LawyerModel> lawyers = [];
    try {
      http.Response response =
          await http.get(Uri.parse("http://117.200.73.2:7075/lawyer/public/api/getAllLawyers"));
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        if (json["STATUS"] == "SUCCESS") {
          for (var element in json["data"]) {
            if (element["lawyer_mastr_token"] != null) {
              lawyers.add(LawyerModel.fromJson(element));
            }
          }
          return lawyers;
        }
        return lawyers;
      } else {
        log("Error getting lawyers");
        return lawyers;
      }
    } catch (e) {
      log(e.toString());
      return lawyers;
    }
  }

  static Future<bool> sendRequest(
      {required String title,
      required String description,
      required XFile attachment,
      required String token,
      required String lawyerId}) async {
    try {
      log(title);
      log(description);
      log(token);
      final request = http.MultipartRequest(
          "POST", Uri.parse("http://117.200.73.2:7075/lawyer/public/api/requestForQuote"));
      request.fields['title'] = title;
      request.fields['description'] = description;
      request.fields['token'] = token;
      request.fields['lawyer_public_id'] = lawyerId;
      final attachmentFile = await http.MultipartFile.fromPath("attachment", attachment.path);
      request.files.add(attachmentFile);
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        log("Request Successful");
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  static Future<List<QuotationModel>> getQuotationList(String token) async {
    List<QuotationModel> quotiationList = [];
    if (kDebugMode) {
      token = "4c0fd6d0-afad-4749-857a-44fbd2601b38";
    }
    try {
      http.Response response = await http.post(
          Uri.parse("http://117.200.73.2:7075/lawyer/public/api/getQuotationListForUser"),
          body: {"token": token});
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        if (json["STATUS"] == "SUCCESS") {
          for (var element in json["DATA"]) {
            if (element["quoteslawyer"]["lawyer_mastr_token"] != null) {
              quotiationList.add(QuotationModel.fromJson(element));
            }
          }
          return quotiationList;
        }
      } else {
        log(response.statusCode.toString());
      }
    } catch (e) {
      log(e.toString());
    }
    return quotiationList;
  }

  static Future<List<QuoteRequest>> getRequestList(String token) async {
    List<QuoteRequest> requestsList = [];
    log(token);
    // if (kDebugMode) {
    //   token = "4c0fd6d0-afad-4749-857a-44fbd2601b38";
    // }
    try {
      http.Response response = await http.post(
          Uri.parse("http://117.200.73.2:7075/lawyer/public/api/listQuotes"),
          body: {"token": token});
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);

        for (var element in json) {
          requestsList.add(QuoteRequest.fromJson(element));
        }
        return requestsList;
      } else {
        log(response.statusCode.toString());
      }
    } catch (e) {
      log(e.toString());
    }
    return requestsList;
  }

  static Future<void> acceptQuoatation(int quotationID) async {
    try {
      http.Response response = await http.post(
          Uri.parse("http://117.200.73.2:7075/lawyer/public/api/acceptQuotation"),
          body: {"quotation_id": quotationID.toString()});
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        log(json.toString());
        if (json["STATUS"] == "SUCCESS") {
          log(response.statusCode.toString());
        }
      } else {
        log(response.statusCode.toString());
      }
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<void> rejectQuoatation(int quotationID) async {
    try {
      http.Response response = await http.post(
          Uri.parse("http://117.200.73.2:7075/lawyer/public/api/rejectQuotation"),
          body: {"quotation_id": quotationID.toString()});
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        log(json.toString());
        if (json["STATUS"] == "SUCCESS") {
          log(response.statusCode.toString());
        }
      } else {
        log(response.statusCode.toString());
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
