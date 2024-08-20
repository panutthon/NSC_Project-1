import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:encrypt/encrypt.dart' as encrypt;

class DataEncryptor {
  late encrypt.Encrypter _encrypter;
  late encrypt.IV _iv;

  DataEncryptor() {
    _initializeEncryption();
  }

  void _initializeEncryption() async {
    final key = encrypt.Key.fromLength(32); // Generate a random 32-byte key
    _iv = encrypt.IV.fromLength(16); // Generate a random 16-byte IV
    _encrypter = encrypt.Encrypter(encrypt.AES(key));
  }

  String hashPassword(String password) {
    final bytes = utf8.encode(password);
    final hash = sha256.convert(bytes);
    return hash.toString();
  }

  String encryptData(String data) {
    final encrypted = _encrypter.encrypt(data, iv: _iv);
    return encrypted.base64;
  }

  // Optional: Decrypt data (assuming you have a secure way to store/transmit the IV)
  String decryptData(String ciphertext) {
    final decrypted = _encrypter.decrypt64(ciphertext, iv: _iv);
    return decrypted;
  }
}
