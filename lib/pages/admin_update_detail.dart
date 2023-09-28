import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:spk_app/utils/colors.dart';
import 'package:spk_app/utils/var_global.dart';

class AdminUpdateDetail extends StatefulWidget {
  final int id;
  AdminUpdateDetail({required this.id});
  @override
  State<AdminUpdateDetail> createState() => _AdminUpdateDetailState();
}

class _AdminUpdateDetailState extends State<AdminUpdateDetail> {
  TextEditingController solusiC = TextEditingController();
  DateTime? _dateTimeClose;

  Future updateTiket() async {
    final docTiket =
        FirebaseFirestore.instance.collection('tiket').doc('${widget.id}');
    docTiket.update({
      'solusi': solusiC.text,
      'status': 'CLOSED',
      'staf_it': VarGlobal.USER_NOW,
      'tgl_selesai':
          DateFormat('dd-MM-yyyy').format(_dateTimeClose!).toString(),
    });
  }

  @override
  Widget build(BuildContext context) {
    resizeToAvoidBottomPadding:
    false;
    resizeToAvoidBottomInset:
    false;
    return Scaffold(
      appBar: AppBar(
        title: Text('UPDATE SPK'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 20, right: 20),
        children: [
          SizedBox(
            height: 40,
          ),
          Text('PENANGANAN'),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            height: 80,
            decoration:
                BoxDecoration(border: Border.all(color: ColorSelect.cborder)),
            child: TextField(
              controller: solusiC,
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text('TANGGAL CLOSE SPK'),
          Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              height: 50,
              decoration:
                  BoxDecoration(border: Border.all(color: ColorSelect.cborder)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_dateTimeClose == null
                      ? 'PILIH TANGGAL CLOSE'
                      : DateFormat('dd-MM-yyyy').format(_dateTimeClose!)),
                  IconButton(
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2099),
                        ).then((date) {
                          setState(() {
                            _dateTimeClose = date!;
                          });
                        });
                      },
                      icon: Icon(
                        Icons.calendar_month,
                        color: Colors.green,
                        size: 30,
                      )),
                ],
              )),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                updateTiket();
                AwesomeDialog(
                  context: context,
                  animType: AnimType.scale,
                  dialogType: DialogType.success,
                  title: 'DATA DISIMPAN',
                  btnOkOnPress: () {
                    Navigator.pop(context);
                  },
                ).show();
              },
              child: Text('SUBMIT'))
        ],
      ),
    );
  }
}
