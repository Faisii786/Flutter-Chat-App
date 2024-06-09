import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class AuthServices {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future userSignUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email.toString(), password: password.toString());
      try {
        var uuid = const Uuid();
        await firestore.collection('users').doc(uuid.v1()).set({
          'name': name,
          'email': email,
          'passowrd': password,
        });
      } catch (ex) {
        throw Exception(ex.toString());
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future userlogin({
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email.toString(), password: password.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future saveUserMessages({
    required String userID,
    required String message,
    required DateTime time,
  }) async {
    try {
      await firestore.collection('messages').add({
        'id': userID,
        'message': message.toString(),
        'time': time,
      });
    } catch (ex) {
      throw Exception(ex.toString());
    }
  }

  Future logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (ex) {
      throw Exception(ex.toString());
    }
  }
}
