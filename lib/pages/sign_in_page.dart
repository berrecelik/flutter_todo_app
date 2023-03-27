import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/pages/sign_up_page.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool circular = false;
  Future signIn() async {
    setState(() {
      circular = true;
    });
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim());
      print(userCredential.user!.email);
      setState(() {
        circular = false;
      });
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (builder) => HomePage()),
          (route) => false);
    } catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {
        circular = false;
      });
      print(e);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "TO DO APP",
                  style: GoogleFonts.arvo(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple[800]),
                ),
                Icon(Icons.edit_attributes_outlined,
                    color: Colors.purple[800], size: 50),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Icon(Icons.android, size: 100),
            SizedBox(
              height: 10,
            ),
            Text(
              "Hello there!",
              style:
                  GoogleFonts.arvo(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(15)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.deepPurple)),
                    hintText: "Email",
                    fillColor: Colors.grey[200],
                    filled: true),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(15)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.deepPurple)),
                    hintText: "Password",
                    fillColor: Colors.grey[200],
                    filled: true),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: GestureDetector(
                onTap: signIn,
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple[200],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: circular
                        ? CircularProgressIndicator()
                        : Text(
                            "Sign in",
                            style: GoogleFonts.arvo(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("If you don't have an account ",
                    style: GoogleFonts.arvo(
                        fontSize: 18, fontWeight: FontWeight.w600)),
                InkWell(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (builder) => SignUpPage()),
                        (route) => false);
                  },
                  child: Text("Sign Up",
                      style: GoogleFonts.arvo(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue)),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      )),
    );
  }
}
