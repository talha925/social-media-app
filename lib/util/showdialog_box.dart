import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DialogBoxs {
  //user
  final currentUser = FirebaseAuth.instance.currentUser;

  // all users

  final userCollection = FirebaseFirestore.instance.collection("Users");

  //edit fields

  Future<void> editField(String field, BuildContext? context) async {
    String newValue = "";
    await showDialog(
        context: context!,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.grey[900],
            title: Text(
              "Edit $field",
              style: const TextStyle(color: Colors.white),
            ),
            content: TextField(
              autofocus: true,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Edit new $field",
                hintStyle: const TextStyle(color: Colors.grey),
              ),
              onChanged: (value) {
                newValue = value;
              },
            ),
            actions: [
              //cancel button

              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white),
                ),
              ),

              //save button

              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(newValue);
                },
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        });

    //update in firestore

    if (newValue.trim().isNotEmpty) {
      // only update if there is something in the text field

      await userCollection.doc(currentUser!.email).update({field: newValue});
    }
  }
}
