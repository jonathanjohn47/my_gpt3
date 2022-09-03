import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:my_gpt3/features/dashboard/get_controllers/dashboard_page_get_controller.dart';

import '../../../widgets/standard_button.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({Key? key}) : super(key: key);

  DashboardPageGetController dashboardPageGetController =
      Get.put(DashboardPageGetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GPT3'),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: dashboardPageGetController.promptController,
                maxLines: 100,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Prompt',
                  alignLabelWithHint: true,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Text('Response:'),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Obx(() {
              return SingleChildScrollView(
                  child: Text(
                dashboardPageGetController.response.value,
                maxLines: 500,
              ));
            }),
          ),
        ],
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StandardButton(text: 'Submit'),
        ],
      ),
    );
  }
}
