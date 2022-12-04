import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:allergy_application/database/database_helper.dart';
import 'package:allergy_application/edit.dart';

class Page2 extends StatefulWidget {
  Page2({Key? key}) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  final storage = new FlutterSecureStorage();

  final dbHelper = DatabaseHelper.instance;

  final _formKey = GlobalKey<FormState>();
  TextEditingController _q1Controller = TextEditingController();
  TextEditingController _q2Controller = TextEditingController();
  TextEditingController _q3Controller = TextEditingController();

  static const List<String> list = <String>[
    'โปรดเลือกยา',
    'พาราเซนตามอล',
    'บลูเฟ็น',
    'อื่นๆ'
  ];

  List<Map> _data = [];

  int sum = 0;
  int q3 = 0;
  bool _q3other = false;

  String _q3otherText = 'โปรดเลือกยา';

  final snackBar = SnackBar(
    content: Text('กรุณากรอกข้อมูลให้ครบถ้วน'),
    action: SnackBarAction(
      label: 'ยกเลิก',
      onPressed: () {
        print('cancel');
      },
    ),
  );

  void initState() {
    super.initState();
    _query();
    // storage.write(key: 'no', value: '1');
    // storage.write(key: 'name', value: 'Jack');
    // storage.read(key: 'name').then((v) {
    //   if (v != null) {
    //     print(v);
    //   }
    // });
  }

  Future _showString() async {
    return await storage.readAll();
  }

  Widget _widgetQ1() {
    return TextFormField(
      controller: _q1Controller,
      decoration: InputDecoration(
        labelText: 'ชื่อ-นามสกุล',
        hintText: 'ชื่อ-นามสกุล',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'กรุณากรอกข้อมูล';
        }
        return null;
      },
    );
  }

  Widget _widgetQ2() {
    return TextFormField(
      controller: _q2Controller,
      decoration: InputDecoration(
        labelText: 'อายุ',
        hintText: 'อายุ',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'กรุณากรอกข้อมูล';
        }
        return null;
      },
    );
  }

  void _insert() async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnName: _q1Controller.text,
      DatabaseHelper.columnAge: _q2Controller.text
    };
    final id = await dbHelper.insert(row);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('บันทึกข้อมูลสำเร็จ'),
      ),
    );
    _q1Controller.clear();
    _q2Controller.clear();
    _query();
  }

  void _query() async {
    final allRows = await dbHelper.queryAllRow();
    print('query all rows:');
    setState(() {
      _data = allRows;
    });
    allRows.forEach((row) => print(row));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แบบสอบถาม'),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(children: [
              _widgetQ1(),
              _widgetQ2(),
              // Text('ตำถาม 1 : โปรดให้คะแนนความเจ็บปวด 1 - 5 คะแนน'),
              // TextFormField(
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter some text';
              //     }
              //     if (int.parse(value) < 1 || int.parse(value) > 5) {
              //       return 'Please enter number between 1 - 5';
              //     }
              //     return null;
              //   },
              //   decoration: InputDecoration(
              //     labelText: 'คำตอบ',
              //   ),
              //   controller: _q1Controller,
              // ),
              // Text('ตำถาม 2 : โปรดระบุจำนวนวันที่เจ็บปวด 1 - 30 วัน'),
              // TextFormField(
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter some text';
              //     }
              //     if (int.parse(value) < 1 || int.parse(value) > 30) {
              //       return 'Please enter number between 1 - 5';
              //     }
              //     return null;
              //   },
              //   decoration: InputDecoration(
              //     labelText: 'คำตอบ',
              //   ),
              //   controller: _q2Controller,
              // ),
              // Text('ตำถาม 3 : ท่านได้รับประทานยาอะไรก่อนหน้านี้'),
              // DropdownButton<String>(
              //   value: _q3otherText,
              //   items: list.map((String value) {
              //     return DropdownMenuItem<String>(
              //       value: value,
              //       child: Text(value),
              //     );
              //   }).toList(),
              //   onChanged: (String? newValue) {
              //     print(newValue);
              //     setState(() {
              //       if (newValue == 'อื่นๆ') {
              //         _q3other = true;
              //         q3 = 10;
              //       } else {
              //         if (newValue == 'พาราเซนตามอล') {
              //           q3 = 1;
              //         } else if (newValue == 'บลูเฟ็น') {
              //           q3 = 2;
              //         }
              //         _q3other = false;
              //       }
              //       _q3otherText = newValue!;
              //     });
              //   },
              // ),
              // _q3other ? TextFormField(
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter some text';
              //     }
              //     return null;
              //   },
              //   decoration: InputDecoration(
              //     labelText: 'คำตอบ',
              //   ),
              //   controller: _q3Controller,
              // ) : Container(),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // _showString().then((value) => print(value));
                    // if (_q1Controller.text.isEmpty) {
                    //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    // }
                    // if (_formKey.currentState!.validate()) {
                    //   print('q1: ${_q1Controller.text}');
                    //   print('q2: ${_q2Controller.text}');
                    //   setState(() {
                    //     sum = int.parse(_q1Controller.text) + int.parse(_q2Controller.text) + q3;
                    //   });
                    // }
                    if (_formKey.currentState!.validate()) {
                      _insert();
                    }
                  },
                  child: Text('Save'),
                ),
              ),
              Container(
                height: 400,
                child: ListView.builder(
                  itemCount: _data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(_data[index]['name']),
                      subtitle: Text(_data[index]['age'].toString()),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditPage(
                                          id: _data[index]['_id'],
                                        ))).then((value) => _query());
                              },
                              icon: Icon(Icons.edit)),
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              dbHelper.delete(_data[index]['_id']);
                              _query();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
              // Text('คะแนนรวม: $sum'),
              // Text('คำแนะนำ: ${sum > 6 ? 'ควรพบแพทย์' : 'ไม่ควรพบแพทย์'}'),
            ])),
      ),
    );
  }
}