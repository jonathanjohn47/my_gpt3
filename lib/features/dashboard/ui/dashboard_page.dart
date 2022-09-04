import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:my_gpt3/features/dashboard/get_controllers/dashboard_page_get_controller.dart';

import '../../../core/get_controllers/app_constants_get_controller.dart';
import '../../../widgets/standard_button.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({Key? key}) : super(key: key);

  DashboardPageGetController dashboardPageGetController =
      Get.put(DashboardPageGetController());

  AppConstantsGetController appConstantsGetController =
      Get.put(AppConstantsGetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GPT3'),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                dashboardPageGetController.choices.clear();
                dashboardPageGetController.selectedChoice.value = 0;
                dashboardPageGetController.promptController.text = '';
                dashboardPageGetController.startTextController.text = '';
              },
              icon: Icon(Icons.cancel_outlined))
        ],
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
          ListTile(
            leading: Text('Inject\nStart Text'),
            title: TextFormField(
              controller: dashboardPageGetController.startTextController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Start Text',
                alignLabelWithHint: true,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Text('Response:', style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),),
              ],
            ),
          ),
          Divider(),
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
                child: GestureDetector(
              onLongPress: () {
                dashboardPageGetController.copyToClipboard();
              },
              child: Obx(() {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    dashboardPageGetController.choices.isNotEmpty
                        ? dashboardPageGetController.choices[
                            dashboardPageGetController.selectedChoice.value]
                        : '',
                    maxLines: 500,
                  ),
                );
              }),
            )),
          ),
        ],
      ),
      bottomNavigationBar: Wrap(
        children: [
          Obx(() {
            return Visibility(
              visible: dashboardPageGetController.choices.isNotEmpty,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        if (dashboardPageGetController.selectedChoice.value >
                            0) {
                          dashboardPageGetController.selectedChoice.value--;
                        }
                      },
                      icon: Icon(Icons.arrow_left_rounded)),
                  Obx(() {
                    return Text(
                        (dashboardPageGetController.selectedChoice.value + 1)
                            .toString());
                  }),
                  IconButton(
                      onPressed: () {
                        if (dashboardPageGetController.selectedChoice.value <
                            dashboardPageGetController.choices.length - 1) {
                          dashboardPageGetController.selectedChoice.value++;
                        }
                      },
                      icon: Icon(Icons.arrow_right_rounded)),
                ],
              ),
            );
          }),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() {
                return dashboardPageGetController.showLoader.value
                    ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    )
                    : StandardButton(
                        text: 'Submit',
                        onPressed: () {
                          dashboardPageGetController.makeGPTRequest();
                        },
                        icon: Icons.check,
                      );
              }),
            ],
          ),
        ],
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: SizedBox(
            height: Get.height,
            child: ListView(
              children: [
                DrawerHeader(
                  child: Wrap(
                    direction: Axis.vertical,
                    children: [
                      SizedBox(
                          width: 100,
                          height: 100,
                          child: Image.asset('assets/images/gpt3_logo.jpeg')),
                      Text(
                        'My GPT3',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                ListTile(
                  leading: Text('Temperature'),
                  title: Obx(() {
                    return Slider(
                      value: dashboardPageGetController.temperature.value,
                      onChanged: (double value) {
                        dashboardPageGetController.temperature.value = value;
                      },
                      min: 0,
                      max: 1,
                      divisions: 100,
                      label:
                          dashboardPageGetController.temperature.value.toString(),
                    );
                  }),
                  trailing: Obx(() {
                    return Text(
                        dashboardPageGetController.temperature.value.toString());
                  }),
                ),
                ListTile(
                  leading: Text('Max Tokens'),
                  title: Obx(() {
                    return Slider(
                      value: dashboardPageGetController.maxTokens.value / 4000,
                      onChanged: (double value) {
                        dashboardPageGetController.maxTokens.value =
                            (value * 4000).round();
                      },
                      min: 0,
                      max: 1,
                      divisions: 4000,
                      label: dashboardPageGetController.maxTokens.value.toString(),
                    );
                  }),
                  trailing: Obx(() {
                    return Text(
                        dashboardPageGetController.maxTokens.value.toString());
                  }),
                ),
                ListTile(
                  leading: Text('Frequency\nPenalty'),
                  title: Obx(() {
                    return Slider(
                      value: dashboardPageGetController.frequencyPenalty.value / 2,
                      onChanged: (double value) {
                        dashboardPageGetController.frequencyPenalty.value =
                            (value * 2);
                      },
                      min: 0,
                      max: 1,
                      divisions: 200,
                      label: dashboardPageGetController.frequencyPenalty.value
                          .toString(),
                    );
                  }),
                  trailing: Obx(() {
                    return Text(dashboardPageGetController.frequencyPenalty.value
                        .toString());
                  }),
                ),
                ListTile(
                  leading: Text('Presence\nPenalty'),
                  title: Obx(() {
                    return Slider(
                      value: dashboardPageGetController.presencePenalty.value / 2,
                      onChanged: (double value) {
                        dashboardPageGetController.presencePenalty.value =
                            (value * 2);
                      },
                      min: 0,
                      max: 1,
                      divisions: 200,
                      label: dashboardPageGetController.presencePenalty.value
                          .toString(),
                    );
                  }),
                  trailing: Obx(() {
                    return Text(dashboardPageGetController.presencePenalty.value
                        .toString());
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
