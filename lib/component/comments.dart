import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  final String user;
  final String time;
  final String text;

  const Comment({
    super.key,
    required this.user,
    required this.time,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          //comment
          Text(text),
          //user ,time

          Row(
            children: [
              Text(text),
              const Text(" . "),
              Text(text),
            ],
          ),
        ],
      ),
    );
  }
}
