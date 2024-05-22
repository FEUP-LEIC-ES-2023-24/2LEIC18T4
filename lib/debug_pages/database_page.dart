import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:study_at/debug_pages/create_bottom.dart';
import 'package:study_at/debug_pages/update_bottom.dart';

final Map<String, IconData> typeIcon = {
  'Café': Icons.local_cafe,
  'Library': Icons.library_books,
  'Hotel lobby': Icons.hotel,
};

class DatabasePage extends StatefulWidget {
  const DatabasePage({super.key});

  @override
  State<DatabasePage> createState() => _DatabasePageState();
}

final databaseReference = FirebaseDatabase.instance.ref("places");

class _DatabasePageState extends State<DatabasePage> {
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    if (currentUser != null) {
      DatabaseReference userRef = databaseReference.child(currentUser!.email!.replaceAll('.', '_').replaceAll('@', '_').replaceAll('#', '_'));
      userRef.once().then((event) {
        DataSnapshot snapshot = event.snapshot;
        Map<dynamic, dynamic>? userData =
            snapshot.value as Map<dynamic, dynamic>?;

        if (userData != null) {
          if (userData['admin'] == true) {
            return Scaffold(
              resizeToAvoidBottomInset: true,
              body: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 15.0, bottom: 1.0, top: 25.0),
                      child: Text(
                        "Database",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 17.0, bottom: 1.0, top: 1.0),
                      child: Text(
                        "You can add, update or remove elements.",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: FirebaseAnimatedList(
                        query: databaseReference,
                        itemBuilder: (context, snapshot, index, animation) {
                          String type = snapshot.child("type").value.toString();
                          IconData? iconData = typeIcon.containsKey(type)
                              ? typeIcon[type]
                              : Icons.place;
                          return ListTile(
                            title: Text(snapshot.child("name").value.toString()),
                            subtitle: Text(
                                snapshot.child("latitude").value.toString() +
                                    ", " +
                                    snapshot.child("longitude").value.toString()),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  snapshot.child("imageLink").value.toString()),
                              radius: 30,
                            ),
                            trailing: PopupMenuButton(
                              icon: Icon(iconData),
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  value: 1,
                                  child: ListTile(title: Text(type)),
                                ),
                                PopupMenuItem(
                                  value: 2,
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.pop(context);
                                      updateBottom(
                                          context,
                                          snapshot.child("name").value.toString(),
                                          snapshot.child("latitude").value.toString(),
                                          snapshot
                                              .child("longitude")
                                              .value
                                              .toString(),
                                          snapshot
                                              .child("imageLink")
                                              .value
                                              .toString(),
                                          snapshot.child("type").value.toString(),
                                          snapshot.child("id").value.toString());
                                    },
                                    leading: const Icon(Icons.edit),
                                    title: const Text("Edit"),
                                  ),
                                ),
                                PopupMenuItem(
                                  value: 3,
                                  child: ListTile(
                                    onTap: () {
                                      databaseReference
                                          .child(
                                              snapshot.child('id').value.toString())
                                          .remove();
                                    },
                                    leading: const Icon(Icons.delete),
                                    title: const Text("Delete"),
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                  )
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () => createBottom(context),
                child: Icon(Icons.add),
                foregroundColor: Colors.white,
                backgroundColor: Colors.black,
              ),
            );
          } else {
            return Scaffold(
              backgroundColor: Colors.white60,
              body: Center(
                child: Text("You must be an admin to access this page."),
              ),
            );
          }
        }
      });
    }

    return Scaffold(
      backgroundColor: Colors.white60,
      body: Center(
        child: Text("You must be logged in to access this page."),
      ),
    );
  }
}
