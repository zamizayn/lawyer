import 'dart:io';

import 'package:find_your_lawyer/controllers/send_request_controller.dart';
import 'package:find_your_lawyer/main.dart';
import 'package:find_your_lawyer/screens/widgets/loading.dart';
import 'package:find_your_lawyer/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SendRequest extends StatelessWidget {
  const SendRequest({super.key, required this.lawyerId});

  final String lawyerId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldMessengerKey,
      appBar: AppBar(
        title: const Text("Send Request"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: SendRequestController.instance.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Case Details",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: SendRequestController.instance.caseTitle,
                  decoration: const InputDecoration(
                      labelText: "Case Title", border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null) {
                      return "Case Title required";
                    }
                    if (value.isEmpty) {
                      return "Case Title required";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: SendRequestController.instance.caseDescription,
                  maxLines: 5,
                  maxLength: 100,
                  decoration: const InputDecoration(
                      labelText: "Case Description",
                      border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null) {
                      return "Case Description required";
                    }
                    if (value.isEmpty) {
                      return "Case Description required";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Consumer<SendRequestController>(
                    builder: (context, controller, child) {
                  return Column(
                    children: [
                      Text(
                        "Attachments",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 10),
                      OutlinedButton(
                          onPressed: controller.addAttachment,
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.attach_file),
                              Text("Add attachment")
                            ],
                          )),
                      const SizedBox(height: 10),
                      controller.attachment != null
                          ? InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FullScreenImage(
                                              path: controller.attachment!.path,
                                              fileType: FileType.Memory,
                                            )));
                              },
                              child: Image.file(
                                File(controller.attachment!.path),
                                width: 100,
                                height: 100,
                              ),
                            )
                          : const SizedBox(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Ask Case Opinion"),
                          Radio(
                            value: SendRequestType.askOpinion,
                            groupValue: controller.sendRequestType,
                            onChanged: (value) =>
                                controller.setRequestType(value!),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Assign New Case"),
                          Radio(
                            value: SendRequestType.assignCase,
                            groupValue: controller.sendRequestType,
                            onChanged: (value) =>
                                controller.setRequestType(value!),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Align(
                          alignment: Alignment.center,
                          child: controller.isSubmitting
                              ? const Loading(message: "Submitting")
                              : ElevatedButton(
                                  onPressed: () =>
                                      controller.submit(context, lawyerId),
                                  child: const Text("Submit"))),
                    ],
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
