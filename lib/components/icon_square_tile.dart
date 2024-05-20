import 'package:flutter/material.dart';

class IconSquareTile extends StatelessWidget {
  final String imagepath;
  final Function()? onTap;
  const IconSquareTile(
      {super.key, required this.onTap, required this.imagepath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                    color: Colors.black,
                    blurRadius: 15,
                    blurStyle: BlurStyle.outer)
              ]),
          child: Image.asset(imagepath, height: 40),
        ));
  }
}
