import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:my_gpt3/core/app_constants.dart';
import 'package:my_gpt3/features/dashboard/models/prompt_model.dart';
import 'package:my_gpt3/features/dashboard/models/response_model.dart';

class DashboardPageGetController extends GetxController {
  TextEditingController promptController = TextEditingController();
  RxString response = ''.obs;
  Rx<double> temperature = 0.7.obs;
  Rx<int> maxTokens = 256.obs;
  Rx<double> frequencyPenalty = 0.0.obs;
  Rx<double> presencePenalty = 0.0.obs;
  RxList<String> choices = <String>[].obs;
  Rx<int> selectedChoice = 0.obs;
  RxBool showLoader = false.obs;

  TextEditingController startTextController = TextEditingController();

  void copyToClipboard() {
    Clipboard.setData(ClipboardData(text: response.value.trim()));
    Get.snackbar('Copied to clipboard', '', snackPosition: SnackPosition.TOP);
  }

  Future<void> makeGPTRequest() async {
    showLoader.value = true;
    FirebaseFirestore.instance
        .collection(AppConstants.constants)
        .doc(AppConstants.api)
        .get()
        .then((value) async {
      var headers = {
        'Authorization': 'Bearer ${value.get(AppConstants.api)}',
        'Content-Type': 'application/json'
      };
      var request = http.Request(
          'POST', Uri.parse('https://api.openai.com/v1/completions'));
      request.body = jsonEncode(PromptModel(
          model: AppConstants.davinciEngine,
          prompt:
              (promptController.text.trim() + startTextController.text).trim(),
          temperature: temperature.value,
          maxTokens: maxTokens.value,
          topP: 1,
          frequencyPenalty: frequencyPenalty.value,
          presencePenalty: presencePenalty.value));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        ResponseModel responseModel = ResponseModel.fromJson(
            jsonDecode(await response.stream.bytesToString()));
        choices.value = responseModel.choices.map((e) => e.text).toList().obs;
      } else {
        print(response.reasonPhrase);
      }
      showLoader.value = false;
    });
  }
}
