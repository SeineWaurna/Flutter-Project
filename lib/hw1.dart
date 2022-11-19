import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    home: GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount
        (crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () => print(index),
          child: Container(
            child: Text('Row $index'),
          ),
        );
      },
    ),
//      home: ListView.builder(
//          itemCount: 3,
//          padding: const EdgeInsets.all(3),
//          itemBuilder: (BuildContext context, int index) {
//            return OutlinedButton(onPressed: () {
//             print(index+1);
//            }, child: Text('hello [${index+1}]'));
//
//          }
//      ),
    );
  }
}