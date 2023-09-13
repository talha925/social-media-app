import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_meadia_app/component/like_bitton.dart';
import 'package:social_meadia_app/provider/favourite_provider.dart';

class WallPost extends StatefulWidget {
  final String messsage;
  final String user;
  final String postId;
  final List<String> likes;

  const WallPost({
    Key? key,
    required this.messsage,
    required this.user,
    required this.postId,
    required this.likes,
  }) : super(key: key);

  @override
  State<WallPost> createState() => _WallPostState();
}

class _WallPostState extends State<WallPost> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;
  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser.email);
  }

//toggleLiked

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    // Acess the document  is firebase
    DocumentReference postRef =
        FirebaseFirestore.instance.collection("UserPosts").doc(widget.postId);

    if (isLiked) {
      // if the post is now like, add the user's email to the like field

      postRef.update({
        'Likes': FieldValue.arrayUnion([currentUser.email])
      });
    } else {
      // if the post is now like, remove the user's email to the like field

      postRef.update({
        'Likes': FieldValue.arrayRemove([currentUser.email])
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final textSize = maxWidth * 0.04;

        return Consumer<FavouriteProider>(
          builder: (context, favoriteProvider, _) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
              padding: const EdgeInsets.all(25),
              child: Row(
                children: [
                  Column(
                    children: [
                      LikeButton(
                        isLiked: isLiked,
                        onTap: toggleLike,
                      ),
                      const SizedBox(height: 5),

                      //like count
                      Text(
                        widget.likes.length.toString(),
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(width: maxWidth * 0.02),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.user,
                        style:
                            TextStyle(fontSize: textSize, color: Colors.grey),
                      ),
                      SizedBox(height: textSize * 0.1),
                      Text(
                        widget.messsage,
                        style: TextStyle(fontSize: textSize),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
