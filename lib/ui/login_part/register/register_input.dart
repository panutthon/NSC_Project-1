//register_input.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nsc_whatidan_security/ui/auth_part/auth_service.dart';

final controller = Get.put(SignUpController());

TextFormField phoneInput({
  required String phoneNumber,
  required Function(String) onSaved,
}) {
  return TextFormField(
    controller: controller.phoneNumber,
    decoration: InputDecoration(
      labelText: "เบอร์โทรศัพท์",
      prefixIcon: const Icon(Icons.phone),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    keyboardType: TextInputType.phone,
    inputFormatters: [
      FilteringTextInputFormatter.digitsOnly,
      LengthLimitingTextInputFormatter(10), // เบอร์โทรศัพท์ไทยมี 10 หลัก
    ],
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'กรุณากรอกเบอร์โทรศัพท์';
      }
      if (value.length < 10) {
        return 'เบอร์โทรศัพท์ต้องมี 10 ตัว';
      }
      // เพิ่มการตรวจสอบรูปแบบเบอร์โทรศัพท์ (เช่น ต้องเป็นตัวเลขเท่านั้น)
      if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
        return 'เบอร์โทรศัพท์ต้องเป็นตัวเลข';
      }
      return null;
    },
    onSaved: (value) => onSaved(value!),
  );
}

TextFormField emailInput({
  required String email,
  required Function(String) onSaved,
}) {
  return TextFormField(
    controller: controller.email,
    decoration: InputDecoration(
      labelText: "อีเมล",
      prefixIcon: const Icon(Icons.email_outlined),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    keyboardType: TextInputType.emailAddress,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'กรุณากรอกอีเมล';
      }
      final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegExp.hasMatch(value)) {
        return 'กรุณากรอกอีเมลที่ถูกต้อง';
      }
      return null;
    },
    onSaved: (value) => onSaved(value!),
  );
}

TextFormField passwordInput({
  required String password,
  required bool obscurePassword,
  required Function(bool) onVisibilityChanged,
  required Function(String) onChanged,
  required String? Function(String?)? validator,
}) {
  return TextFormField(
    controller: controller.password,
    obscureText: obscurePassword,
    decoration: InputDecoration(
      labelText: "รหัสผ่าน",
      prefixIcon: const Icon(Icons.password_outlined),
      suffixIcon: IconButton(
        onPressed: () {
          onVisibilityChanged(!obscurePassword);
        },
        icon: obscurePassword
            ? const Icon(Icons.visibility_outlined)
            : const Icon(Icons.visibility_off_outlined),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    validator: validator,
    onChanged: onChanged,
  );
}

TextFormField confirmPasswordInput({
  required String password,
  required String confirmPassword,
  required bool obscurePassword,
  required Function(bool) onVisibilityChanged,
  required Function(String) onChanged,
  required String? Function(String?)? validator,
}) {
  return TextFormField(
    controller: controller.confirmPassword,
    obscureText: obscurePassword,
    decoration: InputDecoration(
      labelText: "ยืนยันรหัสผ่าน",
      prefixIcon: const Icon(Icons.password_outlined),
      suffixIcon: IconButton(
        onPressed: () {
          onVisibilityChanged(!obscurePassword);
        },
        icon: obscurePassword
            ? const Icon(Icons.visibility_outlined)
            : const Icon(Icons.visibility_off_outlined),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    validator: validator,
    onChanged: onChanged,
  );
}

//End register_input.dart