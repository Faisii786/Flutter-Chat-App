import 'package:chat_app/components/button.dart';
import 'package:chat_app/components/text_field.dart';
import 'package:chat_app/controllers/auth_services.dart';
import 'package:chat_app/view/User%20Authentication/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    AuthServices authServices = AuthServices();

    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    double width = MediaQuery.sizeOf(context).width * 1;
    double height = MediaQuery.sizeOf(context).height * 1;

    @override
    void dispose() {
      nameController.dispose();
      emailController.dispose();
      passwordController.dispose();
      super.dispose();
    }

    Future createUser() async {
      try {
        await authServices.userSignUp(
            name: nameController.text.toString(),
            email: emailController.text.toString(),
            password: passwordController.text.toString());
        nameController.clear();
        emailController.clear();
        passwordController.clear();
        Get.snackbar('Success', 'Your account has been successfully created');
        Get.to(() => const LoginScreen(),
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
                  image: const AssetImage('images/signup.png'),
                  width: width * .5,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                CustomtextField(
                  title: 'Name',
                  controller: nameController,
                  icon: const Icon(Icons.person),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                CustomtextField(
                  title: 'Email',
                  controller: emailController,
                  icon: const Icon(Icons.email),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                CustomtextField(
                  title: 'Password',
                  controller: passwordController,
                  icon: const Icon(Icons.security),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                CustomButton(
                    title: 'SingUp',
                    ontap: () async {
                      await createUser();
                    }),
                SizedBox(
                  height: height * 0.02,
                ),
                Text(
                  "Didn't have an accout ? ",
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const LoginScreen(),
                        transition: Transition.fade,
                        duration: const Duration(seconds: 2));
                  },
                  child: Text("Login",
                      style: GoogleFonts.poppins(
                          fontSize: 14, fontWeight: FontWeight.w500)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}