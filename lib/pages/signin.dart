import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spk_app/pages/superadmin_home.dart';
import 'package:spk_app/utils/colors.dart';
import 'package:spk_app/utils/var_global.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController usernameC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  bool _visibility = false;

  @override
  void initState() {
    VarGlobal.USER_NOW == '';
    collectionOpen();
    collectionOnProgres();
    collectionClosed();
    super.initState();
  }

  var valueOpen;
  var valueOnProgres;
  var valueClosed;

  collectionOpen() async {
    var tiketOpen = FirebaseFirestore.instance
        .collection('tiket')
        .where('status', isEqualTo: 'OPEN');
    var snapshotOpen = await tiketOpen.count().get();
    valueOpen = snapshotOpen.count;
    print(valueOpen);
  }

  collectionOnProgres() async {
    var tiketOnprogres = FirebaseFirestore.instance
        .collection('tiket')
        .where('status', isEqualTo: 'ON PROGRESS');
    var snapshotOnprogres = await tiketOnprogres.count().get();
    valueOnProgres = snapshotOnprogres.count;
    print(valueOnProgres);
  }

  collectionClosed() async {
    var tiketClosed = FirebaseFirestore.instance
        .collection('tiket')
        .where('status', isEqualTo: 'CLOSED');
    var snapshotClosed = await tiketClosed.count().get();
    valueClosed = snapshotClosed.count;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width * 0.7,
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              border: Border.all(width: 2, color: Colors.grey.shade400)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'UTILITY HEPLDESK',
                style: TextStyle(fontSize: 20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person,
                    size: 30,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    color: Colors.grey.shade50,
                    padding: EdgeInsets.all(7),
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: TextField(
                      controller: usernameC,
                      textCapitalization: TextCapitalization.characters,
                      decoration: InputDecoration(
                          hintText: 'USERNAME', border: InputBorder.none),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.remove_red_eye_outlined,
                    size: 30,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    color: Colors.grey.shade50,
                    padding: EdgeInsets.all(7),
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: TextField(
                      controller: passwordC,
                      obscureText: _visibility,
                      textCapitalization: TextCapitalization.characters,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _visibility = !_visibility;
                                });
                              },
                              icon: Icon(_visibility
                                  ? Icons.visibility_off
                                  : Icons.visibility)),
                          hintText: 'PASSWORD',
                          border: InputBorder.none),
                    ),
                  )
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                    onPressed: () async {
                      if (usernameC.text == 'TONI' &&
                          passwordC.text == 'TONI123') {
                        VarGlobal.USER_NOW = usernameC.text;
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SuperAdmin(
                                  valueOpen: valueOpen,
                                  valueOnProgres: valueOnProgres,
                                  valueClosed: valueClosed),
                            ));
                      } else if (usernameC.text == 'GALIH' &&
                              passwordC.text == 'GALIH123' ||
                          usernameC.text == 'IRVAN' &&
                              passwordC.text == 'IRVAN123') {
                        VarGlobal.USER_NOW = usernameC.text;
                        Navigator.pushReplacementNamed(context, '/admin-home');
                      } else if (usernameC.text == 'IMAM' &&
                              passwordC.text == 'IMAM123' ||
                          usernameC.text == 'INTAN' &&
                              passwordC.text == 'INTAN123' ||
                          usernameC.text == 'HARTONO' &&
                              passwordC.text == 'HARTONO123' ||
                          usernameC.text == 'CANDRA' &&
                              passwordC.text == 'CANDRA123' ||
                          usernameC.text == 'FIKRI' &&
                              passwordC.text == 'FIKRI123' ||
                          usernameC.text == 'ASEP' &&
                              passwordC.text == 'ASEP123') {
                        VarGlobal.USER_NOW = usernameC.text;
                        print('DATA USER SAAT INI :' + VarGlobal.USER_NOW);
                        Navigator.pushReplacementNamed(context, '/user-home');
                      } else {
                        AwesomeDialog(
                          context: context,
                          animType: AnimType.scale,
                          dialogType: DialogType.error,
                          body: Center(
                            child: Text(
                              'MOHON CEK DATA YANG DI INPUTKAN',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                          btnOkOnPress: () {},
                        )..show();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ColorSelect.caccents),
                    child: Text('LOGIN')),
              )
            ],
          ),
        ),
      )),
    );
  }
}
