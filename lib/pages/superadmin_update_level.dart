import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:spk_app/utils/var_global.dart';

class UpdateLevel extends StatefulWidget {
  final int id;
  UpdateLevel({required this.id});

  @override
  State<UpdateLevel> createState() => _UpdateLevelState();
}

class _UpdateLevelState extends State<UpdateLevel> {
  TextEditingController levelC = TextEditingController();

  Future updateLevel() async {
    final docLevel =
        FirebaseFirestore.instance.collection('level').doc('${widget.id}');
    docLevel.update({'level': levelC.text});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UPDATE LEVEL\nID : ${widget.id}'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 40, right: 40),
        child: Column(children: [
          SizedBox(
            height: 20,
          ),
          Text(
            'UPDATE LEVEL',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: levelC,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'LEVEL',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                updateLevel();
                AwesomeDialog(
                  context: context,
                  animType: AnimType.scale,
                  dialogType: DialogType.success,
                  body: const Center(
                    child: Text(
                      'Data Tersimpan',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  btnOkOnPress: () {},
                ).show();
              },
              child: Text('SUBMIT'))
        ]),
      ),
    );
  }
}
