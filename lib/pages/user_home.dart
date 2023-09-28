import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:spk_app/pages/user_detail_spk.dart';
import 'package:spk_app/pages/user_history_tiket.dart';
import 'package:spk_app/utils/var_global.dart';

import '../utils/colors.dart';
import 'componen/item_data.dart';

class UserHome extends StatelessWidget {
  final tiket = FirebaseFirestore.instance
      .collection('tiket')
      .where('user', isEqualTo: '${VarGlobal.USER_NOW}');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        EdgeInsets.only(left: 20, right: 20, top: 7, bottom: 7),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: ColorSelect.caccents.withOpacity(0.2)),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 23,
                          backgroundColor: ColorSelect.caccents,
                          child: Icon(
                            Icons.person,
                            color: Colors.grey.shade100,
                            size: 40,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'HALLO,',
                              style: TextStyle(fontSize: 22),
                            ),
                            Text(
                              'USER',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: SizedBox(
                      height: 20,
                    ),
                  ),
                  Text('LIST TIKET SPK'),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Divider(
                        thickness: 1.5,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              flex: 4,
              child: StreamBuilder<QuerySnapshot>(
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
                                                      UserDetailSPK(
                                                    id_tiket: e['id_tiket'],
                                                    imgURL: e['foto'],
                                                    status: e['status'],
                                                    user: e['user'],
                                                    divisi: e['divisi'],
                                                    kerusakan: e['keluhan'],
                                                    tgl_buat: e['tgl_buat'],
                                                    staf_it:
                                                        e['staf_it'] ?? '-',
                                                    tgl_selesai:
                                                        e['tgl_selesai'] ?? '-',
                                                    solusi: e['solusi'] ?? '-',
                                                  ),
                                                ));
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
              )),
        ],
      )),
      bottomNavigationBar: Container(
        color: ColorSelect.caccents,
        height: 60,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.home_filled,
                  color: Colors.grey.shade200,
                  size: 40,
                )),
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/user-person');
                },
                icon: Icon(Icons.settings, size: 40)),
          ],
        ),
      ),
    );
  }
}
