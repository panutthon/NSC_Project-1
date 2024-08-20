import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:nsc_whatidan_security/ui/auth_part/auth_repo.dart';
import 'package:nsc_whatidan_security/ui/auth_part/auth_service.dart';
import 'package:nsc_whatidan_security/ui/feature_part/forgot_password/reset_pass_screen.dart';
import 'package:nsc_whatidan_security/ui/login_part/pin_login.dart';

class PhoneVerificationScreen extends StatefulWidget {
  final String phoneNumber;
  final bool isResetPassword; // เพิ่มพารามิเตอร์นี้

  const PhoneVerificationScreen(
      {super.key,
      required this.phoneNumber,
      this.isResetPassword =
          false // ค่าเริ่มต้นเป็น false สำหรับการสมัครใช้งานครั้งแรก
      });

  @override
  _PhoneVerificationScreenState createState() =>
      _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  String otp = '';

  String formatPhoneNumberDisplay(String phoneNumber) {
    phoneNumber = formatPhoneNumber(phoneNumber);
    if (phoneNumber.length > 6) {
      return '0xx-xxx-${phoneNumber.substring(8)}';
    } else {
      return phoneNumber;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: Container(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'OTP',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.smartphone_outlined,
                      size: 100,
                      color: Colors.blue,
                    ),
                    Icon(
                      Icons.mail_outline,
                      size: 50,
                      color: Colors.blue,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'การยืนยันตัวตน',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                Text(
                  'โปรดกรอกรหัสยืนยันที่ส่งไปที่หมายเลข\n${formatPhoneNumberDisplay(widget.phoneNumber)}',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                OtpTextField(
                  numberOfFields: 6,
                  cursorColor: Colors.blue,
                  focusedBorderColor: Colors.blue,
                  fillColor: Colors.black.withOpacity(0.1),
                  textStyle: const TextStyle(fontSize: 20),
                  onSubmit: (pin) {
                    setState(() {
                      otp = pin;
                    });
                  },
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      bool isVerified = await AuthenticationRepository.instance
                          .verifyOTP(otp);
                      if (isVerified) {
                        Get.snackbar('Success', 'ยืนยัน OTP สำเร็จ');

                        if (widget.isResetPassword) {
                          // กรณีรีเซ็ตรหัสผ่าน
                          Get.off(() => ResetPasswordScreen(
                              phoneNumber: widget.phoneNumber));
                        } else {
                          // กรณีสมัครใช้งานครั้งแรก
                          Get.off(() => const Pinauthen());
                        }
                      } else {}
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      'ถัดไป',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MailVerificationScreen extends StatelessWidget {
  const MailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var otp = '';
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: Container(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'OTP',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.smartphone_outlined,
                      size: 100,
                      color: Colors.blue,
                    ),
                    Icon(
                      Icons.mail_outline,
                      size: 50,
                      color: Colors.blue,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'การยืนยันตัวตน',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                const Text(
                  'โปรดกรอกรหัสยืนยันที่ส่งไปที่หมายเลข\nWhatIDan@gmail.com',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                OtpTextField(
                  numberOfFields: 6,
                  cursorColor: Colors.blue,
                  focusedBorderColor: Colors.blue,
                  fillColor: Colors.black.withOpacity(0.1),
                  filled: true,
                  textStyle: const TextStyle(fontSize: 20),
                  onSubmit: (pin) {
                    otp = pin;
                  },
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      bool isVerified = await AuthenticationRepository.instance
                          .verifyOTP(otp);
                      Get.back(result: true);
                      if (isVerified) {
                        Get.snackbar('Success', 'เข้าสู่ระบบสำเร็จ');
                        Get.to(() => const Pinauthen());
                      } else {
                        Get.snackbar('Error', 'การยืนยัน OTP ล้มเหลว');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      'ถัดไป',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

  //End otp_comfirm.dart