import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:get/get.dart';
import 'package:userfirebase/utils/firebase_helper.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({Key? key}) : super(key: key);

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  @override
  TextEditingController txtEmail =
  TextEditingController();
  TextEditingController txtPassword = TextEditingController();


  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 50,),
              Center(
                child: Container(
                  height: 200,
                  width: 200,
                  child: Icon(Icons.person_pin,color: Colors.black,size: 200),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 5,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey.shade200,
                                ),
                              ),
                            ),
                            child: TextField(
                              controller: txtEmail,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Email",
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                          // Divider(thickness: 1,color: Colors.grey.shade200,),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: TextField(
                              controller: txtPassword,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Password",
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () async {
                  bool? msg = await FireBaseHelper.fireBaseHelper.Check(email: txtEmail.text, password: txtPassword.text);
                  if(msg == true)
                  {
                    Get.snackbar("login successfully", "Fire Base");

                    Get.offAndToNamed("/Home");
                  }
                  else
                  {
                    Get.snackbar("Enter Valid Id Or Password", "Fire Base");
                  }
                },
                child: Container(
                  height: 50,
                  margin: EdgeInsets.symmetric(horizontal: 60),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.black,
                  ),
                  child: Center(
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Center(
                child: SignInButton(
                  Buttons.GoogleDark,
                  onPressed: (
                      ) async {
                    var msg = await FireBaseHelper.fireBaseHelper.sinhInThroughGoogle();
                    if (msg == "Success") {
                    }
                  },
                ),
              ),

              SizedBox(
                height: 80,
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    Get.toNamed("/SignUp");
                  },
                  child: Text(
                    "Don't Have Account? Sign Up",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.blueAccent),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}