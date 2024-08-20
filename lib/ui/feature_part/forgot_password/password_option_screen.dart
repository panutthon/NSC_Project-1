import 'package:flutter/material.dart';
import 'package:nsc_whatidan_security/ui/feature_part/forgot_password/password_forgot_mail.dart';
import 'package:nsc_whatidan_security/ui/feature_part/forgot_password/password_forgot_phone.dart';

class ForgotPasswordScreen {
  static Future<dynamic> passwordOptionScreen(BuildContext context) {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      backgroundColor: Colors.white,
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      "ลืมรหัสผ่าน",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(width: 16),
                    Text(
                      "เลือกวิธีการยืนยันตัวตน",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ForgotPasswordButton(
                      forgotButtonIcon: Icons.mail_outline_rounded,
                      title: "อีเมล",
                      subtitle: "อีเมลยืนยันตัวตน",
                      onTap: () {
                        Navigator.pop(context);

                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          ForgotPasswordMail().showModal(context);
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ForgotPasswordButton(
                      forgotButtonIcon: Icons.mobile_friendly_outlined,
                      title: "หมายเลขโทรศัพท์",
                      subtitle: "หมายเลขโทรศัพท์ยืนยันตัวตน",
                      onTap: () {
                        Navigator.pop(context);
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          ForgotPasswordPhone().showModal(context);
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({
    required this.forgotButtonIcon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    super.key,
  });

  final IconData forgotButtonIcon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromARGB(255, 130, 176, 213),
        ),
        child: Row(children: [
          Icon(
            size: 60,
            forgotButtonIcon,
            color: Colors.white,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    title,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Text(subtitle,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 16)),
                ],
              )
            ],
          )
        ]),
      ),
    );
  }
}
