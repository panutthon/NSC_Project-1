import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ข้อตกลงการใช้งาน'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  offset: const Offset(0.0, 5.0),
                  blurRadius: 10.0,
                ),
              ],
            ),
            child: const Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ข้อกำหนดและเงื่อนไขการใช้บริการ WhatIDan',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    '1. บทนำ',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'WhatIDan เป็นแอปพลิเคชันสำหรับบันทึกข้อมูลค่าความดันและข้อมูลสุขภาพอื่นๆ '
                    'ผู้ใช้บริการ (“ผู้ใช้”) ต้องอ่านและยอมรับข้อกำหนดและเงื่อนไขการใช้บริการ '
                    '(“ข้อกำหนดและเงื่อนไข”) นี้ก่อนที่จะใช้บริการ WhatIDan ',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    '2. การลงทะเบียนและบัญชีผู้ใช้',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    '- ผู้ใช้ต้องมีอายุ 18 ปีบริบูรณ์ขึ้นไป\n'
                    '- ผู้ใช้ต้องสร้างบัญชีผู้ใช้ (“บัญชี”) โดยให้ข้อมูลที่ถูกต้อง ครบถ้วน และเป็นปัจจุบัน\n'
                    '- ผู้ใช้ต้องรับผิดชอบต่อการรักษาความปลอดภัยของบัญชี\n'
                    '- ผู้ใช้ไม่สามารถโอนหรือแบ่งปันบัญชีของตนกับผู้อื่น\n'
                    '- ผู้พัฒนามีสิทธิ์ลบบัญชีผู้ใช้ที่ไม่ได้ใช้งานเป็นเวลานาน',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    '3. ข้อมูลผู้ใช้',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    '- WhatIDan รวบรวมข้อมูลส่วนบุคคลของผู้ใช้ เช่น ชื่อ นามสกุล เพศ วันเกิด อีเมล และข้อมูลสุขภาพ\n'
                    '- WhatIDan ใช้ข้อมูลผู้ใช้เพื่อวัตถุประสงค์ในการให้บริการ พัฒนาแอปพลิเคชัน และวิเคราะห์ข้อมูล\n'
                    '- WhatIDan จะไม่เปิดเผยข้อมูลผู้ใช้แก่บุคคลที่สามโดยไม่ได้รับความยินยอมจากผู้ใช้\n'
                    '- ผู้ใช้สามารถขอเข้าถึง แก้ไข หรือลบข้อมูลส่วนบุคคลของตนได้',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    '4. การใช้งาน',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    '- ผู้ใช้ต้องใช้ WhatIDan เพื่อวัตถุประสงค์ส่วนตัวและถูกต้องตามกฎหมายเท่านั้น\n'
                    '- ผู้ใช้ห้ามใช้ WhatIDan เพื่อวัตถุประสงค์ที่ผิดกฎหมาย เป็นอันตราย หรือละเมิดสิทธิของผู้อื่น\n'
                    '- ผู้ใช้ต้องรับผิดชอบต่อเนื้อหาที่ผู้ใช้สร้างขึ้นบน WhatIDan',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    '5. การรับประกัน',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    '- WhatIDan ให้บริการ “ตามสภาพ” ผู้พัฒนาไม่รับประกันว่า WhatIDan จะทำงานได้อย่างถูกต้อง ต่อเนื่อง หรือปลอดภัย\n'
                    '- WhatIDan ไม่รับผิดชอบต่อความเสียหายใด ๆ ที่เกิดขึ้นจากการใช้งาน WhatIDan',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    '6. การจำกัดความรับผิด',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    '- ผู้พัฒนาไม่รับผิดชอบต่อความเสียหายทางตรง ทางอ้อม พิเศษ หรือผลสืบเนื่องใด ๆ ที่เกิดขึ้นจากการใช้งาน WhatIDan',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    '7. การเปลี่ยนแปลง',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    '- ผู้พัฒนาสามารถเปลี่ยนแปลงข้อกำหนดและเงื่อนไขนี้ได้โดยไม่ต้องแจ้งให้ผู้ใช้ทราบล่วงหน้า',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    '8. กฎหมายที่ใช้บังคับและเขตอำนาจศาล',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    '- ข้อกำหนดและเงื่อนไขนี้จะอยู่ภายใต้บังคับของกฎหมายไทย\n'
                    '- ข้อพิพาทใด ๆ ที่เกิดขึ้นจากข้อกำหนดและเงื่อนไขนี้ จะอยู่ภายใต้เขตอำนาจศาลในราชอาณาจักรไทย',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    '9. การติดต่อ',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    '- ผู้ใช้สามารถติดต่อบริษัทได้ที่ NSC_WhatIDan@gmail.com',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
