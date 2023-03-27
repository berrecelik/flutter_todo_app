// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/pages/profile_page.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_todo_app/Custom/todo_card.dart';
import 'package:flutter_todo_app/pages/add_todo.dart';
import 'package:flutter_todo_app/pages/view_data.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Stream<QuerySnapshot> _stream =
      FirebaseFirestore.instance.collection("ToDo").snapshots();
  //source of stream
  List<Select> selected = [];

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEE d MMM').format(now);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Text(
            "Today's Schedule",
            style: GoogleFonts.arvo(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.black,
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/profile.jpg"),
          ),
          SizedBox(
            width: 25,
          ),
        ],
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(35),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  formattedDate,
                  style: GoogleFonts.arvo(
                      color: Colors.blueAccent,
                      fontSize: 33,
                      fontWeight: FontWeight.w500),
                ),
              ),
            )),
      ),
      bottomNavigationBar:
          BottomNavigationBar(backgroundColor: Colors.black, items: [
        BottomNavigationBarItem(
          icon: InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (builder) => Profile()));
            },
            child: Icon(
              Icons.home,
              size: 25,
              color: Colors.white,
            ),
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => AddToDoPage()));
            },
            child: Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xff03a1e9), Color(0xffdf9fea)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )),
              child: Icon(
                Icons.add,
                size: 25,
                color: Colors.white,
              ),
            ),
          ),
          label: 'Add',
        ),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              size: 25,
              color: Colors.white,
            ),
            label: 'Settings'),
      ]),
      body: StreamBuilder(
          stream: _stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  IconData iconData;
                  Color iconColor;
                  Map<String, dynamic> document =
                      snapshot.data?.docs[index].data() as Map<String, dynamic>;
                  switch (document["category"]) {
                    //accessing category
                    case "Work":
                      iconData = Icons.alarm;
                      iconColor = Colors.teal;
                      break;
                    case "Workout":
                      iconData = Icons.run_circle_outlined;
                      iconColor = Colors.red;
                      break;
                    case "Food":
                      iconData = Icons.local_grocery_store;
                      iconColor = Colors.blue;
                      break;
                    case "Design":
                      iconData = Icons.design_services;
                      iconColor = Colors.green;
                      break;

                    default:
                      iconData = Icons.alarm;
                      iconColor = Colors.red;
                  }
                  selected.add(Select(
                      id: snapshot.data!.docs[index].id, checkValue: false));
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => ViewData(
                                  document: document,
                                  id: snapshot.data!.docs[index].id)));
                    },
                    child: ToDoCard(
                      title: document["title"] == null
                          ? "Hey there!"
                          : document["title"],
                      iconData: iconData,
                      iconColor: iconColor,
                      time: document["time"] == null
                          ? "Time!!"
                          : document["time"],
                      check: selected[index].checkValue,
                      iconBgColor: Colors.white,
                      index: index,
                      onChange: onChange,
                    ),
                  );
                });
          }),
    );
  }

  void onChange(int index) {
    setState(() {
      selected[index].checkValue = !selected[index].checkValue;
    });
  }
}

class Select {
  String id;
  bool checkValue = false;
  Select({
    required this.id,
    required this.checkValue,
  });
}
