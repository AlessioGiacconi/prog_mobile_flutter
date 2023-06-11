import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prog_mobile_flutter/auth/login.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text("Logout"),
          onPressed: () {
            print("Logout effettuato");
            FirebaseAuth.instance.signOut().then((value){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
            });
          },
        ),
      ),
    );
  }
}
