import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Util {
  // passwordReset function forgot password
  Future passwordReset(BuildContext context, String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text('Password reset Link sent! Check your email'),
            );
          });
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
      if (kDebugMode) {
        print(e);
      }
    }
  }

//signIn() functiom

  Future signIn(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Sign up function
  Future<void> signUp(
    BuildContext context,
    String email,
    String password,
    String confirmPassword,
  ) async {
//
    // showDialog(
    //     context: context,
    //     builder: (context) => const Center(child: SingleChildScrollView()));

    if (passwordConfirmed(password, confirmPassword)) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        showDialog(
          context: (context),
          builder: (_) {
            return const AlertDialog(
              content: Text('Sign up successful!'),
            );
          },
        );
      } on FirebaseAuthException catch (e) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          },
        );
        if (kDebugMode) {
          print(e);
        }
      }
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text('Passwords do not match!'),
          );
        },
      );
    }
  }

  // Password confirmation check function
  bool passwordConfirmed(
    String password,
    String confirmPassword,
  ) {
    return password == confirmPassword;
  }
}
