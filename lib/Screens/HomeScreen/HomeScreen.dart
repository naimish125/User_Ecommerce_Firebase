import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:userfirebase/utils/firebase_helper.dart';

import 'controller.dart';
import 'model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AddScreenController contoller = Get.put(AddScreenController());
  bool isLogin = false;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          drawer: Drawer(
            child: Column(
              children: [
                Icon(Icons.person_rounded, size:125),
                SizedBox(height: 3),
                Text(
                  "Naimish",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 510,),
                ElevatedButton(onPressed: (){
                  FireBaseHelper.fireBaseHelper.signOut();
                  Get.offAndToNamed("/Login");
                }, child: Text("Logout"),style:ElevatedButton.styleFrom(backgroundColor: Colors.black)),
              ],
            ),
            width: 250,
            backgroundColor: Colors.white,
          ),
          appBar: AppBar(
            backgroundColor: Colors.black,
            centerTitle: true,
            title: Text("Ecomaarce", style: TextStyle(color: Colors.white)),
            actions: [
              InkWell(onTap: (){
                Get.toNamed("\Cart");
              },child: Icon(Icons.shopping_bag_outlined)),
              SizedBox(
                width: 5,
              ),
            ],
          ),
          body: StreamBuilder(
            stream: FireBaseHelper.fireBaseHelper.GetData(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("${snapshot.error}");
              } else if (snapshot.hasData) {
                contoller.DataList.clear();
                QuerySnapshot? snapData = snapshot.data;
                for (var x in snapData!.docs) {
                  Map data = x.data() as Map;
                  String? name = data['p_name'];
                  String? notes = data['p_notes'];
                  String? date = data['p_date'];
                  String? time = data['p_time'];
                  String? price = data['p_price'];
                  String? review = data['p_review'];
                  String? warranty = data['p_warranty'];
                  String? paytypes = data['p_paytypes'];
                  String? model = data['p_modelno'];
                  String? Img = data['img'];
                  print("=============================== name");
                  print(name);

                  Home_model home_model = Home_model(
                    p_name: name,
                    p_warranty: warranty,
                    p_review: review,
                    p_paytypes: paytypes,
                    p_notes: notes,
                    p_modelno: model,
                    p_date: date,
                    p_price: price,
                    p_time: time,
                    key: x.id,
                    p_image: Img,
                  );

                  print('==== $Img');
                  contoller.DataList.add(home_model);
                }
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisExtent: 230,
                  ),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        child: InkWell(onTap:(){
                          Get.toNamed('/details',arguments: contoller.DataList[index]);
                        } ,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey,
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 12,
                                ),
                                CircleAvatar(
                                  backgroundImage: NetworkImage("${contoller.DataList[index].p_image}"),
                                  radius: 50,
                                  backgroundColor: Colors.white,
                                ),
                                // Container(
                                //   child: Image.network(
                                //     "${contoller.DataList[index].Img}",
                                //     fit: BoxFit.cover,
                                //     height: 80,
                                //     width: 80,
                                //   ),
                                // ),
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Text(
                                      "   Name :-${contoller.DataList[index].p_name}",
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Price :-${contoller.DataList[index].p_price}",
                                  style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                // Text(
                                //   "Notes :-${contoller.DataList[index].p_notes}",
                                //   style: TextStyle(color: Colors.black),
                                // ),
                                // SizedBox(height: 3,),
                                Text(
                                  "Rating :-${contoller.DataList[index].p_review}⭐⭐⭐",
                                  style: TextStyle(color: Colors.black),
                                ),
                                // SizedBox(height: 3,),
                                // Text(
                                //   "ModelNo :-${contoller.DataList[index].p_modelno}",
                                //   style: TextStyle(color: Colors.black),
                                // ),
                                // SizedBox(height: 3,),
                                // Text(
                                //   "Date :-${contoller.DataList[index].p_date}",
                                //   style: TextStyle(color: Colors.black),
                                // ),
                                // SizedBox(height: 3,),
                                // Text(
                                //   "Time :-${contoller.DataList[index].p_time}",
                                //   style: TextStyle(color: Colors.black),
                                // ),
                              SizedBox(height: 5.5,),
                                Row(
                                  children: [
                                    Spacer(),
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(15)),
                                      child: Container(
                                        child: Icon(Icons.add),
                                        color: Colors.green,
                                        height: 25,
                                        width: 25,
                                      ),
                                    ),
                                  ],
                                )
                               ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: contoller.DataList.length,
                );
              }
              return CircularProgressIndicator();
            },
          ),
        ));
  }
}
