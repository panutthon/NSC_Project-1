//auth_service.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsc_whatidan_security/ui/auth_part/auth_repo.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  //TextField Controllers to get data from TextFields
  final email = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  //Call this Function from Design && it will do the rest

  Future<void> registerUser(
    String email,
    String password,
  ) async {
    AuthenticationRepository.instance.createUserWithEmailAndPassword(
      email,
      password,
    );
  }

  Future<void> phoneAuthenticationcontrol(String phoneNo) async {
    AuthenticationRepository.instance
        .phoneAuthentication(formatPhoneNumber(phoneNo));
  }
}

String formatPhoneNumber(String phoneNumber) {
  // ตรวจสอบว่ามีเลข 0 อยู่หรือไม่
  if (!phoneNumber.startsWith('0')) {
    //
    return phoneNumber;
  }
  // แทนที่ 0 ด้วย +66
  return phoneNumber.toString().replaceFirst('0', '+66');
}

//End auth_service.dart