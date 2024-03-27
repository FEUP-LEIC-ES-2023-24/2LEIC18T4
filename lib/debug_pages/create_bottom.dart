import 'package:flutter/material.dart';
import 'package:study_at/debug_pages/database_add.dart';

final TextEditingController nameController = TextEditingController();
final TextEditingController latitudeController = TextEditingController();
final TextEditingController longitudeController = TextEditingController();
final TextEditingController imagelinkController = TextEditingController();

void createBottom(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text("Create a location",
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.w800)),
              ),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Location name",
                  hintText: "eg. Biblioteca FEUP",
                ),
              ),
              TextField(
                controller: latitudeController,
                decoration: InputDecoration(
                    labelText: "Location latitude", hintText: "Coordinates"),
              ),
              TextField(
                controller: longitudeController,
                decoration: InputDecoration(
                    labelText: "Location longitude", hintText: "Coordinates"),
              ),
              TextField(
                controller: imagelinkController,
                decoration: InputDecoration(
                    labelText: "Image link",
                    hintText: "Insert a valid link to an image"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final id = DateTime.now().microsecond.toString();
                  databaseReference.child(id).set({
                    'name': nameController.text.toString(),
                    'latitude': latitudeController.text.toString(),
                    'longitude': longitudeController.text.toString(),
                    'imageLink': imagelinkController.text.toString(),
                    'id': id // unique id everytime - based on unix
                  });
                },
                child: Text('Add location'),
                style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black)),
              )
            ],
          ),
        );
      });
}
