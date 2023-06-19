import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:userfirebase/Screens/HomeScreen/Details_Screen.dart';
import 'package:userfirebase/Screens/HomeScreen/HomeScreen.dart';
import 'package:userfirebase/Screens/HomeScreen/Payment.dart';
import 'package:userfirebase/Screens/HomeScreen/add_cart.dart';

import 'Screens/Login/Login_Screen.dart';
import 'Screens/Login/SignUp_Screen.dart';
import 'Screens/User/Splace.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      Sizer(
          builder: (BuildContext context, Orientation orientation,
              DeviceType deviceType) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              getPages: [
                GetPage(
                  name: '/',
                  page: () => SpleshScreen(),
                ),GetPage(
                  name: '/SignUp',
                  page: () => SingUp_Screen(),
                ),
                GetPage(
                  name: '/Login',
                  page: () => Login_Screen(),
                ),
                GetPage(
                  name: '/Home',
                  page: () => Home(),
                ),
                GetPage(
                  name: '/details',
                  page: () => Details(),
                ),
                GetPage(
                  name: '/Cart',
                  page: () => cart(),
                ),
                GetPage(
                  name: '/Pay',
                  page: () => Payment(),
                ),
              ],
            );
          },
          ),
      );
}