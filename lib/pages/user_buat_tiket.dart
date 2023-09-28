import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/colors.dart';
import '../utils/var_global.dart';

class UserBuatTiket extends StatefulWidget {
  const UserBuatTiket({super.key});

  @override
  State<UserBuatTiket> createState() => _UserBuatTiketState();
}

class _UserBuatTiketState extends State<UserBuatTiket> {
  @override
  void initState() {
    getDivisi();
    if (VarGlobal.USER_NOW == 'IZAAZ') {
      VarGlobal.DIVISI_NOW == 'QUALITY CONTROL';
    } else if (VarGlobal.USER_NOW == 'FELICIA') {
      VarGlobal.DIVISI_NOW == 'FINNANCE';
    }

    super.initState();
  }

  TextEditingController keluhanC = TextEditingController();
  final doc = FirebaseFirestore.instance.collection('tiket');

  var valueDivisi;
  void getDivisi() {
    FirebaseFirestore.instance
        .collection('karyawan')
        .where('nama', isEqualTo: VarGlobal.USER_NOW)
        .get()
        .then((value) => {
              value.docs.forEach((result) {
                setState(() {
                  valueDivisi = result.data()['divisi'];
                });
              })
            });
  }

  final storage = FirebaseStorage.instance;

  String imgURL = '';

  DateTime _dateTimeRequest = DateTime.now();

  File? imageFix;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('BUAT TIKET SPK'),
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 20, right: 20),
        children: [
          SizedBox(
            height: 20,
          ),
          InkWell(
              onTap: () async {
                // getImage();
                ImagePicker imagePicker = ImagePicker();
                XFile? file =
                    await imagePicker.pickImage(source: ImageSource.camera);

                Reference referenceRoot = FirebaseStorage.instance.ref();
                Reference referenceDirImages = referenceRoot.child('images');
                Reference referenceImageToUpload = referenceDirImages
                    .child(DateTime.now().microsecondsSinceEpoch.toString());
                try {
                  imageFix = File(file!.path);
                  // final compressedFile =
                  //     await FlutterImageCompress.compressAssetImage(
                  //         '${imageFix}',
                  //         quality: 80) as File;
                  await referenceImageToUpload.putFile(imageFix!);
                  setState(() {});
                  imgURL = await referenceImageToUpload.getDownloadURL();
                  print('LINK GAMBAR : $imgURL');
                } catch (e) {
                  print('ERROR IMAGE STORAGE : $e');
                }
              },
              child: imageFix != null
                  ? Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Image.file(
                        imageFix!,
                        fit: BoxFit.cover,
                      ),
                    )
                  : SizedBox(
                      height: MediaQuery.of(context).size.height * 0.25,
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Shimmer.fromColors(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Icon(
                              Icons.image,
                              size: 90,
                            ),
                            Text(
                              'Choose Image',
                              style: TextStyle(fontSize: 25),
                            )
                          ],
                        ),
                        baseColor: ColorSelect.caccents,
                        highlightColor: Colors.grey.shade100,
                      ),
                    )),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('KERUSAKAN'),
              Container(
                height: 50,
                padding: EdgeInsets.only(left: 10),
                width: MediaQuery.of(context).size.width * 0.6,
                child: TextField(
                  controller: keluhanC,
                  textCapitalization: TextCapitalization.characters,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: ColorSelect.cborder)),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('DIVISI'),
              Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 15),
                  width: MediaQuery.of(context).size.width * 0.6,
                  decoration: BoxDecoration(
                      border: Border.all(color: ColorSelect.cborder)),
                  child: Text(valueDivisi == null
                      ? 'Loading...'
                      : valueDivisi.toString()))
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('TANGGAL\nREQUEST'),
              Container(
                height: 50,
                padding: EdgeInsets.only(left: 10),
                width: MediaQuery.of(context).size.width * 0.6,
                decoration: BoxDecoration(
                    border: Border.all(color: ColorSelect.cborder)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        '${DateFormat('dd-MM-yyyy').format(_dateTimeRequest)}'),
                    // Text(_dateTimeRequest == null
                    //     ? 'PILIH TANGGAL'
                    //     : DateFormat('dd-MM-yyyy').format(_dateTimeRequest)),
                    IconButton(
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2099),
                          ).then((date) {
                            setState(() {
                              _dateTimeRequest = date!;
                            });
                          });
                        },
                        icon: Icon(
                          Icons.calendar_month,
                          color: Colors.green,
                        ))
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () async {
                createTiket();
                AwesomeDialog(
                  context: context,
                  animType: AnimType.scale,
                  dialogType: DialogType.success,
                  body: Center(
                    child: Text(
                      'DATA DISIMPAN',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
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

  Future createTiket() async {
    VarGlobal.id_tiket++;

    final tiket = Tiket(
        id_tiket: VarGlobal.id_tiket,
        id_karyawan: 0,
        foto: imgURL,
        status: 'OPEN',
        divisi: valueDivisi.toString(),
        user: VarGlobal.USER_NOW,
        tgl_buat: DateFormat('dd-MM-yyyy').format(_dateTimeRequest).toString(),
        tgl_selesai: '',
        keluhan: keluhanC.text,
        staf_it: '',
        solusi: '');

    final json = tiket.toJson();
    await doc.doc('${VarGlobal.id_tiket}').set(json);
  }
}

class Tiket {
  int id_tiket;
  int id_karyawan;
  final String foto;
  final String status;
  final String tgl_buat;
  final String divisi;
  final String user;
  final String tgl_selesai;
  final String keluhan;
  final String staf_it;
  final String solusi;

  Tiket({
    required this.id_tiket,
    required this.id_karyawan,
    required this.foto,
    required this.status,
    required this.tgl_buat,
    required this.divisi,
    required this.user,
    required this.tgl_selesai,
    required this.keluhan,
    required this.staf_it,
    required this.solusi,
  });

  Map<String, dynamic> toJson() => {
        'id_tiket': id_tiket,
        'id_karyawan': id_karyawan,
        'foto': foto,
        'status': status,
        'tgl_buat': tgl_buat,
        'divisi': divisi,
        'user': user,
        'tgl_selesai': tgl_selesai,
        'keluhan': keluhan,
        'staf_it': staf_it,
        'solusi': solusi,
      };
}
