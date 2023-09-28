import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spk_app/pages/admin_detail%20_tiket.dart';
import 'package:spk_app/pages/admin_home.dart';
import 'package:spk_app/pages/admin_person.dart';
import 'package:spk_app/pages/admin_update_detail.dart';
import 'package:spk_app/pages/admin_update_spk.dart';
import 'package:spk_app/pages/superadmin_data_divisi.dart';
import 'package:spk_app/pages/superadmin_data_karyawan.dart';
import 'package:spk_app/pages/superadmin_data_level.dart';
import 'package:spk_app/pages/superadmin_data_status.dart';
import 'package:spk_app/pages/superadmin_detail_karyawan.dart';
import 'package:spk_app/pages/superadmin_form_laporan_spk.dart';
import 'package:spk_app/pages/superadmin_home.dart';
import 'package:spk_app/pages/superadmin_person.dart';
import 'package:spk_app/pages/signin.dart';
import 'package:spk_app/pages/superadmin_tambah_divisi.dart';
import 'package:spk_app/pages/superadmin_tambah_karyawan.dart';
import 'package:spk_app/pages/superadmin_tambah_level.dart';
import 'package:spk_app/pages/superadmin_tambah_status.dart';
import 'package:spk_app/pages/user_buat_tiket.dart';
import 'package:spk_app/pages/user_history_tiket.dart';
import 'package:spk_app/pages/user_home.dart';
import 'package:spk_app/pages/user_person.dart';
import 'package:spk_app/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // status bar color
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignInPage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: ColorSelect.caccents,
          primarySwatch: Colors.green,
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
                borderSide: BorderSide(color: ColorSelect.cborder)),
          ),
          appBarTheme: AppBarTheme(color: ColorSelect.caccents),
          textTheme: GoogleFonts.poppinsTextTheme()),
      routes: {
        '/signin': (context) => SignInPage(),
        //SUPER ADMIN
        '/person': (context) => const PersonPage(),
        '/superadmin-data-status': (context) => DataStatus(),
        '/superadmin-data-level': (context) => DataLevel(),
        '/superadmin-data-divisi': (context) => DataDivisi(),
        '/superadmin-data-karyawan': (context) => DataKaryawan(),
        '/superadmin-tambah-status': (context) => const TambahStatus(),
        '/superadmin-tambah-level': (context) => const TambahLevel(),
        '/superadmin-tambah-divisi': (context) => const TambahDivisi(),
        '/superadmin-tambah-karyawan': (context) => const TambahKaryawan(),
        '/superadmin-form-laporan-spk': (context) => const FormLaporanSPK(),
        //ADMIN
        '/admin-home': (context) => AdminHome(),
        '/admin-person': (context) => const AdminPerson(),
        '/admin-update-spk': (context) => AdminUpdateSPK(),
        //USER
        '/user-home': (context) => UserHome(),
        '/user-person': (context) => const UserPerson(),
        '/user-buat-tiket': (context) => const UserBuatTiket(),
        '/user-history': (context) => UserHistoryTiket(),
      },
    );
  }
}
