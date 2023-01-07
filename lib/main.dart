import 'package:allergy_application/homework.dart';
import 'package:flutter/material.dart';
import 'package:allergy_application/home.dart';
import 'package:allergy_application/page2.dart';
import 'package:allergy_application/product.dart';
import 'package:allergy_application/profile.dart';


void main() {
  runApp(const MainPage());
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

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
  int _currentIndex = 0;
  final List _pages = [
    const HomePage(),
    // const Products(),
    // const Profile(),
    //Page2()
    Homework1Page()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.card_travel),
          //   label: 'Products',
          // ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.person),
          //   label: 'Profile',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Homework1Page',
            //label: 'Page 2',
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.pinkAccent,
      ),
    );
  }
}