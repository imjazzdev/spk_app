import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'componen/item_data.dart';

class SuperAdminClosed extends StatelessWidget {
  final tiket = FirebaseFirestore.instance
      .collection('tiket')
      .where('status', isEqualTo: 'CLOSED');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('STATUS CLOSED'),
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
                        widget: []))
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
