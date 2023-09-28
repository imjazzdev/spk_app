import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../utils/colors.dart';

class UserPerson extends StatelessWidget {
  const UserPerson({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
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
                            'USER',
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
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/user-buat-tiket');
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border(
                  bottom: BorderSide(
                    width: 1.5,
                  ),
                )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'BUAT TIKET SPK',
                    ),
                    Icon(Icons.arrow_forward_rounded)
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/user-history');
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border(
                  bottom: BorderSide(
                    width: 1.5,
                  ),
                )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('HISTORY TIKET'),
                    Icon(Icons.arrow_forward_rounded)
                  ],
                ),
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
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/user-home');
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
