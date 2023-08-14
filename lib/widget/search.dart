// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List Searchresults = [];
  void searchfromfirebase(String query) async {
    final result = await FirebaseFirestore.instance
        .collection('Posapp')
        .where('barcode', isEqualTo: query)
        .get();
    setState(() {
      Searchresults = result.docs.map((e) => e.data()).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        backgroundColor: const Color.fromARGB(255, 212, 20, 52),
      ),
      body: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            width: MediaQuery.of(context).size.width - 300,
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: 'Enter Barcode '),
              onChanged: (query) {
                searchfromfirebase(query);
              },
            ),
          ),
        ),
        Expanded(
            child: ListView.builder(
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Barode number & Quantity Showed',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                SizedBox(
                  height: 130,
                  width: 300,
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: ListTile(
                      splashColor: Colors.white70,
                      tileColor: const Color.fromARGB(255, 212, 20, 52),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      onTap: () {},
                      title: Text(
                        Searchresults[index]['barcode'],
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      subtitle: Text(
                        Searchresults[index]['productquantity'],
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      visualDensity: VisualDensity.comfortable,
                    ),
                  ),
                ),
              ],
            );
          },
          itemCount: Searchresults.length,
        ))
      ]),
    );
  }
}
