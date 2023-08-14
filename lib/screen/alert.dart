import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Alert extends StatefulWidget {
  static const routName = '/alert';
  const Alert({super.key});

  @override
  State<Alert> createState() => _AlertState();
}

class _AlertState extends State<Alert> {
  final Stream<QuerySnapshot> productstream = FirebaseFirestore.instance
      .collection('Posapp')
      .where('productquantity', isLessThanOrEqualTo: '0')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 212, 20, 52),
            title: const Text('Product Alert')),
        body: StreamBuilder<QuerySnapshot>(
            stream: productstream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                print('Somethings');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              final List storedocs = [];
              snapshot.data!.docs.map((DocumentSnapshot document) {
                Map a = document.data() as Map<String, dynamic>;
                storedocs.add(a);
              }).toList();

              return Column(
                children: <Widget>[
                  const Text(
                    'Product Stock',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24)),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Table(
                          columnWidths: const <int, TableColumnWidth>{
                            0: FixedColumnWidth(90),
                          },
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          children: [
                            const TableRow(
                              children: [
                                TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Product Name',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Center(
                                    child: Text(
                                      'Quantity',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Center(
                                      child: Text(
                                        'Create Date',
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Center(
                                      child: Text(
                                        'Product Code',
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            for (var i = 0; i < storedocs.length; i++) ...[
                              TableRow(children: [
                                TableCell(
                                  child: Center(
                                      child: Text(storedocs[i]['productname'])),
                                ),
                                TableCell(
                                  child: Center(
                                    child:
                                        Text(storedocs[i]['productquantity']),
                                  ),
                                ),
                                TableCell(
                                  child:
                                      Center(child: Text(storedocs[i]['date'])),
                                ),
                                TableCell(
                                  child: Center(
                                    child: Text(
                                      storedocs[i]['barcode'],
                                    ),
                                  ),
                                ),
                              ]),
                            ]
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }));
  }
}
