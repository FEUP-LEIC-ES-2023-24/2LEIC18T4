import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  void updateList(String value){
    // filter for the los
  }
  @override
  Widget build (BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFFFF),
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Search for a place to study", 
            style: TextStyle(
              color: Colors.white, 
              fontSize: 22.0, 
              fontWeight: FontWeight.bold,
              ) ,
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0x00000000),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                hintText: "eg: Biblioteca da FEUP ",
                prefixIcon: Icon(Icons.search),
                prefixIconColor: Color (0x0000000000),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Expanded(child: ListView(),
              ),
            ],
        ),
      ),
    );
  }
}

