import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:spk_app/utils/colors.dart';

class PersonPage extends StatelessWidget {
  const PersonPage({super.key});

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
            Container(
              padding: EdgeInsets.only(left: 20, right: 20, top: 7, bottom: 7),
              width: double.maxFinite,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: ColorSelect.caccents.withOpacity(0.2)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
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
                      Column(
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
                    ],
                  ),
                  IconButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/signin', (route) => false);
                      },
                      icon: Icon(
                        Icons.logout,
                        size: 35,
                        color: Colors.red,
                      ))
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            DataMenu(route: '/superadmin-data-divisi', title: 'DATA DIVISI'),
            DataMenu(
                route: '/superadmin-data-karyawan', title: 'DATA KARYAWAN'),
            DataMenu(route: '/superadmin-form-laporan-spk', title: 'LAPORAN'),
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
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.home_filled,
                  size: 40,
                )),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.settings,
                  size: 40,
                  color: Colors.grey.shade200,
                )),
          ],
        ),
      ),
    );
  }
}

class DataMenu extends StatelessWidget {
  final String route;
  final String title;
  DataMenu({required this.route, required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        margin: EdgeInsets.all(7),
        padding: EdgeInsets.all(10),
        height: 60,
        decoration:
            BoxDecoration(border: Border.all(color: ColorSelect.cborder)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18),
            ),
            Icon(Icons.arrow_forward_ios_rounded)
          ],
        ),
      ),
    );
  }
}
