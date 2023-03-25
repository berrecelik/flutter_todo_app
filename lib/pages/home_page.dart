import 'package:flutter/material.dart';
import 'package:flutter_todo_app/Custom/todo_card.dart';
import 'package:flutter_todo_app/pages/add_todo.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "Today's Schedule",
          style: GoogleFonts.arvo(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
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
                  "Saturday 25",
                  style: GoogleFonts.arvo(
                      color: Colors.white,
                      fontSize: 33,
                      fontWeight: FontWeight.w500),
                ),
              ),
            )),
      ),
      bottomNavigationBar:
          BottomNavigationBar(backgroundColor: Colors.black, items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            size: 25,
            color: Colors.white,
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
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            children: [
              ToDoCard(
                title: "Wake up!",
                check: true,
                iconBgColor: Colors.white,
                iconColor: Colors.red,
                iconData: Icons.alarm,
                time: "10 AM",
              ),
              SizedBox(
                height: 10,
              ),
              ToDoCard(
                title: "Gym!",
                check: false,
                iconBgColor: Color(0xff2cc8d9),
                iconColor: Colors.white,
                iconData: Icons.run_circle,
                time: "11 AM",
              ),
              SizedBox(
                height: 10,
              ),
              ToDoCard(
                title: "Buy some food",
                check: false,
                iconBgColor: Color(0xfff19733),
                iconColor: Colors.white,
                iconData: Icons.local_grocery_store,
                time: "1 PM",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
