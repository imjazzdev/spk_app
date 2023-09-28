import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:spk_app/pages/user_detail_history.dart';
import 'package:spk_app/utils/var_global.dart';
import 'componen/item_data.dart';

class UserHistoryTiket extends StatelessWidget {
  final tiket = FirebaseFirestore.instance
      .collection('tiket')
      .where('status', isEqualTo: 'CLOSED').where('user', isEqualTo: VarGlobal.USER_NOW);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HISTORY TIKET'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: tiket.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
                padding: EdgeInsets.only(left: 20, right: 20),
                children: snapshot.data!.docs
                    .map((e) => ItemData(
                            id: e['id_tiket'],
                            title: 'STATUS',
                            subtitle: e['status'],
                            widget: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UserDetailHistory(
                                                  id_tiket: e['id_tiket'],
                                                  imgURL: e['foto'],
                                                  status: e['status'],
                                                  user: e['user'],
                                                  divisi: e['divisi'],
                                                  kerusakan: e['keluhan'],
                                                  tgl_buat: e['tgl_buat'],
                                                  staf_it: e['staf_it'],
                                                  tgl_selesai: e['tgl_selesai'],
                                                  solusi: e['solusi'],
                                                )));
                                  },
                                  icon: Icon(
                                    Icons.remove_red_eye_rounded,
                                    size: 30,
                                  ))
                            ]))
                    .toList());
          } else if (snapshot.hasData != true) {
            return Center(
              child: Text('BELUM ADA DATA'),
            );
          } else {
            return Center(
              child: Text('Loading...'),
            );
          }
        },
      ),
    );
  }
}
