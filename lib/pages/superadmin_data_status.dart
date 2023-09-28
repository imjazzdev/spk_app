import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:spk_app/pages/componen/item_data.dart';

import '../utils/colors.dart';
import '../utils/var_global.dart';

class DataStatus extends StatelessWidget {
  final status = FirebaseFirestore.instance.collection('status');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DATA STATUS'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: status.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              padding: EdgeInsets.only(left: 20, right: 20),
              children: snapshot.data!.docs
                  .map((e) => ItemData(
                        id: e['id_status'],
                        title: 'STATUS',
                        subtitle: e['status'],
                        widget: [
                          SizedBox(
                            width: 5,
                          ),
                          IconButton(
                              onPressed: () {
                                status.doc('${e['id_status']}').delete();
                              },
                              icon: Icon(Icons.delete))
                        ],
                      ))
                  .toList(),
            );
          } else {
            return Center(child: Text('Loading...'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/superadmin-tambah-status');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
