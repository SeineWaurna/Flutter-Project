import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  void_onPressed() {
    print('Pressed');
  }

@override
Widget build(BuildContext context) {
  return MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: ListView.builder(
      itemCount: 3,
      padding: const EdgeInsets.all(3),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 50,
          color: Colors.amber[index],
          child: Center(child: Text('hello @(enteries[index]}')),
        );
      }
    ),
  );
}
}