//username_login.dart สำหรับสร้างช่องป้อนข้อมูล username และ password ในหน้า login

import 'package:flutter/material.dart';
import 'login_button.dart';

class Login extends StatefulWidget {
  // ignore: use_super_parameters
  const Login({
    Key? key,
  }) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey =
      GlobalKey(); //_formKey สำหรับตรวจสอบความถูกต้องของข้อมูลในฟอร์ม

  final FocusNode _focusNodePassword =
      FocusNode(); //_focusNodePassword: สำหรับควบคุมการโฟกัสที่ช่องป้อนรหัสผ่าน
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  //_controllerUsername และ _controllerPassword: สำหรับควบคุมการกรอกข้อมูลในช่อง username และ password

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            //ช่วยให้ scroll ได้กรณีข้อมูลในหน้าจอเยอะเกิน
            padding: const EdgeInsets.all(10.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Image.asset(
                      //โลโก้ Whatidan
                      'assets/logo_app_whatidan.png',
                      height: 200, // Adjust the height as needed
                      width: 500, // Adjust the width as needed
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      //ข้อความลงชื่อเข้าใช้
                      "ลงชื่อเข้าใช้",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const SizedBox(
                      //ปุ่มลงชื่อเข้าใช้ด้วย Google
                      width: double.infinity,
                      child: GoogleSignInButton(),
                    ),
                    const SizedBox(height: 20),
                    const Row(
                      children: [
                        SizedBox(
                          width: 110,
                          child: Divider(
                            //เส้นแบ่งระหว่างปุ่มลงชื่อเข้าใช้ด้วย Google กับข้อความหรือ
                            color: Color(0xffb8b8b8),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text("หรือ", style: TextStyle(fontSize: 16)),
                        SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          width: 110,
                          child: Divider(
                            //เส้นแบ่งระหว่างปุ่มลงชื่อเข้าใช้ด้วย Google กับข้อความหรือ
                            color: Color(0xffb8b8b8),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    UsernameLoginInput(
                      controller: _controllerUsername,
                      focusNodePassword: _focusNodePassword,
                    ),
                    const SizedBox(height: 10),
                    PasswordLoginInput(
                      controller: _controllerPassword,
                    ),
                    const SizedBox(height: 30),
                    Column(
                      children: [
                        LoginButton(
                          emailController: _controllerUsername,
                          passwordController: _controllerPassword,
                        ),
                        const SignUpButton(),
                        const ForgotPassButton(),
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

  @override
  void dispose() {
    _focusNodePassword.dispose();
    _controllerUsername.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }
}

//End username_login.dart