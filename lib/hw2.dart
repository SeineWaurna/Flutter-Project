import 'package:allergy_application/page2.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'IMATTHIO',
      home: Page1(),
    );
  }
}

class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IMATTHIO'),
      ),
      body: Center(
        child: GestureDetector(
          child: Text('เริ่มทำแบบสอบถาม'),
          onTap: () {
            print('go to page 2');
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Page2()),
            );
          },
        ),
      ),
    );
  }
}