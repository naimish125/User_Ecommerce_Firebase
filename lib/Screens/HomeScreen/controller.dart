import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'model.dart';


class AddScreenController extends GetxController
{
  TextEditingController txtNotes = TextEditingController();
  TextEditingController txtDate = TextEditingController(text: "${DateTime.now()}");
  TextEditingController txtTime = TextEditingController(text: "${TimeOfDay.now()}");
  TextEditingController txtProrority = TextEditingController();
  TextEditingController txtTitle = TextEditingController();

  RxMap userDetail = {}.obs;

  List<Home_model> DataList = [];

  Home_model updateData = Home_model();
}
