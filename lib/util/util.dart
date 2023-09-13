import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:social_meadia_app/util/flutter_error_notiy.dart';

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

  // signIn() function
  Future<void> signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      Message.toastMessage(e.message.toString());

      if (kDebugMode) {
        print(e);
      }
    } catch (e) {
      // Handle other exceptions
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }

  // Sign up function
  Future<void> signUp(
    BuildContext context,
    String email,
    String password,
    String confirmPassword,
  ) async {
//
    showDialog(
        context: context,
        builder: (context) => const Center(child: SingleChildScrollView()));

    if (passwordConfirmed(password, confirmPassword)) {
      //try creating the user
      try {
        //create the user
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // after creating the user, create a new document on cloud firestore called Users
        FirebaseFirestore.instance
            .collection("Users")
            .doc(userCredential.user!.email!)
            .set({
          'username': email.split('@')[0], //initial username
          'bio': 'Empty bio.', //initial empty bio
          //add any additional fields as neede
        });

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
