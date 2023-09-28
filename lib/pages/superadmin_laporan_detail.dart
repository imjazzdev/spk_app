import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:spk_app/utils/colors.dart';

class LaporanDetail extends StatelessWidget {
  //final String startDate;
  // final String endDate;
//   final DateTime dateTimeStart;
// DateTime dateTimeEnd;
//   LaporanDetail({required this.dateTimeStart, required this.dateTimeEnd});

  final tiket = FirebaseFirestore.instance
      .collection('tiket')
      .where('status', isEqualTo: 'CLOSED');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('LAPORAN\nDETAIL'),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: tiket.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                padding: EdgeInsets.only(left: 20, right: 20),
                children: snapshot.data!.docs
                    .map((e) => ItemLaporan(
                        id: e['id_tiket'],
                        nama: e['user'],
                        divisi: e['divisi'],
                        keluhan: e['keluhan'],
                        tgl_buat: e['tgl_buat'],
                        tgl_selesai: e['tgl_selesai'],
                        staf_it: e['staf_it']))
                    .toList(),
              );
            } else if (snapshot.hasData != true) {
              return Center(child: Text('BELUM ADA DATA'));
            } else {
              return Center(child: Text('Loading'));
            }
          }),
    );
  }
}

class ItemLaporan extends StatelessWidget {
  final int id;
  final String nama;
  final String divisi;
  final String keluhan;
  final String tgl_buat;
  final String tgl_selesai;
  final String staf_it;
  ItemLaporan({
    required this.id,
    required this.nama,
    required this.divisi,
    required this.keluhan,
    required this.tgl_buat,
    required this.tgl_selesai,
    required this.staf_it,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 25),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: ColorSelect.caccents, width: 2),
        color: ColorSelect.cborder.withOpacity(0.2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ID'),
                Text('NAMA'),
                Text('DIVISI'),
                Text('KELUHAN'),
                Text('TANGGAL BUAT'),
                Text('TANGGAL SELESAI'),
                Text('STAF IT'),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$id'),
                Text('$nama'),
                Text('$divisi'),
                Text(
                  '$keluhan',
                  maxLines: 3,
                ),
                Text('$tgl_buat'),
                Text('$tgl_selesai'),
                Text('$staf_it'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
