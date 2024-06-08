import 'dart:async';

import 'package:chat_app/view/Chat%20Screen/chat_screen.dart';
import 'package:chat_app/view/User%20Authentication/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashServices {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  void checkUserStatus(BuildContext context) async {
    if (firebaseAuth.currentUser != null) {
      Timer(const Duration(seconds: 3), () {
        Get.to(() => const ChatScreen());
      });
    } else {
      Timer(const Duration(seconds: 3), () {
        Get.to(() => const LoginScreen());
      });
    }
  }
}
