import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_gpt3/core/app_constants.dart';
import 'package:my_gpt3/features/dashboard/ui/dashboard_page.dart';

class LoginPageGetController extends GetxController {
  Rx<Country> selectedCountry = Country.worldWide.obs;
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  void login() {
    if (phoneController.text.length != 10) {
      return;
    }
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: AppConstants.emailForTemporaryLogin,
            password: AppConstants.passwordForTemporaryLogin)
        .then((value) {
      print(selectedCountry.value.phoneCode + phoneController.text);
      FirebaseFirestore.instance
          .collection(AppConstants.users)
          .doc('+' + selectedCountry.value.phoneCode + phoneController.text)
          .get()
          .then((value) {
        FirebaseAuth.instance.signOut();
        if (value.exists) {
          FirebaseAuth.instance.verifyPhoneNumber(
              phoneNumber:
                  '+' + selectedCountry.value.phoneCode + phoneController.text,
              verificationCompleted: (credential) {
                FirebaseAuth.instance
                    .signInWithCredential(credential)
                    .then((value) {
                  Get.offAll(() => DashboardPage());
                });
              },
              verificationFailed: (error) {},
              codeSent: (verificationId, _) {
                Get.dialog(AlertDialog(
                  title: Text('Enter OTP'),
                  content: TextFormField(
                    controller: otpController,
                    keyboardType: TextInputType.number,
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text('Cancel')),
                    TextButton(
                        onPressed: () {
                          FirebaseAuth.instance
                              .signInWithCredential(
                                  PhoneAuthProvider.credential(
                                      verificationId: verificationId,
                                      smsCode: otpController.text))
                              .then((value) {
                            Get.back();
                            Get.off(() => DashboardPage());
                          });
                        },
                        child: Text('Verify'))
                  ],
                ));
              },
              codeAutoRetrievalTimeout: (verificationId) {});
        } else {
          Get.dialog(AlertDialog(
            title: Text('User not found'),
            content: Text('User Not Found'),
            actions: [
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text('Ok'))
            ],
          ));
        }
      });
    });
  }

  @override
  void onInit() {
    if (FirebaseAuth.instance.currentUser != null) {
      if (FirebaseAuth.instance.currentUser!.phoneNumber != null) {
        Get.offAll(() => DashboardPage());
      }
    }
    super.onInit();
  }
}
