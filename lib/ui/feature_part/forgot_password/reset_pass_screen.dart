import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsc_whatidan_security/ui/auth_part/auth_repo.dart';
import 'package:nsc_whatidan_security/ui/login_part/login/username_login.dart';
import 'package:nsc_whatidan_security/ui/login_part/register/password_requirements.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String phoneNumber;

  const ResetPasswordScreen({super.key, required this.phoneNumber});

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  bool _hasUpperCase = false;
  bool _hasLowerCase = false;
  bool _hasNumber = false;
  bool _hasSpecialChar = false;
  bool _isLongEnough = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Icon(Icons.lock, size: 80, color: Colors.white),
              const SizedBox(height: 20),
              const Text(
                'สร้างรหัสผ่านใหม่',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _newPasswordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        hintText: 'กรุณากรอกรหัสผ่านใหม่',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        suffixIcon: IconButton(
                          icon: Icon(_obscurePassword
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _hasUpperCase = value.contains(RegExp(r'[A-Z]'));
                          _hasLowerCase = value.contains(RegExp(r'[a-z]'));
                          _hasNumber = value.contains(RegExp(r'[0-9]'));
                          _hasSpecialChar =
                              value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
                          _isLongEnough = value.length >= 8;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: _obscureConfirmPassword,
                      decoration: InputDecoration(
                        hintText: 'กรุณายืนยันรหัสผ่านใหม่',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        suffixIcon: IconButton(
                          icon: Icon(_obscureConfirmPassword
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _obscureConfirmPassword =
                                  !_obscureConfirmPassword;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    validateCheck(
                      hasUpperCase: _hasUpperCase,
                      hasLowerCase: _hasLowerCase,
                      hasNumber: _hasNumber,
                      hasSpecialChar: _hasSpecialChar,
                      isLongEnough: _isLongEnough,
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () async {
                        if (_newPasswordController.text ==
                                _confirmPasswordController.text &&
                            _hasUpperCase &&
                            _hasLowerCase &&
                            _hasNumber &&
                            _hasSpecialChar &&
                            _isLongEnough) {
                          try {
                            await AuthenticationRepository.instance
                                .resetPassword(
                              phoneNumber: widget.phoneNumber,
                              newPassword: _newPasswordController.text,
                            );
                            Get.snackbar('Success', 'รีเซ็ตรหัสผ่านสำเร็จ');
                            Get.offAll(() => const Login());
                          } catch (e) {
                            Get.snackbar('Error',
                                'เกิดข้อผิดพลาดในการรีเซ็ตรหัสผ่าน: $e');
                          }
                        } else if (_newPasswordController.text !=
                            _confirmPasswordController.text) {
                          Get.snackbar('Error', 'รหัสผ่านไม่ตรงกัน');
                        } else {
                          Get.snackbar(
                              'Error', 'กรุณากรอกรหัสผ่านที่ตรงตามข้อกำหนด');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text('ยืนยัน'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
