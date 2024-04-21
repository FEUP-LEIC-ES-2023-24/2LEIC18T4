import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:study_at/components/edit_profile_text_box.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final userCollection = FirebaseDatabase.instance.ref('users');

  Future<void> editField(String field) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit " + field, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.grey[900],
        content: TextField(
          autofocus: true,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Enter new $field",
            hintStyle: TextStyle(color: Colors.grey),
          ),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          TextButton(
            child: Text('Cancel', style: TextStyle(color: Colors.white)),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text('Save', style: TextStyle(color: Colors.white)),
            onPressed: () => Navigator.of(context).pop(newValue),
          ),
        ],
      ),
    );

    if (newValue.trim().length > 0) {
      await userCollection
          .child(currentUser.email!
              .replaceAll('.', '_')
              .replaceAll('@', '_')
              .replaceAll('#', '_'))
          .update({field: newValue});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: StreamBuilder<DatabaseEvent>(
          stream: FirebaseDatabase.instance
              .ref()
              .child("users")
              .child(currentUser.email!
                  .replaceAll('.', '_')
                  .replaceAll('@', '_')
                  .replaceAll('#', '_'))
              .onValue,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final userData =
                  snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
              return ListView(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Text("Edit Profile",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 40)),
                  Icon(Icons.person, size: 120),
                  Text(currentUser.email!,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                  const SizedBox(height: 30),
                  Text("Name",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
                  EditProfileTextBox(
                    text: userData['name'],
                    sectionName: 'name',
                    onPressed: () => editField('name'),
                  ),
                  const SizedBox(height: 30),
                  Text("Username",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
                  EditProfileTextBox(
                    text: userData['username'],
                    sectionName: 'username',
                    onPressed: () => editField('username'),
                  ),
                  const SizedBox(height: 30),
                  Text("Biography",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
                  EditProfileTextBox(
                    text: userData['bio'],
                    sectionName: 'bio',
                    onPressed: () => editField('bio'),
                  )
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error${snapshot.error}"),
              );
            }

            return Center(child: const CircularProgressIndicator());
          },
        ));
  }
}
