import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

  Future<bool> completeProfile(
    String username,
    String mobileNumber,
    String address,
    LatLng position,
    File image,
  ) async {
    try {
      String id = FirebaseAuth.instance.currentUser.uid;
      Reference ref = FirebaseStorage.instance
          .ref('users/$id.${image.path.split('.').last}');
      await ref.putFile(image);
      String imageUrl = await ref.getDownloadURL();
      await FirebaseFirestore.instance.collection('users').doc(id).set({
        'username': username,
        'mobileNumber': mobileNumber,
        'address': address,
        'lat': position.latitude,
        'lng': position.longitude,
        'photoUrl': imageUrl,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> isProfileComplete() async {
    try {
      String id = FirebaseAuth.instance.currentUser.uid;
      final document =
          await FirebaseFirestore.instance.collection('users').doc(id).get();
      if (document.exists) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }
}
