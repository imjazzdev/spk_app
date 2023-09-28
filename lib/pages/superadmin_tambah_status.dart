import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../utils/var_global.dart';

class TambahStatus extends StatefulWidget {
  const TambahStatus({super.key});

  @override
  State<TambahStatus> createState() => _TambahStatusState();
}

class _TambahStatusState extends State<TambahStatus> {
  TextEditingController statusC = TextEditingController();

  Future createStatus() async {
    VarGlobal.id_status++;
    final doc = FirebaseFirestore.instance
        .collection('status')
        .doc('${VarGlobal.id_status}');
    final level = Status(id: VarGlobal.id_status, status: statusC.text);

    final json = level.toJson();
    await doc.set(json);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TAMBAH STATUS'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 40, right: 40),
        child: Column(children: [
          SizedBox(
            height: 20,
          ),
          Text(
            'STATUS',
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
                createStatus();

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

class Status {
  int id;
  final String status;

  Status({
    required this.id,
    required this.status,
  });

  Map<String, dynamic> toJson() => {
        'id_status': id,
        'status': status,
      };
}
