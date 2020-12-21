import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  Future<String> register(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else {
        return 'Invalid email address.';
      }
    } catch (e) {
      return 'Network error.';
    }
  }

  Future<String> login(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password' || e.code == 'invalid-email') {
        return 'Invalid email or password.';
      } else if (e.code == 'user-disabled') {
        return 'This account has been disabled.';
      } else {
        return 'No account with this email.';
      }
    } catch (e) {
      return 'Network error.';
    }
  }

  Future<String> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (e) {
      return 'There is no account with this email';
    } on SocketException catch (e) {
      return 'Network error.';
    } catch (e) {
      return 'Error has been occurred, please try again later.';
    }
  }
}
