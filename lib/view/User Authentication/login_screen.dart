import 'package:chat_app/components/button.dart';
import 'package:chat_app/components/password_textfield.dart';
import 'package:chat_app/components/text_field.dart';
import 'package:chat_app/controllers/auth_services.dart';
import 'package:chat_app/view/Chat%20Screen/chat_screen.dart';
import 'package:chat_app/view/User%20Authentication/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    AuthServices authServices = AuthServices();

    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    double width = MediaQuery.sizeOf(context).width * 1;
    double height = MediaQuery.sizeOf(context).height * 1;

    @override
    void dispose() {
      emailController.dispose();
      passwordController.dispose();
      super.dispose();
    }

    Future userLogin() async {
      try {
        await authServices.userlogin(
            email: emailController.text.toString(),
            password: passwordController.text.toString());
        emailController.clear();
        passwordController.clear();
        Get.snackbar('Success', 'Successfully Login');
        Get.to(() => const ChatScreen(),
            transition: Transition.fade, duration: const Duration(seconds: 2));
      } catch (e) {
        Get.snackbar('Error', '$e');
      }
    }

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image(
                  image: const AssetImage('images/login.png'),
                  width: width * .5,
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                CustomtextField(
                  title: 'Email',
                  controller: emailController,
                  prefixicon: const Icon(Icons.email),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                PasstextField(
                  title: 'Password',
                  controller: passwordController,
                  prefixicon: const Icon(Icons.lock),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                CustomButton(
                    title: 'Login',
                    ontap: () async {
                      await userLogin();
                    }),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Didn't have an accout ? ",
                      style: GoogleFonts.poppins(fontSize: 12),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => const SignupScreen(),
                            transition: Transition.fade,
                            duration: const Duration(seconds: 2));
                      },
                      child: Text("Signup",
                          style: GoogleFonts.poppins(
                              color: Colors.deepPurple,
                              fontSize: 12,
                              fontWeight: FontWeight.w600)),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
