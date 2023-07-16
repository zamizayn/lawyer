import 'package:find_your_lawyer/controllers/lawyers_controller.dart';
import 'package:find_your_lawyer/database/quotation_model.dart';
import 'package:find_your_lawyer/registration/controller.dart';
import 'package:find_your_lawyer/screens/home_screens.dart';
import 'package:find_your_lawyer/screens/main_screen.dart';
import 'package:find_your_lawyer/screens/request_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'case_request_detail_view.dart';
// import 'package:untitled10/drawer/quatation_page.dart';

// import 'case_request_details.dart';

class CaseRequestsSentPage extends StatelessWidget {
  const CaseRequestsSentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Case Requests', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          onPressed: () {
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
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      body: !RegisterFormController.instance.isUserRegistered
          ? const Center(
              child: Text("No Data"),
            )
          : FutureBuilder(
              future: LawyersController.instance.getRequestsList(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return Consumer<LawyersController>(builder: (context, controller, child) {
                  if (controller.requestsList.isEmpty) {
                    return const Center(
                      child: Text("No Requests"),
                    );
                  }
                  List<QuoteRequest> requestList = controller.requestsList;
                  return ListView.builder(
                      itemCount: requestList.length,
                      padding: const EdgeInsets.all(16.0),
                      itemBuilder: (
                        context,
                        index,
                      ) {
                        var request = requestList[index];
                        String startDateString = "Date Here";
                        if (request.requestCreatnDate != null) {
                          DateTime startDate = DateTime.parse(request.requestCreatnDate!);
                          String month = startDate.month.toString().length == 1
                              ? "0${startDate.month}"
                              : startDate.month.toString();
                          String day = startDate.day.toString().length == 1
                              ? "0${startDate.day}"
                              : startDate.day.toString();
                          startDateString = "$day-$month-${startDate.year}";
                        }
                        return Column(
                          children: <Widget>[
                            Card(
                              elevation: 4.0,
                              child: ListTile(
                                title: Text(request.requestTitle ?? "No Title"),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(request.requestDescription),
                                    const SizedBox(height: 4.0),
                                    Text("Request Date: $startDateString"),
                                  ],
                                ),
                                trailing: Builder(builder: (context) {
                                  String text = "Pending";

                                  Color color = Colors.orange;

                                  if (request.requestStatsFlg == null) {
                                    text = "Pending";
                                    color = Colors.orange;
                                  } else {
                                    if (request.requestStatsFlg == "P") {
                                      text = "Pending";
                                      color = Colors.orange;
                                    } else if (request.requestStatsFlg == "A") {
                                      text = "Accepted";
                                      color = Colors.green;
                                    } else if (request.requestStatsFlg == "R") {
                                      text = "Rejected";
                                      color = Colors.red;
                                    } else if (request.requestStatsFlg == "O") {
                                      text = "Open";
                                      color = Colors.blue;
                                    }
                                  }

                                  return Container(
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                                    decoration: BoxDecoration(
                                      color: color,
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    child: Text(
                                      text,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  );
                                }),
                                onLongPress: () {
                                  // Show confirmation dialog to cancel the request
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("Cancel Case Request"),
                                        content: const Text(
                                            "Are you sure you want to cancel this case request?"),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text("Cancel"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: const Text("Confirm"),
                                            onPressed: () {
                                              // Perform cancellation logic here
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => RequestDetailView(
                                                quoteRequest: request,
                                              )));
                                  // Navigate to case view page
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        );
                      });
                });
              }),
    );
  }
}
