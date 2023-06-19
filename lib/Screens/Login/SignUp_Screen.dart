import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userfirebase/utils/firebase_helper.dart';


class SingUp_Screen extends StatefulWidget {
  const SingUp_Screen({Key? key}) : super(key: key);

  @override
  State<SingUp_Screen> createState() => _SingUp_ScreenState();
}

class _SingUp_ScreenState extends State<SingUp_Screen> {
  @override
  TextEditingController txtemail = TextEditingController();
  TextEditingController txtpassword = TextEditingController();

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
                child: Icon(Icons.person_pin,color: Colors.black,size: 200),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "SignUp",
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
                              controller: txtemail,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Email",
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: TextField(
                              controller: txtpassword,
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
                height: 20,
              ),
              InkWell(
                onTap: ()  async {
                  bool? msg = await FireBaseHelper.fireBaseHelper.Create(email: txtemail.text,password: txtpassword.text);
                  print(msg);
                  if(msg == true)
                  {
                    print("Done");
                    Get.snackbar("Account Created", "Fire Base",colorText: Colors.white);
                  }
                  else if(msg == false)
                  {
                    print("Cancle");
                    Get.snackbar("Try with Another User Name", "Fire Base",colorText: Colors.white);
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
                      "SignUp",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 160,
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    Get.toNamed("/Login");
                  },
                  child: Text(
                    "Already have Account? Login",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.blueAccent,
                    ),
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