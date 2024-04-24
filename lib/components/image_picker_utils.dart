import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";

pickImage(ImageSource source) async {
  final ImagePicker imgpicker = ImagePicker();
  XFile? imgfile = await imgpicker.pickImage(source: source);
  if (imgfile != null) {
    return await imgfile.readAsBytes();
  }
  // control
  print('no image selected - check logs');
}
