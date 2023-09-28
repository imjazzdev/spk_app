import 'package:flutter/material.dart';

import 'package:spk_app/utils/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';

class UserDetailHistory extends StatelessWidget {
  final int id_tiket;
  final String imgURL;
  final String status;
  final String user;
  final String divisi;
  final String kerusakan;
  final String tgl_buat;
  final String staf_it;
  final String tgl_selesai;
  final String solusi;

  UserDetailHistory({
    required this.id_tiket,
    required this.imgURL,
    required this.status,
    required this.user,
    required this.divisi,
    required this.kerusakan,
    required this.tgl_buat,
    required this.staf_it,
    required this.tgl_selesai,
    required this.solusi,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HISTORY TIKET'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: ListView(
        padding: EdgeInsets.only(left: 20, right: 20),
        children: [
          SizedBox(
            height: 30,
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration:
                BoxDecoration(border: Border.all(color: ColorSelect.cborder)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                      height: MediaQuery.of(context).size.height * 0.25,
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Image.network(
                        imgURL,
                      )),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('ID SPK'), Text('${id_tiket}')],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('STATUS'), Text('${status}')],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('USER'), Text('${user}')],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('DIVISI'), Text('${divisi}')],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('KERUSAKAN'),
                    Container(
                      height: 70,
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: ColorSelect.cborder, width: 1.5)),
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        '${kerusakan}',
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('TANGGAL REQUEST SPK'),
                    Text(tgl_buat == null ? 'Loading...' : '${tgl_buat}'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('TEKNISI'), Text('${staf_it}')],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('TANGGAL CLOSE SPK'),
                    Text(tgl_selesai == null ? 'Loading...' : '${tgl_selesai}'),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('PENANGANAN'),
                    Container(
                      height: 70,
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: ColorSelect.cborder, width: 1.5)),
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        '${solusi}',
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
