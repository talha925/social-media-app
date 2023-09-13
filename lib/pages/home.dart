import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_meadia_app/component/drawer.dart';
import 'package:social_meadia_app/component/text_field.dart';
import 'package:social_meadia_app/component/wall_post.dart';
import 'package:social_meadia_app/pages/profile_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final currentUser = FirebaseAuth.instance.currentUser;
  final _textcontroller = TextEditingController();

  void postMessage() {
    // only post if there something in the text field
    if (_textcontroller.text.isNotEmpty) {
      FirebaseFirestore.instance.collection("UserPosts").add({
        'UserEmail': currentUser!.email,
        "Message": _textcontroller.text,
        "TimeStamp": Timestamp.now(),
        "Likes": [],
      });
      _textcontroller.clear();
    }
  }

  // navigate to profile page

  void goToProfilePage() {
    //pop menu drawer

    Navigator.pop(context);

    // go to profile page

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const ProfilePage()));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          title: const Center(child: Text("The wall")),
        ),
        drawer: MyDrawer(
          onProfileTap: goToProfilePage,
          onSignout: FirebaseAuth.instance.signOut,
        ),
        body: Column(
          children: [
            Expanded(
                child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("UserPosts")
                  .orderBy(
                    "TimeStamp",
                    descending: false,
                  )
                  .snapshots(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      // get the message

                      final post = snapshot.data!.docs[index];

                      return WallPost(
                        messsage: post['Message'],
                        user: post["UserEmail"],
                        likes: List<String>.from(post['Likes'] ?? []),
                        postId: post.id,
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("Error:  ${snapshot.error}"),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            )),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                children: [
                  Expanded(
                    child: MyTextField(
                        controller: _textcontroller,
                        hintText: 'write something on the wall',
                        obsecureText: false),
                  ),
                  IconButton(
                      onPressed: postMessage,
                      icon: const Icon(Icons.arrow_circle_up)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
