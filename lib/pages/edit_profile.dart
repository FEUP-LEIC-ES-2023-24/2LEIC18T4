import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:study_at/components/edit_profile_text_box.dart';
import 'package:study_at/components/image_picker_utils.dart';
import 'package:study_at/components/store_imgdata.dart';

class Faculty {
  final String name;
  final int color;

  Faculty({required this.name, required this.color});
}

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final userCollection = FirebaseDatabase.instance.ref('users');
  String selectedFacultyName = "Other";
  int selectedFacultyColor = Colors.black.value;
  late List<Faculty> facultyList = [];

  Uint8List? image;

  @override
  void initState() {
    super.initState();
    facultyList = [
      // não tem todas, falta faculdades com 2 cores
      Faculty(name: "FAUP", color: Colors.grey.value),
      Faculty(name: "FFUP", color: Color.fromRGBO(110, 32, 160, 100).value),
      Faculty(name: "FDUP", color: Color.fromRGBO(244, 42, 65, 100).value),
      Faculty(name: "FBAUP", color: Color.fromRGBO(178, 179, 181, 100).value),
      Faculty(name: "FADEUP", color: Color.fromRGBO(198, 219, 0, 100).value),
      Faculty(name: "FPCEUP", color: Color.fromRGBO(255, 92, 0, 100).value),
      Faculty(name: "FCUP", color: Color.fromRGBO(147, 191, 235, 100).value),
      Faculty(name: "FEUP", color: Color.fromRGBO(159, 45, 32, 100).value),
      Faculty(name: "FMUP", color: Color.fromRGBO(255, 214, 0, 100).value),
      Faculty(name: "FLUP", color: Color.fromRGBO(0, 25, 168, 100).value),
      // FCNAUP, FEP, FMDUP, ICBAS
    ];

    if (!facultyList.any((faculty) => faculty.name == "Other")) {
      facultyList.add(Faculty(name: "Other", color: Colors.black.value));
    }
  }

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

  Color colorConvert(int argbVal) {
    int red = (argbVal >> 16) & 0xFF;
    int green = (argbVal >> 8) & 0xFF;
    int blue = argbVal & 0xFF;

    return Color.fromRGBO(red, green, blue, 1.0);
  }

  Future<void> updateFaculty(String facultyName) async {
    Faculty selectedFac =
        facultyList.firstWhere((faculty) => faculty.name == facultyName);

    await userCollection
        .child(currentUser.email!
            .replaceAll('.', '_')
            .replaceAll('@', '_')
            .replaceAll('#', '_'))
        .update({
      'faculty': {'name': selectedFac.name, 'color': selectedFac.color}
    });
  }

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      image = img;
    });
  }

  void saveImage() async {
    await StoreData().storeImageToUser(image!);
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
                  // Icon(Icons.person, size: 120),

                  Stack(alignment: Alignment.center, children: [
                    image != null
                        ? CircleAvatar(
                            radius: 60,
                            backgroundImage: MemoryImage(image!),
                          )
                        : CircleAvatar(
                            radius: 60,
                            backgroundImage:
                                NetworkImage(userData['profileImage']),
                          ),
                    Positioned(
                      bottom: -10,
                      right: 140,
                      child: GestureDetector(
                        onTap: saveImage,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Icon(Icons.save),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -10,
                      right: 215,
                      child: GestureDetector(
                        onTap: selectImage,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Icon(Icons.add_a_photo),
                        ),
                      ),
                    ),
                  ]),

                  const SizedBox(
                    height: 10,
                  ),

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
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text("Faculty",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: DropdownButtonFormField<String>(
                        value: userData['faculty']['name'],
                        items: facultyList.map((faculty) {
                          return DropdownMenuItem(
                              value: faculty.name,
                              child: Row(
                                children: [
                                  Icon(Icons.school,
                                      color: colorConvert(faculty.color)),
                                  SizedBox(width: 10),
                                  Text(faculty.name)
                                ],
                              ));
                        }).toList(),
                        onChanged: (String? value) {
                          if (value != null) {
                            Faculty selectedFaculty = facultyList
                                .firstWhere((faculty) => faculty.name == value);
                            setState(() {
                              selectedFacultyName = selectedFaculty.name;
                              selectedFacultyColor = selectedFaculty.color;
                            });

                            updateFaculty(selectedFaculty.name);
                          }
                        }),
                  ),
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
