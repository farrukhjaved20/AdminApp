import 'package:auth/screen/log.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class Product {
  final String name;
  final String quantity;
  final String barcode;
  final String date;

  Product(
      {required this.name,
      required this.quantity,
      required this.barcode,
      required this.date});
}

enum SortBy {
  ASCENDING_QUANTITY,
  DESCENDING_QUANTITY,
}

class FirebaseService {
  Rx<User?> user = Rx<User?>(null);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('Posapp');

  Future<List<Product>> getProducts() async {
    QuerySnapshot querySnapshot = await productsCollection.get();
    List<Product> products = [];
    for (var doc in querySnapshot.docs) {
      products.add(Product(
        name: doc['productname'],
        quantity: doc['productquantity'],
        barcode: doc['barcode'],
        date: doc['date'],
      ));
    }
    return products;
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();

      Get.offAll(() => const Login());
      Get.snackbar("SUCCESSFULLY", "logged Out!!");
    } catch (e) {
      Get.snackbar("Sign Out Error", e.toString());
    }
  }
}
