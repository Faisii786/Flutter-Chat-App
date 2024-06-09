import 'package:chat_app/components/button.dart';
import 'package:chat_app/components/password_textfield.dart';
import 'package:chat_app/components/text_field.dart';
import 'package:chat_app/controllers/auth_services.dart';
import 'package:chat_app/view/Chat%20Screen/chat_screen.dart';
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
  bool isloading = false;

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
      setState(() {
        isloading = true;
      });
      try {
        await authServices.userSignUp(
            name: nameController.text.toString(),
            email: emailController.text.toString(),
            password: passwordController.text.toString());
        nameController.clear();
        emailController.clear();
        passwordController.clear();
        Get.snackbar('Success', 'Your account has been successfully created');
        Get.to(() => const ChatScreen(),
            transition: Transition.fade, duration: const Duration(seconds: 2));
      } catch (e) {
        Get.snackbar('Error', '$e');
        setState(() {
          isloading = false;
        });
      }
      setState(() {
        isloading = false;
      });
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
                  prefixicon: const Icon(Icons.person),
                ),
                SizedBox(
                  height: height * 0.02,
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
                    isloading: isloading,
                    title: 'SingUp',
                    ontap: () async {
                      await createUser();
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
                        Get.to(() => const LoginScreen(),
                            transition: Transition.fade,
                            duration: const Duration(seconds: 2));
                      },
                      child: Text("Login",
                          style: GoogleFonts.poppins(
                              color: Colors.deepPurple,
                              fontSize: 12,
                              fontWeight: FontWeight.w600)),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
