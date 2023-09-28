import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class DetailKaryawan extends StatelessWidget {
  final String nama;
  final int id;
  final String divisi;
  final String username;
  final String level;
  DetailKaryawan({
    required this.id,
    required this.nama,
    required this.divisi,
    required this.username,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DETAIL KARYAWAN'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              'ID\n${id}',
              style: TextStyle(fontSize: 20),
            ),
            Divider(),
            SizedBox(
              height: 15,
            ),
            Text('NAMA KARYAWAN\n${nama}', style: TextStyle(fontSize: 20)),
            Divider(),
            SizedBox(
              height: 15,
            ),
            Text('DIVISI\n${divisi}', style: TextStyle(fontSize: 20)),
            Divider(),
            SizedBox(
              height: 15,
            ),
            Text('USERNAME\n${username}', style: TextStyle(fontSize: 20)),
            Divider(),
            SizedBox(
              height: 15,
            ),
            Text('LEVEL\n${level}', style: TextStyle(fontSize: 20)),
            Divider(),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
