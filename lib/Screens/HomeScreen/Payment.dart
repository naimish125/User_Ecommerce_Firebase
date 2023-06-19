import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../utils/firebase_helper.dart';
import 'controller.dart';
import 'model.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  AddScreenController contoller = Get.put(AddScreenController());

  Razorpay? _razorpay;

  @override
  void initState() {
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {}

  void _handlePaymentError(PaymentFailureResponse response) {}

  void _handleExternalWallet(ExternalWalletResponseresponse) {}

  void payment() async {
    var options = {
      'key': 'rzp_test_msWXJvFBgejsPg',
      'amount': '45,000',
      'name': 'Naimish',
    };

    try {
      _razorpay?.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FireBaseHelper.fireBaseHelper.buyitem(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(("${snapshot.error}"));
          } else if (snapshot.hasData) {
            QuerySnapshot? q = snapshot.data;
            List<Home_model> homeList = [];
            for (var x in q!.docs) {
              Map data = x.data() as Map;
              String? name = data['p_name'];
              String? notes = data['p_notes'];
              String? date = data['p_date'];
              String? time = data['p_time'];
              String? price = data['p_price'];
              String? image = data['p_image'];
              var key = x.id;
              Home_model home = Home_model(
                p_name: name,
                p_notes: notes,
                p_date: date,
                p_price: price,
                p_image: image,
                p_time: time,
                key: x.id,
              );
              contoller.DataList.add(home);
            }
            return ListView.builder(
              itemCount: contoller.DataList.length,
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
                                  "${contoller.DataList[index].p_image}",
                                  height: 80,
                                  width: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${contoller.DataList[index].p_name}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Text(
                                "${contoller.DataList[index].p_price}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green),
                              onPressed: () {
                                 payment();
                              },
                              child: Text("Buy Now")),
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

  @override
  void dispose() {
    // TODO: implement dispose
    _razorpay?.clear();
    super.dispose();
  }
}
