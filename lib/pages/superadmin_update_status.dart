import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class UpdateStatus extends StatefulWidget {
  final int id;
  UpdateStatus({required this.id});

  @override
  State<UpdateStatus> createState() => _UpdateStatusState();
}

class _UpdateStatusState extends State<UpdateStatus> {
  TextEditingController statusC = TextEditingController();

  Future updateStatus() async {
    final docLevel =
        FirebaseFirestore.instance.collection('status').doc('${widget.id}');
    docLevel.update({'status': statusC.text});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UPDATE STATUS\nID : ${widget.id}'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 40, right: 40),
        child: Column(children: [
          SizedBox(
            height: 20,
          ),
          Text(
            'UPDATE STATUS',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: statusC,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'STATUS',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                updateStatus();
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
