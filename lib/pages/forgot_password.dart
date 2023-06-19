import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../component/my_button.dart';
import '../component/text_field.dart';
import '../util/util.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => ForgotPasswordPageState();
}

class ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailcontroller = TextEditingController();

  @override
  void dispose() {
    emailcontroller.dispose();

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
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              height: height * 0.02,
            ),

            //welcome back message
            Text(
              "Enter Your Email And We will send you a password reset link! ",
              style: GoogleFonts.libreBaskerville(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            //email text field
            MyTextField(
                controller: emailcontroller,
                hintText: "Email ",
                obsecureText: false),

            SizedBox(
              height: height * 0.04,
            ),

            //Sign in Button
            MyButton(
              text: "Reset password",
              ontap: () {
                Util().passwordReset(context, emailcontroller.text.trim());
              },
            ),
          ]),
        ),
      ),
    ));
  }
}
