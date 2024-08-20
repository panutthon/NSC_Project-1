import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class CreatePinScreen extends StatefulWidget {
  const CreatePinScreen({super.key});

  @override
  _CreatePinScreenState createState() => _CreatePinScreenState();
}

class _CreatePinScreenState extends State<CreatePinScreen> {
  final TextEditingController _pinController = TextEditingController();
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> _initializeApp() async {
    await Firebase.initializeApp();
  }

  Future<void> _savePin(String pin) async {
    _initializeApp();
    try {
      final pinHash = sha256.convert(utf8.encode(pin)).toString();
      // ignore: unused_local_variable
      final user = <String, dynamic>{
        'pin': pinHash,
      };
      String doc = 'OcwxGuT4wn5BnChAOXLv';
      await db.collection('Authen_part').add(user).then(
          (DocumentReference doc) =>
              print('DocumentSnapshot added with ID: ${doc.id}'));
      ;
      // PIN saved successfully, handle success if needed
    } catch (error) {
      print("Error saving PIN: $error");
      // Show an error message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create PIN'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('กรุณาสร้างรหัส PIN ของคุณ'),
            TextField(
              controller: _pinController,
              keyboardType: TextInputType.number,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'PIN',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_pinController.text.length == 4) {
                  await _savePin(_pinController.text);
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('PIN ต้องมี 4 หลัก')),
                  );
                }
              },
              child: const Text('บันทึก PIN'),
            ),
          ],
        ),
      ),
    );
  }
}
