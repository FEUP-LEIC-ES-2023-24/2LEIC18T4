import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:study_at/debug_pages/create_bottom.dart';

class DatabaseAdd extends StatefulWidget {
  const DatabaseAdd({super.key});

  @override
  State<DatabaseAdd> createState() => _DatabaseAddState();
}

final databaseReference = FirebaseDatabase.instance.ref();

class _DatabaseAddState extends State<DatabaseAdd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => createBottom(context),
        child: Icon(Icons.add),
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
    );
  }
}
