import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class DashboardPageGetController extends GetxController{
  TextEditingController promptController = TextEditingController();
  RxString response = ''.obs;

}