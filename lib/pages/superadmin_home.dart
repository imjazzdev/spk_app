import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:spk_app/pages/superadmin_person.dart';
import 'package:spk_app/pages/superadmin_status_closed.dart';
import 'package:spk_app/pages/superadmin_status_onprogres.dart';
import 'package:spk_app/pages/superadmin_status_open.dart';
import 'package:spk_app/utils/colors.dart';

class SuperAdmin extends StatefulWidget {
  final int valueOpen;
  final int valueOnProgres;
  final int valueClosed;
  SuperAdmin(
      {required this.valueOpen,
      required this.valueOnProgres,
      required this.valueClosed});
  @override
  State<SuperAdmin> createState() => _SuperAdminState();
}

class _SuperAdminState extends State<SuperAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.only(left: 25, right: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: Container(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 7, bottom: 7),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: ColorSelect.caccents.withOpacity(0.2)),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 23,
                        backgroundColor: ColorSelect.caccents,
                        child: Icon(
                          Icons.person,
                          color: Colors.grey.shade100,
                          size: 40,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'HALLO,',
                              style: TextStyle(fontSize: 22),
                            ),
                            Text(
                              'SUPER ADMIN',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Data Status SPK',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              flex: 7,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(color: ColorSelect.cborder)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                                child: Text('SPK OPEN\n${widget.valueOpen}')),
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.remove_red_eye_rounded,
                                    size: 35,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              SuperAdminOpen(),
                                        ));
                                  },
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(Icons.access_time_rounded, size: 30)
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        LinearPercentIndicator(
                          percent: widget.valueOpen / 10,
                          animationDuration: 2000,
                          animation: true,
                          lineHeight: 20,
                          progressColor: Colors.green,
                          backgroundColor: Colors.green.shade100,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(color: ColorSelect.cborder)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                                child: Text(
                                    'SPK ON PROGRES\n${widget.valueOnProgres}')),
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.remove_red_eye_rounded,
                                    size: 35,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              SuperAdminOnProgres(),
                                        ));
                                  },
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(Icons.settings_backup_restore, size: 30)
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        LinearPercentIndicator(
                          percent: widget.valueOnProgres / 10,
                          lineHeight: 20,
                          progressColor: Colors.orange,
                          animationDuration: 2000,
                          animation: true,
                          backgroundColor: Colors.orange.shade100,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(color: ColorSelect.cborder)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('SPK CLOSED\n${widget.valueClosed}'),
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.remove_red_eye_rounded,
                                    size: 35,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              SuperAdminClosed(),
                                        ));
                                  },
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(Icons.check, size: 30)
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        LinearPercentIndicator(
                          percent: widget.valueClosed / 10,
                          lineHeight: 20,
                          animationDuration: 2000,
                          animation: true,
                          progressColor: Colors.red,
                          backgroundColor: Colors.red.shade100,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )),
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
                  color: Colors.grey.shade100,
                  size: 40,
                )),
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/person');
                },
                icon: Icon(Icons.settings, size: 40)),
          ],
        ),
      ),
    );
  }
}
