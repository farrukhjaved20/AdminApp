// ignore_for_file: unused_field

import 'package:auth/models/product.dart';
import 'package:auth/screen/Barcode.dart';
import 'package:auth/screen/addproduct.dart';
import 'package:auth/screen/alert.dart';
import 'package:auth/screen/productlist.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Dashboard.dart';

class AdminPanel extends StatefulWidget {
  static const routeName = '/adminpanel';
  const AdminPanel({Key? key}) : super(key: key);

  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  final TextEditingController _textEditingController = TextEditingController();
  final User? user = FirebaseAuth.instance.currentUser;
  FirebaseService service = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin View"),
        actions: [
          IconButton(
              onPressed: () {
                service.signOut();
              },
              icon: const Icon(
                Icons.logout_outlined,
                color: Colors.white,
                size: 30,
              ))
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2, // Number of columns
        mainAxisSpacing: 16.0, // Vertical spacing
        crossAxisSpacing: 16.0, // Horizontal spacing
        padding: const EdgeInsets.all(16.0), // Outer paddinger of columns
        children: [
          _buildGridTile("Add product", Addproduct.routName),
          _buildGridTile("DashBoards", Dashboard.routName),
          _buildGridTile("Product List", ProductList.routName),
          _buildGridTile("Product Alert", Alert.routName),
          _buildGridTile("Barcode Generator", Barcode.routName),
        ],
      ),
    );
  }

  Widget _buildGridTile(String title, String routeName) {
    return InkWell(
      onTap: () {
        if (title == "Logout") {
          // Call the sign-out function here
          service.signOut();
          // You might want to navigate to the login screen after signing out
          // Navigator.pushReplacementNamed(context, Login.routeName);
        } else {
          Navigator.pushNamed(context, routeName);
        }
      },
      child: Card(
        color: const Color.fromARGB(255, 216, 168, 168),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
