import 'package:auth/screen/updateproduct.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  static const routName = '/dashboard';
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final Stream<QuerySnapshot> productStream =
      FirebaseFirestore.instance.collection('Posapp').snapshots();

  CollectionReference products =
      FirebaseFirestore.instance.collection('Posapp');

  Future<void> deleteUser(id) {
    return products
        .doc(id)
        .delete()
        .then((value) => print('Deleted'))
        .catchError((error) => print('Failed to delete product: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DashBoard View'),
        backgroundColor: const Color.fromARGB(255, 212, 20, 52),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: productStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Somethings');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final List<Map<String, dynamic>> storeDocs =
              snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> a = document.data() as Map<String, dynamic>;
            a['id'] = document.id;
            return a;
          }).toList();

          return Container(
            margin: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Table(
                columnWidths: const <int, TableColumnWidth>{
                  4: FixedColumnWidth(96),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(
                    children: [
                      TableCell(
                        child: SizedBox(
                          height: 150, // Adjust this value as needed
                          child: Image.asset('assets/images/Sling.jpg'),
                        ),
                      ),
                      const TableCell(
                        child: Center(
                          child: Text(
                            'Quantity',
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ),
                      ),
                      const TableCell(
                        child: Center(
                          child: Text(
                            'Create Date',
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ),
                      ),
                      TableCell(
                        child: SizedBox(
                          width: 150, // Adjust this value as needed
                          child: Image.asset('assets/images/OIP.jfif'),
                        ),
                      ),
                      const TableCell(
                        child: Center(
                          child: Text(
                            'Actions',
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                  for (var i = 0; i < storeDocs.length; i++) ...[
                    TableRow(
                      children: [
                        TableCell(
                          child: Center(
                            child: Text(
                              storeDocs[i]['productname'],
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Text(
                              storeDocs[i]['productquantity'],
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Text(
                              storeDocs[i]['date'],
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Text(
                              storeDocs[i]['barcode'],
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Updateproduct(id: storeDocs[i]['id']),
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.amber,
                                ),
                              ),
                              IconButton(
                                onPressed: () => deleteUser(storeDocs[i]['id']),
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
