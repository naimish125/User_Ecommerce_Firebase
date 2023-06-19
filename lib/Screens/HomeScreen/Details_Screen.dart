import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:userfirebase/Screens/HomeScreen/model.dart';
import 'package:userfirebase/utils/firebase_helper.dart';

class Details extends StatefulWidget {
  const Details({Key? key}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  Home_model home_model = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Product Detail"),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(60),
            child: Container(
              width: double.infinity,
              height: 200,
              child: Image.network("${home_model.p_image}"),
            ),
          ),
          Divider(thickness: 2, color: Colors.black),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  "  ${home_model.p_name}",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 2,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 13.5),
                child: Text(
                  "Rs.:-${home_model.p_price}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(left: 13.5),
            child: Row(
              children: [
                Container(
                  width:300,
                  height: 51,
                  child: Text(
                    "Detail :-${home_model.p_notes}",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height:22),
          Padding(
            padding: const EdgeInsets.only(left: 13.5),
            child: Row(
              children: [
                Text(
                  "Review :-${home_model.p_review}⭐⭐⭐",
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
          SizedBox(height: 120,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  onTap: (){
                    FireBaseHelper.fireBaseHelper.insertitem(
                      Img: home_model.p_image,p_date:home_model.p_date ,p_modelno:home_model.p_modelno ,p_name:home_model.p_name ,p_notes:home_model.p_notes,
                      p_paytypes: home_model.p_paytypes,p_price:home_model.p_price ,p_review:home_model.p_review ,p_time:home_model.p_time ,p_warranty: home_model.p_warranty,
                    );
                    Get.back();
                  },
                  child: Container(
                    child: Center(child: Text("Add to cart",style: TextStyle(fontWeight: FontWeight.w600),)),
                    color: Colors.grey,
                    height: 50,
                    width: 120,
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  onTap: (){
                    FireBaseHelper.fireBaseHelper.buyinsertitem(
                      Img: home_model.p_image,p_date:home_model.p_date ,p_modelno:home_model.p_modelno ,p_name:home_model.p_name ,p_notes:home_model.p_notes,
                      p_paytypes: home_model.p_paytypes,p_price:home_model.p_price ,p_review:home_model.p_review ,p_time:home_model.p_time ,p_warranty: home_model.p_warranty,
                    );
                   Get.toNamed('/Pay');
                  },
                  child: Container(
                    child: Center(child: Text("Buy",style: TextStyle(fontWeight: FontWeight.w600),)),
                    color: Colors.grey,
                    height: 50,
                    width: 120,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
