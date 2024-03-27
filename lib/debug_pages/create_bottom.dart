import 'package:flutter/material.dart';
import 'package:study_at/debug_pages/database_page.dart';

final TextEditingController nameController = TextEditingController();
final TextEditingController latitudeController = TextEditingController();
final TextEditingController longitudeController = TextEditingController();
final TextEditingController imagelinkController = TextEditingController();

const List<String> list = <String>['Café', 'Library', 'Hotel lobby'];
String dropdownValue = list.first;

void createBottom(BuildContext context) {
  showModalBottomSheet(
      isScrollControlled: true,
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
              Align(alignment: Alignment.centerLeft, child: DropdownWidget()),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final id = DateTime.now().microsecond.toString();
                  databaseReference.child(id).set({
                    'name': nameController.text.toString(),
                    'latitude': latitudeController.text.toString(),
                    'longitude': longitudeController.text.toString(),
                    'imageLink': imagelinkController.text.toString(),
                    'type': dropdownValue, // Corresponding element,
                    'id': id // unique id everytime - based on unix
                  });

                  nameController.clear();
                  latitudeController.clear();
                  longitudeController.clear();
                  imagelinkController.clear();
                  Navigator.pop(context);
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

class DropdownWidget extends StatefulWidget {
  @override
  _DropdownWidgetState createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  @override
  void initState() {
    super.initState();
    dropdownValue = list.first;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: List<DropdownMenuItem<String>>.generate(
        list.length,
        (int index) => DropdownMenuItem<String>(
          value: list[index],
          child: Text(list[index]),
        ),
      ),
    );
  }
}
