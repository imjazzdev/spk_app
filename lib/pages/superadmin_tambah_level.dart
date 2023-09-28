import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:spk_app/utils/var_global.dart';

class TambahLevel extends StatefulWidget {
  const TambahLevel({super.key});

  @override
  State<TambahLevel> createState() => _TambahLevelState();
}

class _TambahLevelState extends State<TambahLevel> {
  TextEditingController levelC = TextEditingController();

  Future createLevel({required String level}) async {
    VarGlobal.id_level++;
    final docLevel = FirebaseFirestore.instance
        .collection('level')
        .doc('${VarGlobal.id_level}');
    final level = Level(id: VarGlobal.id_level, level: levelC.text);

    final json = level.toJson();
    await docLevel.set(json);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TAMBAH LEVEL'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 40, right: 40),
        child: Column(children: [
          SizedBox(
            height: 20,
          ),
          Text(
            'LEVEL',
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
                VarGlobal.id_level++;
                createLevel(level: levelC.text);

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
                  btnOkOnPress: () {
                    // Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => HomePage()));
                  },
                ).show();
              },
              child: Text('SUBMIT'))
        ]),
      ),
    );
  }
}

class Level {
  int id;
  final String level;

  Level({
    required this.id,
    required this.level,
  });

  Map<String, dynamic> toJson() => {
        'id_level': id,
        'level': level,
      };
}
