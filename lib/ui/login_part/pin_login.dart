// pin_login.dart

import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:nsc_whatidan_security/pages/home_page.dart';
import 'package:nsc_whatidan_security/ui/auth_part/auth_repo.dart';

class Pinauthen extends StatefulWidget {
  const Pinauthen({super.key});
  static AuthenticationRepository get instance => Get.find();

  @override
  _PinauthenState createState() => _PinauthenState();
}

class _PinauthenState extends State<Pinauthen> {
  final LocalAuthentication _localAuth = LocalAuthentication();

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    // ตรวจสอบว่ามีการตรวจสอบตัวตนผ่าน Local Authentication สำเร็จหรือไม่
    final isAuthenticated = await _localAuth.authenticate(
      localizedReason: 'กรุณายืนยันตัวตน',
      // ใช้ตัวเลือกที่อนุญาตให้ใช้งานได้แค่ช่วงการตรวจสอบชีวภาพเท่านั้น
      options: const AuthenticationOptions(biometricOnly: true),
    );

    if (isAuthenticated) {
      // หากตรวจสอบตัวตนสำเร็จ นำไปยังหน้า Home
      Get.offAll(const MyHomePage());
    } else {
      // หากไม่สำเร็จ แสดงหน้าตรวจสอบ PIN
      _showScreenLock(context);
    }
  }

  void _showScreenLock(BuildContext context) {
    screenLock(
      context: context,
      correctString: '1234',
      customizedButtonChild: const Icon(Icons.fingerprint),
      customizedButtonTap: () async => await localAuth(context),
      canCancel: false,
      onUnlocked: () {
        Get.off(const MyHomePage());
      },
    );
  }

  Future<void> localAuth(BuildContext context) async {
    final localAuth = LocalAuthentication();

    final didAuthenticate = await localAuth.authenticate(
      localizedReason: 'กรุณายืนยันตัวตน',
      options: const AuthenticationOptions(biometricOnly: true),
    );

    if (didAuthenticate && context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          maintainState: false,
          builder: (context) => const MyHomePage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/logo_app_whatidan.png',
                    width: 500,
                    height: 500,
                  ),
                  const SizedBox(height: 16),
                  const CircularProgressIndicator(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// End pin_login.dart
