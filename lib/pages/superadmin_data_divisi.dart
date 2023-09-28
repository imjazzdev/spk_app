import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:spk_app/pages/componen/item_data.dart';
import 'package:spk_app/pages/superadmin_tambah_divisi.dart';
import 'package:spk_app/pages/superadmin_update_divisi.dart';
import 'package:spk_app/utils/var_global.dart';

import '../utils/colors.dart';

class DataDivisi extends StatelessWidget {
  final divisi = FirebaseFirestore.instance.collection('divisi');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DATA DIVISI'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: divisi.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
                padding: EdgeInsets.only(left: 20, right: 20),
                children: snapshot.data!.docs
                    .map((e) => ItemData(
                          id: e['id_divisi'],
                          title: 'DIVISI',
                          subtitle: e['divisi'],
                          widget: [
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => UpdateDivisi(
                                          id: e['id_divisi'],
                                        ),
                                      ));
                                },
                                icon: Icon(Icons.create)),
                            SizedBox(
                              width: 5,
                            ),
                            IconButton(
                                onPressed: () {
                                  divisi.doc('${e['id_divisi']}').delete();
                                },
                                icon: Icon(Icons.delete))
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
          Navigator.pushNamed(context, '/superadmin-tambah-divisi');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
