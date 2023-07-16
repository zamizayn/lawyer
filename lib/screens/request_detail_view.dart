import 'package:find_your_lawyer/controllers/lawyers_controller.dart';
import 'package:find_your_lawyer/database/quotation_model.dart';
import 'package:find_your_lawyer/screens/widgets/loading.dart';
import 'package:find_your_lawyer/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RequestDetailView extends StatelessWidget {
  const RequestDetailView({
    super.key,
    required this.quoteRequest,
  });

  final QuoteRequest quoteRequest;
  @override
  Widget build(BuildContext context) {
    String startDateString = "Date Here";
    if (quoteRequest.requestCreatnDate != null) {
      DateTime startDate = DateTime.parse(quoteRequest.requestCreatnDate!);
      startDateString = "${startDate.year}-${startDate.month}-${startDate.day}";
    }
    return Scaffold(
      appBar: AppBar(
          title: const Text('Case Request Detail',
              style: TextStyle(color: Colors.white)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Case Details',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            Card(
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow('Case Title',
                        quoteRequest.requestTitle ?? "Title Here"),
                    const SizedBox(height: 16.0),
                    _buildDetailRow(
                        'Case Description', quoteRequest.requestDescription),
                    const SizedBox(height: 16.0),
                    _buildDetailRow('Start Date', startDateString),
                    const SizedBox(height: 16.0),
                    // _buildDetailRow('Next Hearing Date', '2023-06-15'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Attachments',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            Card(
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FullScreenImage(
                                        path:
                                            "http://117.200.73.2:7075/lawyer/public/${quoteRequest.requestAttachment}",
                                        fileType: FileType.Network,
                                      )));
                        },
                        child: _buildAttachmentItem('Attachment 1')),
                    const SizedBox(height: 8.0),
                    // _buildAttachmentItem('Attachment 2'),
                    // const SizedBox(height: 8.0),
                    // _buildAttachmentItem('Attachment 3'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            // Consumer<LawyersController>(builder: (context, controller, child) {
            //   if (controller.replyLoadDialogue != null) {
            //     Loading(message: controller.replyLoadDialogue!);
            //   }
            //   return Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
            //     children: [
            //       ElevatedButton(
            //         onPressed: () async {
            //           await controller.replyQuotation(ReplyQuotation.accept, quotationID);
            //           if (context.mounted) {
            //             Navigator.pop(context);
            //           }
            //         },
            //         style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            //         child: const Text('Accept Case', style: TextStyle(color: Colors.white)),
            //       ),
            //       ElevatedButton(
            //         onPressed: () async {
            //           await controller.replyQuotation(ReplyQuotation.reject, quotationID);
            //           if (context.mounted) {
            //             Navigator.pop(context);
            //           }
            //         },
            //         style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            //         child: const Text('Reject Case', style: TextStyle(color: Colors.white)),
            //       ),
            //     ],
            //   );
            // }),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          value,
          style: const TextStyle(fontSize: 14.0),
        ),
      ],
    );
  }

  Widget _buildAttachmentItem(String attachmentName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.attachment),
        const SizedBox(width: 8.0),
        Text(
          attachmentName,
          style: const TextStyle(fontSize: 14.0),
        ),
        Image.network(
          "http://117.200.73.2:7075/lawyer/public/${quoteRequest.requestAttachment}",
          width: 150,
          height: 150,
        )
      ],
    );
  }
}
