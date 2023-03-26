// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewData extends StatefulWidget {
  final Map<String, dynamic> document;
  final String id;
  const ViewData({
    Key? key,
    required this.document,
    required this.id,
  }) : super(key: key);

  @override
  State<ViewData> createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late String type;
  late String category;
  bool edit = false;

  @override
  void initState() {
    super.initState();
    String title = widget.document["title"] == null
        ? "Hey there!"
        : widget.document["title"];
    _titleController = TextEditingController(text: title);
    _descriptionController =
        TextEditingController(text: widget.document["description"]);
    type = widget.document["task"];
    category = widget.document["category"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.purple, Colors.blue])),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(CupertinoIcons.arrow_left),
                    iconSize: 32,
                    color: Colors.white,
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection("ToDo")
                              .doc(widget.id)
                              .delete()
                              .then((value) {
                            Navigator.pop(context);
                          });
                        },
                        icon: Icon(Icons.delete),
                        iconSize: 32,
                        color: Colors.white,
                      ),
                      IconButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection("ToDo")
                              .doc(widget.id)
                              .update({
                            "title": _titleController.text,
                            "task": type,
                            "category": category,
                            "description": _descriptionController.text
                          });
                        },
                        icon: Icon(Icons.edit),
                        iconSize: 32,
                        color: edit ? Colors.purple : Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      edit ? "Editing" : "View",
                      style: GoogleFonts.arvo(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Your To Do",
                      style: GoogleFonts.arvo(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    label("Task Title"),
                    SizedBox(
                      height: 12,
                    ),
                    title(),
                    SizedBox(
                      height: 20,
                    ),
                    label("Task Type"),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        taskSelect("Important", 0xffff6d6e),
                        SizedBox(
                          width: 10,
                        ),
                        taskSelect("Planned", 0xff2bc8d9),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    label("Description"),
                    SizedBox(
                      height: 12,
                    ),
                    description(),
                    SizedBox(
                      height: 20,
                    ),
                    label("Category"),
                    SizedBox(
                      height: 12,
                    ),
                    Wrap(
                      runSpacing: 8,
                      children: [
                        categorySelect("Food", 0xffff6d00),
                        SizedBox(
                          width: 10,
                        ),
                        categorySelect("Workout", 0xff29732),
                        SizedBox(
                          width: 10,
                        ),
                        categorySelect("Work", 0xff6557ff),
                        SizedBox(
                          width: 10,
                        ),
                        categorySelect("Design", 0xff234ebd),
                        SizedBox(
                          width: 10,
                        ),
                        categorySelect("Run", 0xff2bc8d9),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    edit ? button() : Container(),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget button() {
    return InkWell(
      onTap: () {
        FirebaseFirestore.instance.collection("ToDo").doc(widget.id).update({
          "title": _titleController.text,
          "task": type,
          "category": category,
          "description": _descriptionController.text
        });
        Navigator.pop(context);
      },
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white60),
        child: Center(
            child: Text(
          "Update To Do",
          style: GoogleFonts.arvo(fontSize: 18),
        )),
      ),
    );
  }

  Widget description() {
    return Container(
      height: 120,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white60, borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10),
        child: TextFormField(
          enabled: edit,
          controller: _descriptionController,
          style: GoogleFonts.arvo(color: Colors.black, fontSize: 17),
          maxLines: null,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Description",
              hintStyle: GoogleFonts.arvo(color: Colors.black, fontSize: 17)),
        ),
      ),
    );
  }

  Widget taskSelect(String label, int color) {
    return InkWell(
      onTap: edit
          ? () {
              setState(() {
                type = label;
              });
            }
          : null,
      child: Chip(
        backgroundColor: type == label ? Colors.black : Color(color),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        label: Text(
          label,
          style: GoogleFonts.arvo(
              color: type == label ? Colors.white : Colors.black,
              fontSize: 17,
              fontWeight: FontWeight.w500),
        ),
        labelPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      ),
    );
  }

  Widget categorySelect(String label, int color) {
    return InkWell(
      onTap: edit
          ? () {
              setState(() {
                category = label;
              });
            }
          : null,
      child: Chip(
        backgroundColor: category == label ? Colors.black : Color(color),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        label: Text(
          label,
          style: GoogleFonts.arvo(
              color: category == label ? Colors.white : Colors.black,
              fontSize: 17,
              fontWeight: FontWeight.w500),
        ),
        labelPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      ),
    );
  }

  Widget title() {
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white60, borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10),
        child: TextFormField(
          controller: _titleController,
          enabled: edit,
          style: GoogleFonts.arvo(color: Colors.black, fontSize: 17),
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Task Title",
              hintStyle: GoogleFonts.arvo(color: Colors.black, fontSize: 17)),
        ),
      ),
    );
  }

  Widget label(String label) {
    return Text(
      label,
      style: GoogleFonts.arvo(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }
}
