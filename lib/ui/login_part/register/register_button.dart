//register_button.dart

import 'package:flutter/material.dart';
import 'package:nsc_whatidan_security/ui/feature_part/terms.dart';

Row termButton({
  required BuildContext context,
  required bool acceptedTerms,
  required Function(bool) onChanged,
}) {
  return Row(
    children: [
      const SizedBox(width: 16.0),
      Switch(
        value: acceptedTerms,
        onChanged: (bool value) {
          onChanged(value);
        },
        activeColor: Colors.white,
        activeTrackColor: Colors.blue,
        inactiveTrackColor: Colors.white,
      ),
      const SizedBox(width: 10.0),
      const Text(
        "ยอมรับ ",
        style: TextStyle(color: Colors.black, fontSize: 16.0),
      ),
      Expanded(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TermsAndConditionsPage(),
              ),
            );
          },
          child: const Text(
            "ข้อตกลงและเงื่อนไข",
            style: TextStyle(color: Colors.blue, fontSize: 16.0),
          ),
        ),
      ),
    ],
  );
}

ElevatedButton registerButton({
  required BuildContext context,
  required Function() onPressed,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue,
    ),
    child: const Text(
      'ลงทะเบียน',
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  );
}


//End register_button.dart