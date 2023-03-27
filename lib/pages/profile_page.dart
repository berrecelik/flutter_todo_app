import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/pages/sign_up_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final user = FirebaseAuth.instance.currentUser!;

  final ImagePicker _picker = ImagePicker();
  XFile? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(CupertinoIcons.arrow_left),
                  iconSize: 32,
                  color: Colors.white,
                ),
              ],
            ),
            SizedBox(
              height: 60,
            ),
            CircleAvatar(
              radius: 75,
              backgroundImage: getImage(),
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                button(),
                IconButton(
                    onPressed: () async {
                      image =
                          await _picker.pickImage(source: ImageSource.camera);
                      setState(() {
                        image = image;
                      });
                    },
                    icon: Icon(
                      Icons.add_a_photo,
                      color: Colors.teal,
                      size: 30,
                    ))
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Signed in as : " + user.email!,
                    style: GoogleFonts.arvo(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  ImageProvider getImage() {
    if (image != null) {
      return FileImage(File(image!.path));
    }
    return AssetImage("assets/profile.jpg");
  }

  Widget button() {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 45,
        width: MediaQuery.of(context).size.width / 3,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white60),
        child: Center(
            child: Text(
          "Upload",
          style: GoogleFonts.arvo(fontSize: 18, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}
