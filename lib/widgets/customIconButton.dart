import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  CustomIconButton({super.key, this.onTap, required this.iconData});
  void Function()? onTap;
  IconData iconData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 1),
        ),
        child: CircleAvatar(
          backgroundColor: Colors.purple,
          child: Icon(iconData, color: Colors.white),
        ),
      ),
    );
  }
}
