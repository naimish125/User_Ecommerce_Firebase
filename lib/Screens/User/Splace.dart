import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userfirebase/utils/firebase_helper.dart';

class SpleshScreen extends StatefulWidget {
  const SpleshScreen({Key? key}) : super(key: key);

  @override
  State<SpleshScreen> createState() => _SpleshScreenState();
}

class _SpleshScreenState extends State<SpleshScreen> {
  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(seconds: 6),
          () {
            FireBaseHelper.fireBaseHelper.CheckUser() == true ? Get.offAndToNamed("/Home") : Get.offAndToNamed('/Login');
      },
    );
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              height: double.infinity,
              width: double.infinity,
              child: Image.asset(
                "assets/images/exodus.gif",
                fit: BoxFit.cover,
              ),
            ),
            ),
        );
    }
}