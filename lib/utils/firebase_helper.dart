import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class FireBaseHelper {
  static FireBaseHelper fireBaseHelper = FireBaseHelper._();

  FireBaseHelper._();

// Todo signIn
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<bool?> Create({required email, required password}) async {
    bool? msg;
    return await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      return true;
    }).catchError((e) {
      return false;
    });
  }

  Future<bool?> Check({required email, required password}) async {
    bool? mag;

    return await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password)
        .then(
          (value) {
        return true;
      },
    ).catchError(
          (e) {
        return false;
      },
    );
    return mag;
  }

  signOut() async {
    bool? check;
    await firebaseAuth.signOut().then((value) => check = true);
    await GoogleSignIn().signOut().then((value) => check = true);
    return check;
  }

  bool CheckUser() {
    User? user = firebaseAuth.currentUser;
    return user != null;
  }
  sinhInThroughGoogle() async {
    bool? msg;
    GoogleSignInAccount? user = await GoogleSignIn().signIn();

    GoogleSignInAuthentication? googleAuth = await user?.authentication;

    var crd = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
  }
  Stream<QuerySnapshot<Map<String, dynamic>>> GetData() {
    User? user = firebaseAuth.currentUser;
    var uid = user!.uid;
    return firestore.collection("Product").snapshots();
  }
  Future<void> addtocart({p_name,
    p_notes,
    p_date,
    p_time,
    p_price,
    p_review,
    p_warranty,
    p_paytypes,
    p_modelno,
    Img,
  }) async {
    User? user = firebaseAuth.currentUser;
    String uid = user!.uid;
    await firestore.collection("Cart").add({
      "p_name": p_name,
      "p_notes": p_notes,
      "p_date": p_date,
      "p_time": p_time,
      "p_price": p_price,
      "p_review": p_review,
      "p_warranty": p_warranty,
      "p_image": Img,
      "p_paytypes": p_paytypes,
      "p_modelno": p_modelno,
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> Getdatacart() {
    User? user = firebaseAuth.currentUser;
    var uid = user!.uid;

    return firestore
        .collection("Cart").snapshots();
  }
  Future<void> cartdeletedata( key) async {
    User? user = firebaseAuth.currentUser;
    var uid = user!.uid;

    await firestore.collection("Cart").doc(key).delete();
  }

  void insertitem({
    p_name,
    p_notes,
    p_date,
    p_time,
    p_price,
    p_review,
    p_warranty,
    p_paytypes,
    p_modelno,
    Img,
  }) async {
    User? user = firebaseAuth.currentUser;
    String uid = user!.uid;
    print("======================================== data");
    print(p_name);
    await firestore.collection("Cart").doc("$uid").collection("add").add({
      "p_name": p_name,
      "p_notes": p_notes,
      "p_date": p_date,
      "p_time": p_time,
      "p_price": p_price,
      "p_review": p_review,
      "p_warranty": p_warranty,
      "p_image": Img,
      "p_paytypes": p_paytypes,
      "p_modelno": p_modelno,
    });
  }
  void cartitem({
    p_name,
    p_notes,
    p_date,
    p_time,
    p_price,
    p_review,
    p_warranty,
    p_paytypes,
    p_modelno,
    Img,
  }) async {
    User? user = firebaseAuth.currentUser;
    String uid = user!.uid;
    await firestore.collection("Cart").doc("$uid").collection("add").add({
      "p_name": p_name,
      "p_notes": p_notes,
      "p_date": p_date,
      "p_time": p_time,
      "p_price": p_price,
      "p_review": p_review,
      "p_warranty": p_warranty,
      "p_image": Img,
      "p_paytypes": p_paytypes,
      "p_modelno": p_modelno,
    });
  }


  Stream<QuerySnapshot<Map<String, dynamic>>> readitem() {
    User? user = firebaseAuth.currentUser;
    String uid = user!.uid;
    return firestore.collection("Product").snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> readcartitem() {
    User? user = firebaseAuth.currentUser;
    String uid = user!.uid;
    return firestore.collection("Cart").doc("$uid").collection("add").snapshots();
    }


  Future<void> deletdata({required key}) async {
    User? user = firebaseAuth.currentUser;
    String uid = user!.uid;
    print(key);
    return await firestore
        .collection("Cart")
        .doc('$uid')
        .collection('add')
        .doc('$key')
    .delete();
    }

  Future<void> buyaddtocart({p_name,
    p_notes,
    p_date,
    p_time,
    p_price,
    p_review,
    p_warranty,
    p_paytypes,
    p_modelno,
    Img,
  }) async {
    User? user = firebaseAuth.currentUser;
    String uid = user!.uid;
    await firestore.collection("Cart").add({
      "p_name": p_name,
      "p_notes": p_notes,
      "p_date": p_date,
      "p_time": p_time,
      "p_price": p_price,
      "p_review": p_review,
      "p_warranty": p_warranty,
      "p_image": Img,
      "p_paytypes": p_paytypes,
      "p_modelno": p_modelno,
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> buyGetdatacart() {
    User? user = firebaseAuth.currentUser;
    var uid = user!.uid;

    return firestore
        .collection("Buy").snapshots();
  }

  void buyinsertitem({
    p_name,
    p_notes,
    p_date,
    p_time,
    p_price,
    p_review,
    p_warranty,
    p_paytypes,
    p_modelno,
    Img,
  }) async {
    User? user = firebaseAuth.currentUser;
    String uid = user!.uid;
    print("======================================== data");
    print(p_name);
    await firestore.collection("Buy").doc("$uid").collection("add").add({
      "p_name": p_name,
      "p_notes": p_notes,
      "p_date": p_date,
      "p_time": p_time,
      "p_price": p_price,
      "p_review": p_review,
      "p_warranty": p_warranty,
      "p_image": Img,
      "p_paytypes": p_paytypes,
      "p_modelno": p_modelno,
    });
  }
  void buycartitem({
    p_name,
    p_notes,
    p_date,
    p_time,
    p_price,
    p_review,
    p_warranty,
    p_paytypes,
    p_modelno,
    Img,
  }) async {
    User? user = firebaseAuth.currentUser;
    String uid = user!.uid;
    await firestore.collection("Buy").doc("$uid").collection("add").add({
      "p_name": p_name,
      "p_notes": p_notes,
      "p_date": p_date,
      "p_time": p_time,
      "p_price": p_price,
      "p_review": p_review,
      "p_warranty": p_warranty,
      "p_image": Img,
      "p_paytypes": p_paytypes,
      "p_modelno": p_modelno,
    });
  }


  Stream<QuerySnapshot<Map<String, dynamic>>> buyreaditem() {
    User? user = firebaseAuth.currentUser;
    String uid = user!.uid;
    return firestore.collection("Product").snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> buyitem() {
    User? user = firebaseAuth.currentUser;
    String uid = user!.uid;
    return firestore.collection("Buy").doc("$uid").collection("add").snapshots();
  }


}

