import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Homework2Page()));
}

class Homework2Page extends StatefulWidget {
  const Homework2Page({Key? key}) : super(key: key);

  @override
  State<Homework2Page> createState() => _Homework2PageState();
}

class _Homework2PageState extends State<Homework2Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NewsHour - Admin'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'Cover Picture Url',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'title',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
              },
              child: Text('Save Data'),
            ),
          ),
        ],

      ),
    );
  }
}
