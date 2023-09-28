import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../utils/var_global.dart';

class TambahDivisi extends StatefulWidget {
  const TambahDivisi({super.key});

  @override
  State<TambahDivisi> createState() => _TambahDivisiState();
}

class _TambahDivisiState extends State<TambahDivisi> {
  TextEditingController divisiC = TextEditingController();

  Future createDivisi() async {
    VarGlobal.id_divisi++;
    final doc = FirebaseFirestore.instance
        .collection('divisi')
        .doc('${VarGlobal.id_divisi}');
    final divisi = Divisi(id: VarGlobal.id_divisi, divisi: divisiC.text);

    final json = divisi.toJson();
    await doc.set(json);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TAMBAH DIVISI'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 40, right: 40),
        child: Column(children: [
          SizedBox(
            height: 20,
          ),
          Text(
            'DIVISI',
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
                  createDivisi();
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
                    btnOkOnPress: () {},
                  ).show();
                }
              },
              child: Text('SUBMIT'))
        ]),
      ),
    );
  }
}

class Divisi {
  int id;
  final String divisi;

  Divisi({
    required this.id,
    required this.divisi,
  });

  Map<String, dynamic> toJson() => {
        'id_divisi': id,
        'divisi': divisi,
      };
}
