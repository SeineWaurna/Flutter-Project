import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Homework3Page()));
}

class Homework3Page extends StatefulWidget {
  const Homework3Page({Key? key}) : super(key: key);

  @override
  State<Homework3Page> createState() => _Homework3PageState();
}

class _Homework3PageState extends State<Homework3Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular News'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 600,
              height: 200,
              color: Colors.blue,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 600,
              height: 200,
              color: Colors.blue,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 600,
              height: 200,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
