import 'package:flutter/material.dart';

void createMarkerPopup(BuildContext context, name, imageLink) {
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
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    imageLink,
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                
                ),
              )
            ],
          ),
        );
      });
}