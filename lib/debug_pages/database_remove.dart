import 'package:flutter/material.dart';

class DatabaseRemove extends StatefulWidget {
  const DatabaseRemove({super.key});

  @override
  State<DatabaseRemove> createState() => _DatabaseRemoveState();
}

class _DatabaseRemoveState extends State<DatabaseRemove> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('Database remove')
    );
  }
}