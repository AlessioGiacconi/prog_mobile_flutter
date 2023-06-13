import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/color_utils.dart';
import '../widgets/widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userEmail = FirebaseAuth.instance.currentUser!.email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: hexStringToColor('#9FCF72'),
        elevation: 0,
        title: const Text(
          "Il tuo profilo",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexStringToColor("#9FCF72"),
          hexStringToColor("#EAFFDD")
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 30),
            child: Column(
              children: <Widget>[
                DefaultTextStyle.merge(
                  style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'McLaren'),
                  child: const Center(
                    child: Text("ECCO LE TUE INFORMAZIONI"),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                profileTextView('Nome', userEmail!),
                const SizedBox(
                  height: 30,
                ),
                profileTextView('Cognome', userEmail!),
                const SizedBox(
                  height: 30,
                ),
                profileTextView('Telefono', userEmail!),
                const SizedBox(
                  height: 30,
                ),
                profileTextView('Ruolo', userEmail!),
                const SizedBox(
                  height: 30,
                ),
                profileTextView('Sesso', userEmail!),
                const SizedBox(
                  height: 30,
                ),
                profileTextView('Data di Nascita', userEmail!),
                const SizedBox(
                  height: 30,
                ),
                profileTextView('Email', userEmail!),
                const SizedBox(
                  height: 30,
                ),
                profileTextView('Password', userEmail!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
