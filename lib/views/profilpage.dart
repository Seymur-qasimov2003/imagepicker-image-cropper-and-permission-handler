import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  var picker = ImagePicker();
  File? imageFile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: double.infinity, height: 30),
          CircleAvatar(
            radius: 100,
            backgroundImage: imageFile == null
                ? AssetImage("assets/images/loginImage.jpg")
                : Image.file(imageFile!).image,
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () async {
              Map<Permission, PermissionStatus> statues = await [
                Permission.camera,
                Permission.storage,
              ].request();
              // if (statues[Permission.camera]!.isGranted &&
              //     statues[Permission.storage]!.isGranted) {
              //   showModalBottomSheet(
              //     context: context,
              //     builder: _buildBottomSheet,
              //   );
              // } else {
              //   ScaffoldMessenger.of(context).showSnackBar(
              //     SnackBar(
              //       content: Text("Permission Denied"),
              //     ),
              //   );
              // }
              showModalBottomSheet(
                context: context,
                builder: _buildBottomSheet,
              );
            },
            child: Text("Upload Image"),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Upload Image",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  imageFromCamera();
                  Navigator.pop(context);
                },
                child: Text("Camera"),
              ),
              ElevatedButton(
                onPressed: () {
                  galleryFromCamera();
                  Navigator.pop(context);
                },
                child: Text("Gallery"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  imageFromCamera() async {
    final image = await picker
        .pickImage(source: ImageSource.camera, imageQuality: 50)
        .then((value) {
      if (value != null) {
        cropImage(File(value.path));
      }
    });
  }

  galleryFromCamera() async {
    final image = await picker
        .pickImage(source: ImageSource.gallery, imageQuality: 50)
        .then((value) {
      if (value != null) {
        cropImage(File(value.path));
      }
    });
  }

  cropImage(File imgFile) async {
    final croppedImage = await ImageCropper().cropImage(
      sourcePath: imgFile.path,
      aspectRatioPresets: Platform.isAndroid
          ? [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9,
            ]
          : [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio5x3,
              CropAspectRatioPreset.ratio5x4,
              CropAspectRatioPreset.ratio7x5,
              CropAspectRatioPreset.ratio16x9
            ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );
    if (croppedImage != null) {
      imageCache!.clear();
      setState(() {
        imageFile = File(croppedImage.path);
      });
    }
  }
}
