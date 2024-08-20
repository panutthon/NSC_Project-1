//login_button.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsc_whatidan_security/pages/home_page.dart';
import 'package:nsc_whatidan_security/ui/feature_part/forgot_password/password_option_screen.dart';
import 'package:nsc_whatidan_security/ui/login_part/pin_login.dart';
import 'package:nsc_whatidan_security/ui/login_part/register/username_registration.dart';
import 'package:nsc_whatidan_security/ui/auth_part/auth_repo.dart';

class ForgotPassButton extends StatelessWidget {
  const ForgotPassButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      //ปุ่มลืมรหัสผ่าน
      children: [
        TextButton(
          onPressed: () {
            ForgotPasswordScreen.passwordOptionScreen(context);
          },
          child: const Text(
            "ลืมรหัสผ่าน",
            style: TextStyle(
              fontSize: 16,
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
          ),
        )
      ],
    );
  }
}

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      //ปุ่มสร้างบัญชีใหม่
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("ยังไม่มีบัญชีใช่ไหมครับ?"),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                maintainState: false,
                builder: (context) {
                  return const UsernameRegistration();
                },
              ),
            );
          },
          child: const Text(
            "สร้างบัญชี",
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }
}

class LoginButton extends StatelessWidget {
  final TextEditingController emailController;

  final TextEditingController passwordController;

  const LoginButton({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      //ปุ่มเข้าสู่ระบบ
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),

      onPressed: () async {
        final email = emailController.text.trim();

        final password = passwordController.text.trim();

        if (email.isNotEmpty && password.isNotEmpty) {
          final isSuccess = await AuthenticationRepository.instance
              .loginWithEmailAndPassword(email, password);
          // Successful login
          if (isSuccess) {
            Get.snackbar('Success', 'Login successful');
            Get.offAll((const MyHomePage()));
          } else {
            Get.snackbar('Error', 'Login failed');
          }
        } else {
          Get.snackbar('Error', 'Please fill all fields');
        }
      },
      child: const Text(
        "เข้าสู่ระบบ",
        style: TextStyle(
          fontSize: 22,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class UsernameLoginInput extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNodePassword;

  const UsernameLoginInput({
    super.key,
    required this.controller,
    required this.focusNodePassword,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      //ช่องป้อนข้อมูล username
      controller: controller,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        labelText: "ชื่อผู้ใช้",
        prefixIcon: const Icon(Icons.person_outline),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      onEditingComplete: () => focusNodePassword.requestFocus(),
    );
  }
}

class PasswordLoginInput extends StatefulWidget {
  final TextEditingController controller;

  const PasswordLoginInput({
    super.key,
    required this.controller,
  });

  @override
  PasswordLoginInputState createState() => PasswordLoginInputState();
}

class PasswordLoginInputState extends State<PasswordLoginInput> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      //ช่องป้อนข้อมูล password
      controller: widget.controller,
      obscureText: _obscurePassword,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        labelText: "รหัสผ่าน",
        prefixIcon: const Icon(Icons.password_outlined),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
          icon: _obscurePassword
              ? const Icon(Icons.visibility_outlined)
              : const Icon(Icons.visibility_off_outlined),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      icon: const Image(
        image: AssetImage("assets/Logo-google-icon.png"),
        width: 24, // Adjust the width as needed
        height: 24, // Adjust the height as needed
      ),
      onPressed: () async {
        await AuthenticationRepository.instance.signInWithGoogle();
        // Navigate to home or show error message
        if (AuthenticationRepository.instance.firebaseUser.value != null) {
          Get.offAll(() => const Pinauthen());
        } else {
          Get.snackbar('Error', 'Failed to sign in with Google');
        }
      },
      label: const Text(
        "ลงชื่อเข้าใช้ด้วย Google",
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
      ),
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        side: const BorderSide(
          color: Colors.black,
        ),
      ),
    );
  }
}


//End login_button.dart