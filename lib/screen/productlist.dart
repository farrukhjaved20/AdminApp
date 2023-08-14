import 'package:auth/models/product.dart';
import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {
  static const routName = '/productlist';
  const ProductList({super.key});

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> _products = [];
  SortBy _sortBy = SortBy.ASCENDING_QUANTITY;

  @override
  void initState() {
    super.initState();
    _getProducts();
  }

  void _getProducts() async {
    List<Product> products = await FirebaseService().getProducts();
    setState(() {
      _products = products;
    });
  }

  void _sortProducts() {
    setState(() {
      if (_sortBy == SortBy.ASCENDING_QUANTITY) {
        _products.sort((a, b) => a.quantity.compareTo(b.quantity));
        _sortBy = SortBy.DESCENDING_QUANTITY;
      } else {
        _products.sort((a, b) => b.quantity.compareTo(a.quantity));
        _sortBy = SortBy.ASCENDING_QUANTITY;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 212, 20, 52),
        title: const Text('Product List'),
        actions: [
          PopupMenuButton<SortBy>(
            onSelected: (sortBy) {
              _sortProducts();
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<SortBy>(
                value: SortBy.ASCENDING_QUANTITY,
                child: Text('Sort by Ascending Quantity'),
              ),
              const PopupMenuItem<SortBy>(
                value: SortBy.DESCENDING_QUANTITY,
                child: Text('Sort by Descending Quantity'),
              ),
            ],
          ),
        ],
      ),
      body: ProductTable(products: _products),
    );
  }
}

class ProductTable extends StatelessWidget {
  final List<Product> products;

  const ProductTable({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      // ignore: prefer_const_literals_to_create_immutables
      columns: [
        const DataColumn(
          label: Text(
            'Name',
            style: TextStyle(fontSize: 18),
          ),
        ),
        const DataColumn(
            label: Text(
          'Quantity',
          style: TextStyle(fontSize: 18),
        )),
        const DataColumn(
            label: Text(
          'date',
          style: TextStyle(fontSize: 18),
        )),
        const DataColumn(
            label: Text(
          'Barcode',
          style: TextStyle(fontSize: 18),
        )),
      ],
      rows: products.map((product) {
        return DataRow(cells: [
          DataCell(
            Text(
              product.name,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          DataCell(Text(
            product.quantity,
            style: const TextStyle(fontSize: 18),
          )),
          DataCell(Text(
            product.date,
            style: const TextStyle(fontSize: 18),
          )),
          DataCell(Text(
            product.barcode,
            style: const TextStyle(fontSize: 18),
          )),
        ]);
      }).toList(),
    );
  }
}
