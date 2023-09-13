import 'package:flutter/material.dart';
import 'package:social_meadia_app/util/const.dart';

class MyListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final void Function()? onTap;
  const MyListTile({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: whiteColorr,
      ),
      onTap: onTap,
      title: Text(
        text,
        style: whiteColor,
      ),
    );
  }
}
