import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_meadia_app/util/flutter_error_notiy.dart';

import '../component/my_button.dart';
import '../component/text_field.dart';
import '../util/util.dart';
import 'forgot_password.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback? showRegisterPage;
  const LoginPage({
    super.key,
    required this.showRegisterPage,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.06),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.04,
                ),

                //logo
                Icon(
                  Icons.lock,
                  size: width * 0.2,
                ),
                SizedBox(
                  height: height * 0.06,
                ),

                //welcome back message
                Text(
                  "Welcome back, you're been missed !",
                  style: GoogleFonts.bebasNeue(
                    fontSize: 22,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(
                  height: height * 0.06,
                ),
                //email text field

                MyTextField(
                  controller: emailcontroller,
                  hintText: "Email ",
                  obsecureText: false,
                ),

                //Password Textfield
                SizedBox(
                  height: height * 0.01,
                ),
                //Email Textfield
                MyTextField(
                  controller: passwordcontroller,
                  hintText: "Password ",
                  obsecureText: true,
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ForgotPasswordPage()));
                      },
                      child: const Text(
                        "Forgot your password?",
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.04,
                ),

                //Sign in Button
                MyButton(
                  text: "Sign in",
                  ontap: () {
                    if (emailcontroller.text.isEmpty) {
                      Message.toastMessage(
                        'Please enter email',
                      );
                    } else if (passwordcontroller.text.isEmpty) {
                      Message.toastMessage(
                        'Please enter password',
                      );
                    } else if (passwordcontroller.text.length < 6) {
                      Message.toastMessage(
                        'Please enter 6 digit password',
                      );
                    } else {
                      Util().signIn(emailcontroller.text.trim(),
                          passwordcontroller.text.trim());
                    }
                  },
                ),
                //go to register app
                SizedBox(
                  height: height * 0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not a member?",
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    GestureDetector(
                      onTap: () {
                        widget.showRegisterPage!();
                      },
                      child: const Text(
                        "Register nows ",
                        style: TextStyle(
                          color: Colors.blue,
                          // fontSize: width * 0.2,
                        ),
                      ),
                    ),
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
