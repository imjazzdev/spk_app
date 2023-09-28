import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:spk_app/utils/var_global.dart';

class UpdateKaryawan extends StatefulWidget {
  final int id;
  UpdateKaryawan({required this.id});

  @override
  State<UpdateKaryawan> createState() => _UpdateKaryawanState();
}

class _UpdateKaryawanState extends State<UpdateKaryawan> {
  TextEditingController namaC = TextEditingController();
  TextEditingController usernameC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  final divisi = FirebaseFirestore.instance.collection('divisi');
  String? dropdownvalueDivisi;
  String? dropdownvalueLevel;

  var level = [
    'SUPER ADMIN',
    'TEKNISI',
    'USER',
  ];
  final dockaryawan = FirebaseFirestore.instance.collection('karyawan');
  Future updatekaryawan() async {
    final doc =
        FirebaseFirestore.instance.collection('karyawan').doc('${widget.id}');
    doc.update({
      'nama': namaC.text,
      'divisi': dropdownvalueDivisi,
      'username': usernameC.text,
      'password': passwordC.text,
      'level': dropdownvalueLevel,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UPDATE KARYAWAN\nID : ${widget.id}'),
        centerTitle: true,
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: dockaryawan.get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: ListView(children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'NAMA KARYAWAN',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: namaC,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'NAMA',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'DIVISI',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  alignment: Alignment.centerLeft,
                  height: 60,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade500)),
                  child: FutureBuilder<QuerySnapshot>(
                      future: divisi.get(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return DropdownButton(
                            hint: const Text('SELECT DIVISI'),
                            value: dropdownvalueDivisi == null
                                ? null
                                : dropdownvalueDivisi,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: snapshot.data!.docs.map((e) {
                              return DropdownMenuItem(
                                value: e['divisi'],
                                child: Text(
                                  '${e['divisi']}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.grey.shade600),
                                ),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                dropdownvalueDivisi = newValue as String?;
                              });
                            },
                          );
                        } else {
                          return const Text('LOADING...');
                        }
                      }),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'USERNAME',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: usernameC,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'USERNAME',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'PASSWORD',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: passwordC,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'PASSWORD',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'LEVEL',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  alignment: Alignment.centerLeft,
                  height: 60,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade500)),
                  child: DropdownButton(
                    value: dropdownvalueLevel,
                    hint: const Text('SELECT LEVEL'),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: level.map((String level) {
                      return DropdownMenuItem(
                        value: level,
                        child: Text(
                          level,
                          style: TextStyle(
                              fontSize: 20, color: Colors.grey.shade600),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalueLevel = newValue!;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (namaC.text == null ||
                          usernameC.text == null ||
                          passwordC.text == null ||
                          dropdownvalueDivisi == null ||
                          dropdownvalueLevel == null) {
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
                        updatekaryawan();
                        AwesomeDialog(
                          context: context,
                          animType: AnimType.scale,
                          dialogType: DialogType.success,
                          body: const Center(
                            child: Text(
                              'DATA DISIMPAN',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                          btnOkOnPress: () {},
                        ).show();
                      }
                    },
                    child: const Text('SUBMIT'))
              ]),
            );
          } else {
            return const Text('Data Kosong');
          }
        },
      ),
    );
  }
}
