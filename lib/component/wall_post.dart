import 'package:flutter/material.dart';

class WallPost extends StatelessWidget {
  final String messsage;
  final String user;

  const WallPost({
    super.key,
    required this.messsage,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Flexible(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
        padding: EdgeInsets.only(
          top: height * 0.03,
          bottom: height * 0.03,
          left: width * 0.4,
          right: width * 0.4,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user),
                Text(messsage),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
