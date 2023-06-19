import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:userfirebase/utils/firebase_helper.dart';

import 'Cart_model.dart';
import 'cart_controler.dart';


class cart extends StatefulWidget {
  const cart({Key? key}) : super(key: key);

  @override

  State<cart> createState() => _cartState();
}

class _cartState extends State<cart> {
  Cart_Controller contoller = Get.put(Cart_Controller());


  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Cart"),centerTitle: true,
      ),
      body: StreamBuilder(
          stream: FireBaseHelper.fireBaseHelper.readcartitem(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(("${snapshot.error}"));
            } else if (snapshot.hasData) {
              QuerySnapshot? q = snapshot.data;
              List<Cart_model> homeList = [];
              contoller.CartList.clear();
              for (var x in q!.docs) {
                Map data = x.data() as Map;
                String? name = data['p_name'];
                String? notes = data['p_notes'];
                String? date = data['p_date'];
                String? time = data['p_time'];
                String? price = data['p_price'];
                String? image = data['p_image'];
                var key = x.id;
                Cart_model Cart_moddel = Cart_model(
                  p_name: name,
                  p_notes: notes,
                  p_date: date,
                  p_price: price,
                  p_image: image,
                  p_time: time,
                  key: x.id,
                );
                contoller.CartList.add(Cart_moddel);
              }
              return ListView.builder(
                itemCount: contoller.CartList.length,
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Card(
                      elevation: 3,
                      child: Container(
                        width: double.infinity,
                        height: 130,
                        margin: EdgeInsets.all(5),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  child: Image.network(
                                    "${contoller.CartList[index].p_image}",
                                    height: 80,
                                    width: 80,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${contoller.CartList[index].p_name}",
                                  style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Text(
                                  "${contoller.CartList[index].p_price}",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          Spacer(),
                            InkWell(onTap: (){
                              FireBaseHelper.fireBaseHelper.deletdata(key: contoller.CartList[index].key);
                            },child: Icon(Icons.delete,color: Colors.red)),
                          ],
                        ),
                      ),
                    ),

                  );
                },
              );
            }
            return Center(child: CircularProgressIndicator());
            },
          ),
    ));
  }
}
