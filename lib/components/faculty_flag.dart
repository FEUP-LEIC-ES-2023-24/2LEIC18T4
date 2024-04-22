import 'package:flutter/material.dart';

class FacultyFlag extends StatefulWidget {
  final String facultyName;
  final Color facultyColor;
  const FacultyFlag(
      {super.key, required this.facultyName, required this.facultyColor});

  @override
  State<FacultyFlag> createState() => _FacultyFlagState();
}

class _FacultyFlagState extends State<FacultyFlag> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.facultyColor
      ),
      margin: const EdgeInsets.symmetric(horizontal: 3),
      padding: const EdgeInsets.all(2),
      child: Text(
        widget.facultyName,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
