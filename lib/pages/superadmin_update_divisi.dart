import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class UpdateDivisi extends StatefulWidget {
  final int id;
  UpdateDivisi({required this.id});

  @override
  State<UpdateDivisi> createState() => _UpdateDivisiState();
}

class _UpdateDivisiState extends State<UpdateDivisi> {
  TextEditingController divisiC = TextEditingController();

  Future updatedivisi() async {
    final docdivisi =
        FirebaseFirestore.instance.collection('divisi').doc('${widget.id}');
    docdivisi.update({'divisi': divisiC.text});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UPDATE DIVISI\nID : ${widget.id}'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 40, right: 40),
        child: Column(children: [
          SizedBox(
            height: 20,
          ),
          Text(
            'UPDATE DIVISI',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: divisiC,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'DIVISI',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                if (divisiC.text == null || divisiC.text == '') {
                  AwesomeDialog(
                    context: context,
                    animType: AnimType.scale,
                    dialogType: DialogType.error,
                    body: const Center(
                      child: Text(
                        'MOHON LENGKAPI DATA',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    btnOkOnPress: () {},
                  ).show();
                } else {
                  updatedivisi();
                  AwesomeDialog(
                    context: context,
                    animType: AnimType.scale,
                    dialogType: DialogType.success,
                    body: const Center(
                      child: Text(
                        'Data Tersimpan',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    btnOkOnPress: () {
                      Navigator.pop(context);
                    },
                  ).show();
                }
              },
              child: Text('SUBMIT'))
        ]),
      ),
    );
  }
}
