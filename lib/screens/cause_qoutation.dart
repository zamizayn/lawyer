import 'dart:developer';

import 'package:find_your_lawyer/controllers/lawyers_controller.dart';
import 'package:find_your_lawyer/database/quotation_model.dart';
import 'package:find_your_lawyer/screens/case_request_detail_view.dart';
import 'package:flutter/material.dart';

class CauseQuatation extends StatelessWidget {
  const CauseQuatation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        backgroundColor: Colors.blue[800],
        elevation: 0,
        centerTitle: true,
        title: const Text("Case Quotation", style: TextStyle(color: Colors.white)),
      ),
      body: FutureBuilder(
          future: LawyersController.instance.getQuotationList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            List<QuotationModel> quotationList = LawyersController.instance.quotationList;
            if (quotationList.isEmpty) {
              return const Center(child: Text("No Quotations"));
            }
            return ListView.builder(
              itemCount: quotationList.length, // Replace with the actual number of quotations
              itemBuilder: (context, index) {
                return _buildQuotationCard(context, index, quotationList[index]);
              },
            );
          }),
    );
  }

  // Widget _buildQuotationCard(BuildContext context, int index) {
  Widget _buildQuotationCard(BuildContext context, int index, QuotationModel quotationModel) {
    log("Quotation ID: ${quotationModel.pkQuotesId}");
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Case ${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8.0),
            Text(quotationModel.quoteRequest.requestTitle ?? "Title Here"),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Status: ${quotationModel.quoteStatsFlg}'),
                Text(
                    'Amount: \$${quotationModel.quotesAdvanceAmount}'), // Replace with actual quotation amount
              ],
            ),
            const SizedBox(height: 16.0),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CaseRequestDetailView(
                        quotationID: quotationModel.pkQuotesId,
                        quoteRequest: quotationModel.quoteRequest),
                  ));
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green[400]),
                child: const Text(
                  'View Quotation',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
