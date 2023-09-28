import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/var_global.dart';

class TambahKaryawan extends StatefulWidget {
  const TambahKaryawan({super.key});

  @override
  State<TambahKaryawan> createState() => _TambahKaryawanState();
}

class _TambahKaryawanState extends State<TambahKaryawan> {
  TextEditingController namaC = TextEditingController();
  TextEditingController usernameC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  final divisi = FirebaseFirestore.instance.collection('divisi');
  String? dropdownvalueDivisi = 'PRODUKSI';
  String dropdownvalueLevel = 'SUPER ADMIN';

  var level = [
    'SUPER ADMIN',
    'TEKNISI',
    'USER',
  ];

  Future createUser() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: '${usernameC.text}@gmail.com', password: passwordC.text);

    VarGlobal.id_user++;
    final doc = FirebaseFirestore.instance
        .collection('user')
        .doc('${VarGlobal.id_user}');
    final user = User(
        id: VarGlobal.id_user,
        nama: namaC.text,
        username: usernameC.text,
        password: passwordC.text,
        level: dropdownvalueLevel);
    final json = user.toJson();
    await doc.set(json);
  }

  Future createKaryawan() async {
    VarGlobal.id_karyawan++;
    final doc = FirebaseFirestore.instance
        .collection('karyawan')
        .doc('${VarGlobal.id_karyawan}');
    final karyawan = Karyawan(
        id: VarGlobal.id_karyawan,
        nama: namaC.text,
        divisi: dropdownvalueDivisi ?? 'PRODUKSI',
        username: usernameC.text,
        password: passwordC.text,
        level: dropdownvalueLevel);

    final json = karyawan.toJson();
    await doc.set(json);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TAMBAH KARYAWAN'),
        centerTitle: true,
      ),
      body: Container(
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
            textCapitalization: TextCapitalization.characters,
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
            decoration:
                BoxDecoration(border: Border.all(color: Colors.grey.shade500)),
            child: FutureBuilder<QuerySnapshot>(
                future: divisi.get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return DropdownButton(
                      value: dropdownvalueDivisi,
                      hint: const Text('SELECT DIVISI'),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: snapshot.data!.docs.map((e) {
                        return DropdownMenuItem(
                          value: e['divisi'],
                          child: Text(
                            '${e['divisi']}',
                            style: TextStyle(
                                fontSize: 20, color: Colors.grey.shade600),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          if (dropdownvalueDivisi!.isNotEmpty) {
                            dropdownvalueDivisi = value.toString();
                          }
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
            textCapitalization: TextCapitalization.characters,
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
            textCapitalization: TextCapitalization.characters,
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
            decoration:
                BoxDecoration(border: Border.all(color: Colors.grey.shade500)),
            child: DropdownButton(
              value: dropdownvalueLevel,
              hint: const Text('SELECT LEVEL'),
              icon: const Icon(Icons.keyboard_arrow_down),
              items: level.map((String level) {
                return DropdownMenuItem(
                  value: level,
                  child: Text(
                    level,
                    style: TextStyle(fontSize: 20, color: Colors.grey.shade600),
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
                    namaC.text == '' ||
                    usernameC.text == null ||
                    usernameC.text == '' ||
                    passwordC.text == null ||
                    passwordC.text == '' ||
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
                  createUser();
                  createKaryawan();
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
      ),
    );
  }
}

class User {
  int id;
  final String nama;
  final String username;
  final String password;
  final String level;

  User({
    required this.id,
    required this.nama,
    required this.username,
    required this.password,
    required this.level,
  });

  Map<String, dynamic> toJson() => {
        'id_karyawan': id,
        'nama': nama,
        'username': username,
        'password': password,
        'level': level,
      };
}

class Karyawan {
  int id;
  final String nama;
  final String divisi;
  final String username;
  final String password;
  final String level;

  Karyawan({
    required this.id,
    required this.nama,
    required this.divisi,
    required this.username,
    required this.password,
    required this.level,
  });

  Map<String, dynamic> toJson() => {
        'id_karyawan': id,
        'nama': nama,
        'divisi': divisi,
        'username': username,
        'password': password,
        'level': level,
      };
}
