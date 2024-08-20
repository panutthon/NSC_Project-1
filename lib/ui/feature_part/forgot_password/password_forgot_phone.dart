//password_forgot_phone.dart start
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsc_whatidan_security/ui/auth_part/auth_repo.dart';
import 'package:nsc_whatidan_security/ui/auth_part/auth_service.dart';
import 'package:nsc_whatidan_security/ui/feature_part/forgot_password/otp_comfirm.dart';

class ForgotPasswordPhone extends StatelessWidget {
  ForgotPasswordPhone({super.key});

  final TextEditingController phoneController = TextEditingController();
  final AuthenticationRepository _authRepo = AuthenticationRepository.instance;

  void showModal(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        backgroundColor: Colors.white,
        context: context,
        isScrollControlled: true,
        builder: (context) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Icon(
                      Icons.mobile_friendly_outlined,
                      size: 100,
                      color: Colors.blue,
                    ),
                  ),
                  const Text(
                    'ลืมรหัสผ่าน',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'โปรดกรอกหมายเลขโทรศัพท์เพื่อรับรหัสยืนยัน',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: TextField(
                      controller: phoneController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        labelText: 'หมายเลขโทรศัพท์',
                        hintText: '0xx-xxx-xxxx',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      final phoneNumber =
                          formatPhoneNumber(phoneController.text.trim());

                      if (phoneNumber.isNotEmpty) {
                        try {
                          _authRepo.phoneAuthentication(phoneNumber);
                          Get.to(() => PhoneVerificationScreen(
                                phoneNumber: phoneNumber,
                                isResetPassword:
                                    true, // ระบุว่านี่คือกรณีรีเซ็ตรหัสผ่าน
                              ));
                        } catch (e) {
                          Get.snackbar('Error', 'เกิดข้อผิดพลาด: $e');
                        }
                      } else {
                        Get.snackbar('Error', 'กรุณากรอกหมายเลขโทรศัพท์');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 100, vertical: 20),
                    ),
                    child: const Text('ถัดไป'),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Text('Forgot Password'),
    ));
  }
}

//End password_forgot_phone.dart
