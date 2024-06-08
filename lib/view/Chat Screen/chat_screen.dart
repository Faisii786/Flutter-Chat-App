import 'package:chat_app/controllers/auth_services.dart';
import 'package:chat_app/view/User%20Authentication/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController = TextEditingController();
  final AuthServices authServices = AuthServices();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  Future<void> sendMessage() async {
    try {
      await authServices.saveUserMessages(
          message: messageController.text.toString());
      messageController.clear();
    } catch (e) {
      Get.snackbar('Error', '$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
        actions: [
          IconButton(
              onPressed: () async {
                try {
                  await authServices.logout();
                  Get.to(() => const LoginScreen());
                } catch (e) {
                  Get.snackbar("Error", '$e');
                }
              },
              icon: const Icon(Icons.logout_rounded))
        ],
      ),
      body: SizedBox(
        width: width,
        height: height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('messages')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(child: Text('Error'));
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot data = snapshot.data!.docs[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            child: Column(
                              crossAxisAlignment:
                                  firebaseAuth.currentUser != null
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: firebaseAuth.currentUser != null
                                      ? Alignment.topLeft
                                      : Alignment.topLeft,
                                  height: height * 0.07,
                                  width: width * .5,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: firebaseAuth.currentUser != null
                                        ? const Color.fromARGB(255, 39, 160, 43)
                                        : const Color.fromARGB(
                                            255, 20, 80, 129),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      data['message'],
                                      style: GoogleFonts.poppins(
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                    return const Center(child: Text("No data Available"));
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: messageController,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(left: 20),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.black,
                              width: 3,
                            )),
                            floatingLabelBehavior: FloatingLabelBehavior.never),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.06,
                    width: width * 0.12,
                    child: Center(
                      child: IconButton(
                        onPressed: () async {
                          await sendMessage();
                        },
                        icon: const Icon(
                          Icons.send,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
