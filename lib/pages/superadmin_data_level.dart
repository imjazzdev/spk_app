import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:spk_app/pages/superadmin_update_level.dart';

import '../utils/colors.dart';
import 'componen/item_data.dart';

class DataLevel extends StatelessWidget {
  final level = FirebaseFirestore.instance.collection('level');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DATA LEVEL'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: level.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              padding: EdgeInsets.only(left: 20, right: 20),
              children: snapshot.data!.docs
                  .map((e) => ItemData(
                        id: e['id_level'],
                        title: 'LEVEL',
                        subtitle: e['level'],
                        widget: [
                          SizedBox(
                            width: 5,
                          ),
                          IconButton(
                              onPressed: () {
                                level.doc('${e['id_level']}').delete();
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
          Navigator.pushNamed(context, '/superadmin-tambah-level');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
