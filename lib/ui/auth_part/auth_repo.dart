//auth_repo.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:nsc_whatidan_security/ui/auth_part/signup_email_password_failure.dart';
import 'package:nsc_whatidan_security/ui/login_part/login/username_login.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId = ''.obs;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    _auth.setLanguageCode('th');
  }

  void phoneAuthentication(String phoneNo) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNo,
      verificationCompleted: (credential) async {
        await _auth.signInWithCredential(credential);
      },
      codeSent: (verificationId, resendToken) {
        this.verificationId.value = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {
        this.verificationId.value = verificationId;
      },
      verificationFailed: (e) {
        switch (e.code) {
          case 'invalid-phone-number':
            Get.snackbar('Error', 'The provided phone number is not valid.',
                messageText: Text(phoneNo));
            break;
          case 'invalid-request':
            Get.snackbar('Error', 'The request is invalid.');
            break;
          case 'too-many-requests':
            Get.snackbar('Error', 'Too many requests have been made.');
            break;
          case 'quota-exceeded':
            Get.snackbar('Error', 'The quota has been exceeded.');
            break;
          case 'unsupported-region':
            Get.snackbar('Error', 'The region is unsupported.');
            break;
          default:
            Get.snackbar('Error Default', {e.code} as String);
        }
      },
    );
  }

  Future<bool> verifyOTP(String otp) async {
    try {
      var credentials = await _auth.signInWithCredential(
          PhoneAuthProvider.credential(
              verificationId: verificationId.value, smsCode: otp));
      return credentials.user != null ? true : false;
    } catch (e) {
      Get.snackbar('Error', 'Failed to verify OTP');
      return false;
    }
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      final ex = SignupWithEmailAndPasswordFailure.code(e.code);
      // แสดงข้อความแจ้งเตือนให้ผู้ใช้ทราบ
      Get.snackbar('Error', ex.message);
    } catch (_) {
      const ex = SignupWithEmailAndPasswordFailure();
      Get.snackbar('Error', ex.message);
      throw ex;
    }
  }

  Future<bool> loginWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (userCredential.user != null) {
        return true;
      } else {
        return false;
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          Get.snackbar('Error', 'No user found for that email.');
          break;
        case 'wrong-password':
          Get.snackbar('Error', 'Wrong password provided for that user.');
          break;
        default:
          Get.snackbar('Error', 'An error occurred: ${e.message}');
      }
      return false;
    } catch (e) {
      Get.snackbar('Error', '$e');
      return false;
    }
  }

  Future<void> logout() async {
    try {
      if (firebaseUser.value != null) {
        for (final userInfo in firebaseUser.value!.providerData) {
          if (userInfo.providerId == 'google.com') {
            // Logout from Google
            if (!(await signOutFromGoogle())) {
              Get.snackbar('Error', 'Failed to logout from Google');
              return;
            }
          } else {
            // Logout from email/password
            await _auth.signOut();
          }
        }
        Get.snackbar('Success', 'Logged out successfully');
      } else {
        Get.snackbar('Error', 'No user to logout');
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', 'Failed to logout: ${e.message}');
    } catch (e) {
      Get.snackbar('Error', 'An unknown error occurred while logging out.');
    }
  }

  Future<bool> isAuthenticated() async {
    await _auth.currentUser?.reload();
    final user = _auth.currentUser;
    return user != null;
  }

  Future<dynamic> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on Exception catch (e) {
      Get.snackbar('Error', '$e');
    }
  }

  Future<bool> signOutFromGoogle() async {
    try {
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn()
          .signOut(); // Sign out from Google for choose account again next time
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  Future<void> resetPassword(
      {required String phoneNumber, required String newPassword}) async {
    try {
      // ดึงข้อมูลผู้ใช้จากหมายเลขโทรศัพท์
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .where('phone', isEqualTo: phoneNumber)
              .get();

      // ตรวจสอบว่ามีผู้ใช้หรือไม่
      if (snapshot.docs.isNotEmpty) {
        final userDoc = snapshot.docs.first;
        final userId = userDoc.id;
        final userRef =
            FirebaseFirestore.instance.collection('users').doc(userId);

        // อัปเดตรหัสผ่าน
        await _auth.sendPasswordResetEmail(email: userDoc['email']);

        // อัปเดตข้อมูลใน Firestore (ถ้าจำเป็น)
        await userRef.update({'passwordReset': true});

        Get.snackbar('Success',
            'รหัสผ่านถูกรีเซ็ตเรียบร้อยแล้ว กรุณาตรวจสอบอีเมลของคุณ');
      } else {
        Get.snackbar('Error', 'ไม่พบผู้ใช้ที่มีหมายเลขโทรศัพท์นี้');
      }
    } catch (e) {
      Get.snackbar('Error', 'เกิดข้อผิดพลาดในการรีเซ็ตรหัสผ่าน: $e');
    }
  }
}

//End auth_repo.dart