import 'dart:async';

import 'package:chat_app/view/Splash%20Screen/splash_services.dart';
import 'package:chat_app/view/User%20Authentication/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashServices = SplashServices();
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Get.to(() => const LoginScreen(),
          duration: const Duration(seconds: 2), transition: Transition.fade);
    });

    splashServices.checkUserStatus(context);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width * 1;
    double height = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: const AssetImage('images/splash.png'),
            width: width * 1,
            height: height * .5,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: height * 0.05,
          ),
          Text(
            "Wellcome to My Chat App",
            style:
                GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: height * 0.05,
          ),
          const SpinKitChasingDots(
            color: Colors.deepPurple,
            size: 30,
          )
        ],
      ),
    );
  }
}
