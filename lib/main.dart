// 📄 main.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nsc_whatidan_security/firebase_options.dart';
import 'package:nsc_whatidan_security/ui/auth_part/auth_repo.dart';
import 'package:nsc_whatidan_security/ui/login_part/login/username_login.dart';
import 'package:nsc_whatidan_security/ui/login_part/pin_login.dart';
import 'pages/about_page.dart';
import 'pages/adddata_page.dart';
import 'pages/analyzedata_page.dart';
import 'pages/chang_page.dart';
import 'pages/edit_page.dart';
import 'pages/history_page.dart';
import 'pages/home_page.dart';
import 'pages/profile_page.dart';
import 'pages/setting_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Secure Registration',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.notoSansThaiTextTheme(),
      ),
      home: const AuthenticationChecker(),
      getPages: [
        GetPage(name: '/', page: () => const MyHomePage()),
        GetPage(name: '/about', page: () => const AboutPage()),
        GetPage(name: '/profile', page: () => const MyProfilePage()),
        GetPage(name: '/setting', page: () => const SettingPage()),
        GetPage(name: '/adddata', page: () => const AdddataPage()),
        GetPage(name: '/history', page: () => const HistoryPage()),
        GetPage(name: '/analyzedata', page: () => const AnalyzedataPage()),
        GetPage(name: '/editprofile', page: () => const EditPage()),
        GetPage(name: '/chang', page: () => const ChangPage()),
      ],
    );
  }
}

class AuthenticationChecker extends StatelessWidget {
  const AuthenticationChecker({super.key});

  @override
  Widget build(BuildContext context) {
    final authRepo = Get.find<AuthenticationRepository>();

    return FutureBuilder<bool>(
      future: authRepo.isAuthenticated(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.data == true) {
            return const Pinauthen();
          } else {
            return const Login();
          }
        }
      },
    );
  }
}

//End main.dart