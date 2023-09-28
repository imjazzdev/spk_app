import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:spk_app/pages/superadmin_detail_karyawan.dart';
import 'package:spk_app/pages/superadmin_tambah_karyawan.dart';
import 'package:spk_app/pages/superadmin_update_karyawan.dart';

import '../utils/colors.dart';
import 'componen/item_data.dart';

class DataKaryawan extends StatelessWidget {
  final karyawan = FirebaseFirestore.instance.collection('karyawan');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DATA KARYAWAN'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: karyawan.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
                padding: EdgeInsets.only(left: 20, right: 20),
                children: snapshot.data!.docs
                    .map((e) => ItemData(
                          id: e['id_karyawan'],
                          title: 'NAMA',
                          subtitle: e['nama'],
                          widget: [
                            Expanded(
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailKaryawan(
                                              id: e['id_karyawan'],
                                              nama: e['nama'],
                                              divisi: e['divisi'],
                                              username: e['username'],
                                              level: e['level']),
                                        ));
                                  },
                                  icon: Icon(Icons.remove_red_eye_rounded)),
                            ),
                            Expanded(
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => UpdateKaryawan(
                                            id: e['id_karyawan'],
                                          ),
                                        ));
                                  },
                                  icon: Icon(Icons.create)),
                            ),
                            Expanded(
                              child: IconButton(
                                  onPressed: () {
                                    karyawan
                                        .doc('${e['id_karyawan']}')
                                        .delete();
                                  },
                                  icon: Icon(Icons.delete)),
                            )
                          ],
                        ))
                    .toList());
          } else {
            return Center(child: Text('Loading...'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/superadmin-tambah-karyawan');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
