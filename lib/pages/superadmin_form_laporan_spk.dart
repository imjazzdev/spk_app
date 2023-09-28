import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:spk_app/pages/superadmin_laporan_detail.dart';
import 'package:spk_app/utils/colors.dart';

class FormLaporanSPK extends StatefulWidget {
  const FormLaporanSPK({super.key});

  @override
  State<FormLaporanSPK> createState() => _FormLaporanSPKState();
}

class _FormLaporanSPKState extends State<FormLaporanSPK> {
  DateTime? _dateTimeMulai;
  DateTime? _dateTimeSampai;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FORM LAPORAN SPK'),
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
              'DARI TANGGAL',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 70,
                  padding: EdgeInsets.only(left: 15),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      border: Border.all(color: ColorSelect.cborder)),
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Text(_dateTimeMulai == null
                      ? 'PILIH TANGGAL MULAI'
                      : DateFormat('dd-MM-yyyy').format(_dateTimeMulai!)),
                ),
                IconButton(
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2099),
                      ).then((date) {
                        setState(() {
                          _dateTimeMulai = date!;
                        });
                      });
                    },
                    icon: Icon(
                      Icons.calendar_month_outlined,
                      color: Colors.green,
                      size: 33,
                    ))
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'SAMPAI TANGGAL',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 70,
                  padding: EdgeInsets.only(left: 15),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      border: Border.all(color: ColorSelect.cborder)),
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Text(_dateTimeSampai == null
                      ? 'PILIH TANGGAL AKHIR'
                      : DateFormat('dd-MM-yyyy').format(_dateTimeSampai!)),
                ),
                IconButton(
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2099),
                      ).then((date) {
                        setState(() {
                          _dateTimeSampai = date;
                        });
                      });
                    },
                    icon: Icon(
                      Icons.calendar_month_outlined,
                      color: Colors.green,
                      size: 33,
                    ))
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LaporanDetail(),
                          ));
                    },
                    child: Text('SUBMIT')))
          ],
        ),
      ),
    );
  }
}
