//username_registration.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nsc_whatidan_security/pages/home_page.dart';
import 'package:nsc_whatidan_security/ui/auth_part/auth_service.dart';
import 'package:nsc_whatidan_security/ui/feature_part/forgot_password/otp_comfirm.dart';
import 'register_input.dart';
import 'register_button.dart';
import 'password_requirements.dart';

class UsernameRegistration extends StatefulWidget {
  const UsernameRegistration({super.key});

  @override
  UsernameRegistrationState createState() => UsernameRegistrationState();
}

class UsernameRegistrationState extends State<UsernameRegistration> {
  final _formKey = GlobalKey<FormState>();

  String phone = '';
  String email = '';
  String password = '';
  String confirmpassword = '';

  bool hasUpperCase = false;
  bool hasLowerCase = false;
  bool hasNumber = false;
  bool hasSpecialChar = false;
  bool isLongEnough = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _acceptedTerms = false;
  String pin = '';

  @override
  void initState() {
    super.initState();
  }

  Future<bool> setPin() async {
    String? result = await screenLock(
      context: context,
      correctString: '',
      confirmationTitle: 'ยืนยันรหัส PIN',
    );
    if (result != null && result.isNotEmpty) {
      setState(() {
        pin = result;
      });
      return true;
    }
    return false;
  }

  Future<String?> screenLock({
    required BuildContext context,
    required String correctString,
    required String confirmationTitle,
  }) async {
    // Your screen lock implementation here
    return null;
  }

  void _updatePasswordChecks(String value) {
    setState(() {
      password = value;
      hasUpperCase = password.contains(RegExp(r'[A-Z]'));
      hasLowerCase = password.contains(RegExp(r'[a-z]'));
      hasNumber = password.contains(RegExp(r'[0-9]'));
      hasSpecialChar = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
      isLongEnough = password.length >= 8;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Image.asset(
                      'assets/logo_app_whatidan.png',
                      height: 150,
                      width: 300,
                    ),
                    const Center(
                      child: Text(
                        "ลงทะเบียน",
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Center(
                      child: Text(
                        "สร้างบัญชีของคุณ",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 29.0),
                    emailInput(
                      email: email,
                      onSaved: (value) => email = value,
                    ),
                    const SizedBox(height: 29.0),
                    phoneInput(
                      phoneNumber: phone,
                      onSaved: (value) => phone = value,
                    ),
                    const SizedBox(height: 29.0),
                    passwordInput(
                      password: password,
                      obscurePassword: _obscurePassword,
                      onVisibilityChanged: (value) {
                        setState(() {
                          _obscurePassword = value;
                        });
                      },
                      onChanged: _updatePasswordChecks,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณากรอกรหัสผ่าน';
                        }
                        if (!(hasUpperCase &&
                            hasLowerCase &&
                            hasNumber &&
                            hasSpecialChar &&
                            isLongEnough)) {
                          return 'รหัสผ่านไม่ผ่านเกณฑ์';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    Visibility(
                      visible: password.isNotEmpty &&
                          !(hasUpperCase &&
                              hasLowerCase &&
                              hasNumber &&
                              hasSpecialChar &&
                              isLongEnough),
                      child: validateCheck(
                        hasUpperCase: hasUpperCase,
                        hasLowerCase: hasLowerCase,
                        hasNumber: hasNumber,
                        hasSpecialChar: hasSpecialChar,
                        isLongEnough: isLongEnough,
                      ),
                    ),
                    const SizedBox(height: 13.0),
                    confirmPasswordInput(
                      password: password,
                      confirmPassword: confirmpassword,
                      obscurePassword: _obscureConfirmPassword,
                      onVisibilityChanged: (value) {
                        setState(() {
                          _obscureConfirmPassword = value;
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          confirmpassword = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณายืนยันรหัสผ่าน';
                        } else if (value != password) {
                          return 'รหัสผ่านไม่ตรงกัน';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10.0),
                    termButton(
                      context: context,
                      acceptedTerms: _acceptedTerms,
                      onChanged: (value) {
                        setState(() {
                          _acceptedTerms = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16.0),
                    registerButton(
                      context: context,
                      onPressed: () async {
                        if (_formKey.currentState!.validate() &&
                            _acceptedTerms) {
                          final email = controller.email.text.trim();
                          final phoneNumber =
                              controller.phoneNumber.text.trim();

                          // เช็คว่ามีอีเมลหรือเบอร์โทรศัพท์ใน Firestore หรือไม่
                          try {
                            final emailSnapshot = await FirebaseFirestore
                                .instance
                                .collection('users')
                                .where('email', isEqualTo: email)
                                .get();
                            if (emailSnapshot.docs.isNotEmpty) {
                              Get.snackbar('Error',
                                  'มีบัญชีนี้อยู่ในระบบแล้ว กรุณาเข้าสู่ระบบแทน');
                              return;
                            }

                            final phoneSnapshot = await FirebaseFirestore
                                .instance
                                .collection('users')
                                .where('phone', isEqualTo: phoneNumber)
                                .get();
                            if (phoneSnapshot.docs.isNotEmpty) {
                              Get.snackbar('Error',
                                  'เบอร์โทรศัพท์นี้ถูกใช้สมัครบัญชีแล้ว กรุณาเข้าสู่ระบบแทน');
                              return;
                            }
                          } catch (e) {
                            Get.snackbar(
                                'Error', 'เกิดข้อผิดพลาดในการตรวจสอบบัญชี: $e');
                            return;
                          }

                          // ส่ง OTP ไปยังเบอร์โทรศัพท์
                          await SignUpController.instance
                              .phoneAuthenticationcontrol(phoneNumber);

                          // นำผู้ใช้ไปยังหน้ายืนยัน OTP
                          final result = await Get.to<bool>(() =>
                              PhoneVerificationScreen(
                                  phoneNumber: phoneNumber));

                          // ตรวจสอบว่า OTP ถูกยืนยันสำเร็จหรือไม่
                          if (result == true) {
                            // ถ้า OTP ถูกยืนยันสำเร็จ ให้ลงทะเบียนผู้ใช้และบันทึกข้อมูลใน Firestore
                            await SignUpController.instance.registerUser(
                              email,
                              controller.password.text.trim(),
                            );

                            // บันทึกข้อมูลผู้ใช้ใน Firestore
                            await FirebaseFirestore.instance
                                .collection('users')
                                .add({
                              'email': email,
                              'phone': phoneNumber,
                            });

                            // นำผู้ใช้ไปยังหน้าถัดไป (อาจเป็นหน้า Home หรือหน้าอื่นๆ)
                            Get.offAll(const MyHomePage());
                          } else {
                            // ถ้า OTP ไม่ถูกยืนยัน แสดงข้อความแจ้งเตือน
                            Get.snackbar('Error',
                                'การยืนยัน OTP ล้มเหลว กรุณาลองใหม่อีกครั้ง');
                          }
                        } else if (!_acceptedTerms) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('กรุณายอมรับข้อตกลงและเงื่อนไข'),
                            ),
                          );
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("มีบัญชีแล้วเหรอ?"),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("เข้าสู่ระบบ"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//End username_registration.dart