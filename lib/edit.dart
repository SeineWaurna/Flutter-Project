import 'package:allergy_application/database/database_helper.dart';
import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  int id;

  EditPage({Key? key, required this.id}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState(id);
}

class _EditPageState extends State<EditPage> {
  int id;

  _EditPageState(this.id);

  final _dbHelper = DatabaseHelper.instance;

  TextEditingController _q1Controller = TextEditingController();
  TextEditingController _q2Controller = TextEditingController();

  void initState() {
    super.initState();
    getRowById();
  }

  void getRowById() async {
    final row = await _dbHelper.queryIdRow(id);
    print(row);
    row.forEach((element) {
      _q1Controller.text = element['name'];
      _q2Controller.text = element['age'].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Page'),
      ),
      body: Column(
        children: [
          Text('id: $id'),
          TextFormField(
            controller: _q1Controller,
            decoration: const InputDecoration(
              labelText: 'Name',
            ),
          ),
          TextFormField(
            controller: _q2Controller,
            decoration: const InputDecoration(
              labelText: 'Age',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _dbHelper.update(
                id: id,
                {
                  DatabaseHelper.columnName: _q1Controller.text,
                  DatabaseHelper.columnAge: int.parse(_q2Controller.text),
                },
              );
              Navigator.pop(context);
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }
}