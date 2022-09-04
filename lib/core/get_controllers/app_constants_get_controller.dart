import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../app_constants.dart';

class AppConstantsGetController extends GetxController {
  void fetchApiKey() {
    FirebaseFirestore.instance
        .collection('Constants')
        .doc('API Key')
        .get()
        .then((value) {
      AppConstants.apiKey = value.get('API Key');
    });
  }

  @override
  void onInit() {
    fetchApiKey();
    super.onInit();
  }
}
