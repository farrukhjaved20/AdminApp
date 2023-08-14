// ignore_for_file: avoid_print, avoid_unnecessary_containers, file_names, use_key_in_widget_constructors, non_constant_identifier_names, prefer_const_constructors_in_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Updateproduct extends StatefulWidget {
  final String id;

  Updateproduct({required this.id});

  @override
  State<Updateproduct> createState() => _UpdateproductState();
}

class _UpdateproductState extends State<Updateproduct> {
  final _form = GlobalKey<FormState>();

  CollectionReference products =
      FirebaseFirestore.instance.collection('Posapp');

  Future<void> UpdateUser(id, productname, productquantity, barcode, date) {
    //  print('User Product  Deleted  $id');
    return products
        .doc(id)
        .update({
          'productname': productname,
          'productquantity': productquantity,
          'barcode': barcode,
          'date': date
        })
        .then((value) => print('Product Updated'))
        .catchError((Error) => print('product error to add : $Error'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Update Products'),
          backgroundColor: const Color.fromARGB(255, 212, 20, 52),
        ),
        body: Form(
            key: _form,
            child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              future: FirebaseFirestore.instance
                  .collection('Posapp')
                  .doc(widget.id)
                  .get(),
              builder: (_, snapshot) {
                if (snapshot.hasError) {
                  print('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                var data = snapshot.data!.data();
                var productname = data!['productname'];
                var productqunatity = data['productquantity'];
                var barcode = data['barcode'];
                var date = data['date'];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 30),
                        child: TextFormField(
                          initialValue: productname,
                          autofocus: false,
                          decoration: const InputDecoration(
                              labelText: 'Product Name',
                              labelStyle: TextStyle(fontSize: 25),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              errorStyle:
                                  TextStyle(color: Colors.red, fontSize: 14)),
                          onChanged: (value) => {productname = value},
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Product';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 30),
                        child: TextFormField(
                          initialValue: productqunatity,
                          autofocus: false,
                          decoration: const InputDecoration(
                              labelText: 'Qunatity',
                              labelStyle: TextStyle(fontSize: 25),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              errorStyle:
                                  TextStyle(color: Colors.red, fontSize: 14)),
                          onChanged: (value) => {productqunatity = value},
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Product Quantity';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 30),
                        child: TextFormField(
                          initialValue: barcode,
                          autofocus: false,
                          decoration: const InputDecoration(
                              labelText: 'Barcode Number',
                              labelStyle: TextStyle(fontSize: 25),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              errorStyle:
                                  TextStyle(color: Colors.red, fontSize: 14)),
                          onChanged: (value) => {barcode = value},
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Product Barcode Number ';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 30),
                        child: TextFormField(
                          initialValue: date,
                          autofocus: false,
                          decoration: const InputDecoration(
                              labelText: 'Product Date',
                              labelStyle: TextStyle(fontSize: 25),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              errorStyle:
                                  TextStyle(color: Colors.red, fontSize: 14)),
                          onChanged: (value) => {date = value},
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Product Date';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 212, 20, 52),
                              ),
                              onPressed: () {
                                if (_form.currentState!.validate()) {
                                  setState(() {
                                    UpdateUser(widget.id, productname,
                                        productqunatity, barcode, date);
                                    Navigator.pop(context);
                                  });
                                }
                              },
                              child: const Text(
                                'Update Products',
                                style: TextStyle(fontSize: 18),
                              )),
                        ],
                      ))
                    ],
                  ),
                );
              },
            )));
  }
}
