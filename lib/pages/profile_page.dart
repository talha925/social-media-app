import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_meadia_app/util/showdialog_box.dart';

import '../component/text_box.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Profile Page")),
        backgroundColor: Colors.grey[900],
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(DialogBoxs().currentUser!.email)
            .snapshots(),
        builder: ((context, snapshot) {
          // get user data
          if (snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;

            return ListView(
              children: [
                const SizedBox(
                  height: 50,
                ),
                //profile pic
                const Icon(
                  Icons.person,
                  size: 72,
                ),
                const SizedBox(
                  height: 12,
                ),
                //user email
                Text(
                  DialogBoxs().currentUser!.email!,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[700]),
                ),
                const SizedBox(
                  height: 50,
                ),
                //user name
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Text(
                    "My Details",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),

                //user name
                MyTextBox(
                  text: userData['username'],
                  sectionName: "username",
                  onPressed: () {
                    DialogBoxs().editField(
                      "username",
                      context,
                    );
                  },
                ),
                //bio
                MyTextBox(
                  text: userData['bio'],
                  sectionName: "bio",
                  onPressed: () {
                    DialogBoxs().editField("bio", context);
                  },
                ),
                //user post
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Text(
                    "My Posts",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error ${snapshot.error}'),
            );
          }
          return const Center(child: CircularProgressIndicator());
        }),
      ),
    );
  }
}
