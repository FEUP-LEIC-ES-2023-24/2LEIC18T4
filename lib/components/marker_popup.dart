import 'package:flutter/material.dart';
import 'package:study_at/pages/landing_page.dart';
import 'package:study_at/pages/place_page.dart';

void createMarkerPopup(BuildContext context, name, imageLink, markerTags) {
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
                child: Text(name,
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.w800)),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PlacePage(imagelink: imageLink, name: name, markerTags: markerTags)),
                  );
                },
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      imageLink,
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      });
}