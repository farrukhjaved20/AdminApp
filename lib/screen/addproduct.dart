// ignore_for_file: avoid_unnecessary_containers, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Addproduct extends StatefulWidget {
  static const routName = '/addproduct';
  const Addproduct({super.key});
  @override
  State<Addproduct> createState() => _AddproductState();
}

class _AddproductState extends State<Addproduct> {
  late final String barcodee, productnamee, productquantityy, datee;
  final _form = GlobalKey<FormState>();
  var productname = '';
  var productquantity = '';
  var barcode = '';
  var date = '';
  final namecontroller = TextEditingController();
  final quantitycontroller = TextEditingController();
  final barcodecontroller = TextEditingController();
  final datecontroller = TextEditingController();
  @override
  void dispose() {
    namecontroller.dispose();
    quantitycontroller.dispose();
    barcodecontroller.dispose();
    datecontroller.dispose();
    super.dispose();
  }

  CollectionReference products =
      FirebaseFirestore.instance.collection('Posapp');
  Future<void> addUser() async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Posapp").doc(barcode);
    Map<String, dynamic> products = {
      "barcode": barcode,
      "productname": productname,
      "productquantity": productquantity,
      "date": date,
    };
    documentReference
        .set(products)
        .whenComplete(() => print('Product Created'));
  }

  clearText() {
    namecontroller.clear();

    quantitycontroller.clear();
    barcodecontroller.clear();
    datecontroller.clear();
  }

  createdata() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Posapp").doc(barcode);
    Map<String, dynamic> products = {
      "barcode": barcode,
      "productname": productname,
      "productquantity": productquantity,
      "date": date,
    };
    documentReference
        .set(products)
        .whenComplete(() => print('Product Created'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add products'),
        backgroundColor: const Color.fromARGB(255, 212, 20, 52),
      ),
      body: Form(
        key: _form,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: ListView(
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: TextFormField(
                  autofocus: false,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.shopping_cart_outlined),
                      labelText: 'Product Name',
                      labelStyle: TextStyle(fontSize: 25),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      errorStyle: TextStyle(color: Colors.red, fontSize: 14)),
                  controller: namecontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Product';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: TextFormField(
                  autofocus: false,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.numbers),
                      labelText: 'Qunatity',
                      labelStyle: TextStyle(fontSize: 25),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      errorStyle: TextStyle(color: Colors.red, fontSize: 14)),
                  controller: quantitycontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Product Quantity';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: TextFormField(
                  autofocus: false,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.barcode_reader),
                      labelText: 'Barcode Number',
                      labelStyle: TextStyle(fontSize: 25),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      errorStyle: TextStyle(color: Colors.red, fontSize: 14)),
                  controller: barcodecontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Product Barcode Number ';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: Padding(
                  padding: const EdgeInsets.all(1),
                  child: TextFormField(
                    controller: datecontroller,
                    autofocus: false,
                    decoration: const InputDecoration(
                        icon: Icon(
                          Icons.calendar_month_rounded,
                        ),
                        labelText: 'Click the Icon to Select',
                        labelStyle: TextStyle(fontSize: 25),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        errorStyle: TextStyle(color: Colors.red, fontSize: 14)),
                    onTap: () async {
                      DateTime? pickeddate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1990),
                          lastDate: DateTime(2060));
                      if (pickeddate != null) {
                        setState(() {
                          datecontroller.text =
                              DateFormat('dd-MM-yyyy').format(pickeddate);
                        });
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Product Date';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                        255,
                        212,
                        20,
                        52,
                      )),
                      onPressed: () => {
                            if (_form.currentState!.validate())
                              {
                                setState(() {
                                  productname = namecontroller.text;
                                  productquantity = quantitycontroller.text;
                                  barcode = barcodecontroller.text;
                                  date = datecontroller.text;
                                  addUser();
                                  clearText();
                                })
                              }
                          },
                      child: const Text(
                        'Add to Products',
                        style: TextStyle(fontSize: 18),
                      )),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                          255,
                          212,
                          20,
                          52,
                        ),
                      ),
                      onPressed: () => {clearText()},
                      child: const Text(
                        'Reset',
                        style: TextStyle(fontSize: 18),
                      ))
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
