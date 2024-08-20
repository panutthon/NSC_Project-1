//password_requirements.dart

import 'package:flutter/material.dart';

class PassCheckRequirements extends StatelessWidget {
  final bool passCheck;
  final String requirementText;
  final Color activeColor;
  final Color inActiveColor;
  final IconData inActiveIcon;
  final IconData activeIcon;

  const PassCheckRequirements({
    super.key,
    required this.passCheck,
    required this.requirementText,
    required this.activeColor,
    required this.inActiveColor,
    required this.inActiveIcon,
    required this.activeIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          passCheck ? activeIcon : inActiveIcon,
          color: passCheck ? activeColor : inActiveColor,
        ),
        const SizedBox(width: 10),
        Text(requirementText),
      ],
    );
  }
}

Column validateCheck({
  required bool hasUpperCase,
  required bool hasLowerCase,
  required bool hasNumber,
  required bool hasSpecialChar,
  required bool isLongEnough,
}) {
  return Column(
    children: [
      PassCheckRequirements(
        passCheck: hasUpperCase,
        requirementText: "1 ตัวอักษรพิมพ์ใหญ่ [A-Z]",
        activeColor: Colors.green,
        inActiveColor: Colors.red,
        inActiveIcon: Icons.close,
        activeIcon: Icons.check,
      ),
      PassCheckRequirements(
        passCheck: hasLowerCase,
        requirementText: "1 ตัวอักษรพิมพ์เล็ก [a-z]",
        activeColor: Colors.green,
        inActiveColor: Colors.red,
        inActiveIcon: Icons.close,
        activeIcon: Icons.check,
      ),
      PassCheckRequirements(
        passCheck: hasNumber,
        requirementText: "1 ตัวเลข [0-9]",
        activeColor: Colors.green,
        inActiveColor: Colors.red,
        inActiveIcon: Icons.close,
        activeIcon: Icons.check,
      ),
      PassCheckRequirements(
        passCheck: hasSpecialChar,
        requirementText: "1 ตัวอักษรพิเศษ",
        activeColor: Colors.green,
        inActiveColor: Colors.red,
        inActiveIcon: Icons.close,
        activeIcon: Icons.check,
      ),
      PassCheckRequirements(
        passCheck: isLongEnough,
        requirementText: "ความยาวอย่างน้อย 8 ตัวอักษร",
        activeColor: Colors.green,
        inActiveColor: Colors.red,
        inActiveIcon: Icons.close,
        activeIcon: Icons.check,
      ),
    ],
  );
}

//End password_requirements.dart