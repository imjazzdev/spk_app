import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:spk_app/pages/admin_update_detail.dart';
import 'package:spk_app/pages/user_detail_spk.dart';
import 'package:spk_app/pages/user_history_tiket.dart';

import '../utils/colors.dart';
import 'componen/item_data.dart';

class AdminUpdateSPK extends StatelessWidget {
  final tiket = FirebaseFirestore.instance.collection('tiket');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UPDATE SPK'),
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
                                                AdminUpdateDetail(
                                                  id: e['id_tiket'],
                                                )));
                                  },
                                  icon: Icon(
                                    Icons.create,
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
                  size: 40,
                )),
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/admin-person');
                },
                icon: Icon(
                  Icons.person,
                  size: 40,
                  color: Colors.grey.shade200,
                )),
          ],
        ),
      ),
    );
  }
}
