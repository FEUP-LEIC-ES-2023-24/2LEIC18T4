import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late DatabaseReference _placesRef;
  List<Map<dynamic, dynamic>> _placesList = [];

  @override
  void initState() {
    super.initState();
    /*
    _placesRef = FirebaseDatabase.instance.ref().child("places");
    _placesRef.onValue.listen((event) {
      setState(() {
        _placesList =
            List<Map<dynamic, dynamic>>.from(event.snapshot.value ?? []);
      });
    });
    */
  }

  void updateList(String value) {
    // Implement your filtering logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Search for a place to study",
              style: TextStyle(
                color: Colors.black,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                hintText: "Search ... ",
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                updateList(value);
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            /*
            Expanded(
              child: ListView.builder(
                itemCount: _placesList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_placesList[index]["name"] ?? ""),
                    subtitle: Text(_placesList[index]["type"] ?? ""),
                    // You can customize the ListTile as needed
                  );
                },
              ),
            ),
            */
          ],
        ),
      ),
    );
  }
}
