import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

void signIn() async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: "deneme@gmail.com", password: "password123");
  } catch (e) {
    print(e);
  }
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
            Icon(Icons.android, size: 100),
            SizedBox(
              height: 20,
            ),
            Text(
              "Hello There!",
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
                    child: Text(
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
                Text("Sign Up",
                    style: GoogleFonts.arvo(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text("Forgot password?",
                style: GoogleFonts.arvo(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ))
          ],
        ),
      )),
    );
  }
}
