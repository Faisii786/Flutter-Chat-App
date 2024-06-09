import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/view/Splash%20Screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat App',
      theme: ThemeData.light().copyWith(
          appBarTheme: AppBarTheme(
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: Colors.deepPurple,
              titleTextStyle: GoogleFonts.acme(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w400))),
      home: const SplashScreen(),
    );
  }
}
