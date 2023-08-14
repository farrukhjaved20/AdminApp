// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClockWidget extends StatelessWidget {
  const ClockWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream.periodic(const Duration(seconds: 1)),
      builder: (context, snapshot) {
        return Container(
          alignment: Alignment.centerLeft,
          color: const Color.fromARGB(255, 212, 20, 52),
          child: Text(
            DateFormat('dd/MM/yyyy hh:mm:ss').format(DateTime.now()),
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
        );
      },
    );
  }
}
