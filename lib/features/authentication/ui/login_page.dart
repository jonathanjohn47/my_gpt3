import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_gpt3/features/authentication/get_controllers/login_page_get_controller.dart';

import '../../../widgets/standard_button.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  LoginPageGetController loginPageGetController =
      Get.put(LoginPageGetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ListTile(
            leading: GestureDetector(onTap: () {
              showCountryPicker(
                  context: context,
                  onSelect: (country) {
                    loginPageGetController.selectedCountry.value = country;
                  });
            }, child: Obx(() {
              return Text(
                  loginPageGetController.selectedCountry.value.displayName);
            })),
            title: TextFormField(
              controller: loginPageGetController.phoneController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Phone',
                alignLabelWithHint: true,
              ),
              keyboardType: TextInputType.phone,
            ),
          ),
          StandardButton(
            text: 'Login',
            onPressed: () {
              loginPageGetController.login();
            },
            icon: Icons.login,
          ),
        ],
      ),
    );
  }
}
