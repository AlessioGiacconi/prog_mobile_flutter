import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:prog_mobile_flutter/auth/login.dart';
import 'package:prog_mobile_flutter/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../screens/home.dart';
import '../utils/color_utils.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _nomeTextController = TextEditingController();
  final TextEditingController _cognomeTextController = TextEditingController();
  final TextEditingController _telefonoTextController = TextEditingController();
  final TextEditingController _dataNascitaTextController =
      TextEditingController();
  TextEditingController _ruoloTextController = TextEditingController();
  TextEditingController _sessoTextController = TextEditingController();

  String? selectedValue;
  var ruoli = ['Attaccante', 'Difensore', 'Portiere'];
  var sesso = ['Maschio', 'Femmina'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          elevation: 0,
          title: const Text(
            "Registrati",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              hexStringToColor("#9FCF72"),
              hexStringToColor("#EAFFDD")
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 120, 20, 40),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20)),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: logoWidget("assets/images/meetkick-logo.png")),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DefaultTextStyle.merge(
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'McLaren'),
                      child: const Center(
                        child: Text(
                          "Effettua la registrazione per entrare su Meet&Kick",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    textfieldWidget("Inserisci Nome", false,
                        _nomeTextController, Icons.person_outline),
                    const SizedBox(
                      height: 20,
                    ),
                    textfieldWidget("Inserisci Cognome", false,
                        _cognomeTextController, Icons.person_outline),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: _telefonoTextController,
                      cursorColor: Colors.black,
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.8),
                          fontFamily: "McLaren"),
                      decoration: InputDecoration(
                        prefixIconConstraints:
                            const BoxConstraints(minWidth: 50),
                        prefixIcon: const Icon(
                          Icons.phone,
                          color: Colors.black87,
                        ),
                        labelText: "Inserisci Telefono",
                        labelStyle: TextStyle(
                            color: Colors.black.withOpacity(0.8),
                            fontFamily: "McLaren"),
                        filled: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        fillColor: Colors.white.withOpacity(0.8),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(
                                width: 0, style: BorderStyle.none)),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Form(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DropdownButtonFormField(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.8),
                                isDense: true,
                                contentPadding: const EdgeInsets.all(15),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                        width: 0, style: BorderStyle.none)),
                              ),
                              isExpanded: true,
                              hint: Text(
                                'Seleziona Ruolo',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'McLaren',
                                    color: Colors.black.withOpacity(0.8)),
                              ),
                              items: ruoli
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontFamily: "McLaren"),
                                        ),
                                      ))
                                  .toList(),
                              validator: (value) {
                                if (value == null) {
                                  return 'Seleziona Ruolo';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  selectedValue = value;
                                  _ruoloTextController.text = value!;
                                });
                              },
                              onSaved: (value) {
                                selectedValue = value.toString();
                                _ruoloTextController.text = value!;
                              },
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black45,
                              ),
                              iconSize: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Form(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DropdownButtonFormField(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.8),
                                isDense: true,
                                contentPadding: const EdgeInsets.all(15),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                        width: 0, style: BorderStyle.none)),
                              ),
                              isExpanded: true,
                              hint: Text(
                                'Seleziona Sesso',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'McLaren',
                                    color: Colors.black.withOpacity(0.8)),
                              ),
                              items: sesso
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontFamily: "McLaren"),
                                        ),
                                      ))
                                  .toList(),
                              validator: (value) {
                                if (value == null) {
                                  return 'Seleziona Sesso';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  selectedValue = value;
                                  _sessoTextController.text = value!;
                                });
                              },
                              onSaved: (value) {
                                selectedValue = value.toString();
                                _sessoTextController.text = value!;
                              },
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black45,
                              ),
                              iconSize: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      showCursor: true,
                      readOnly: true,
                      controller: _dataNascitaTextController,
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.8),
                          fontFamily: "McLaren"),
                      decoration: InputDecoration(
                        prefixIconConstraints:
                            const BoxConstraints(minWidth: 50),
                        prefixIcon: const Icon(
                          Icons.calendar_today_rounded,
                          color: Colors.black87,
                        ),
                        labelText: 'Seleziona Data di Nascita',
                        labelStyle: TextStyle(
                            color: Colors.black.withOpacity(0.8),
                            fontFamily: "McLaren"),
                        filled: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        fillColor: Colors.white.withOpacity(0.8),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(
                                width: 0, style: BorderStyle.none)),
                      ),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime(2101));

                        if (pickedDate != null) {
                          setState(() {
                            _dataNascitaTextController.text =
                                DateFormat('dd-MM-yyyy').format(pickedDate);
                          });
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    textfieldWidget("Inserisci Email", false,
                        _emailTextController, Icons.person_outline),
                    const SizedBox(
                      height: 20,
                    ),
                    textfieldWidget("Inserisci Password", true,
                        _passwordTextController, Icons.lock_outlined),
                    const SizedBox(
                      height: 20,
                    ),
                    loginRegisterButton(context, false, () {
                      if (_nomeTextController.text.isNotEmpty &&
                          _cognomeTextController.text.isNotEmpty &&
                          _telefonoTextController.text.isNotEmpty &&
                          _ruoloTextController.text.isNotEmpty &&
                          _sessoTextController.text.isNotEmpty &&
                          _dataNascitaTextController.text.isNotEmpty &&
                          _emailTextController.text.isNotEmpty &&
                          _passwordTextController.text.isNotEmpty) {
                        FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: _emailTextController.text,
                                password: _passwordTextController.text)
                            .then((value) {
                          Map<String, String> userData = {
                            'Nome': _nomeTextController.text,
                            'Cognome': _cognomeTextController.text,
                            'Telefono': _telefonoTextController.text,
                            'Ruolo': _ruoloTextController.text,
                            'Sesso': _sessoTextController.text,
                            'Data di Nascita': _dataNascitaTextController.text,
                            'Email': _emailTextController.text,
                            'Password': _passwordTextController.text
                          };
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(_emailTextController.text)
                              .set(userData)
                              .then((value) => print("User added"))
                              .onError((error, stackTrace) =>
                                  Fluttertoast.showToast(
                                      msg: error.toString(),
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      backgroundColor: Colors.green,
                                      textColor: Colors.black87,
                                      fontSize: 16));

                          Fluttertoast.showToast(
                              msg: "Nuovo account registrato, bevenuto!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              backgroundColor: Colors.green,
                              textColor: Colors.black87,
                              fontSize: 16);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()));
                        }).onError((error, stackTrace) {
                          Fluttertoast.showToast(
                              msg: error.toString(),
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              backgroundColor: Colors.green,
                              textColor: Colors.black87,
                              fontSize: 16);
                        });
                      } else {
                        Fluttertoast.showToast(
                            msg: "Assicurati di aver compilato tutti i campi",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: Colors.green,
                            textColor: Colors.black87,
                            fontSize: 16);
                      }
                    }),
                    const SizedBox(
                      height: 5,
                    ),
                    loginOption(),
                  ],
                ),
              ),
            )));
  }

  Row loginOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Hai già un account? Effettua il",
            style: TextStyle(
                color: Colors.black87, fontFamily: "McLaren", fontSize: 16)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginScreen()));
          },
          child: const Text(
            " Login",
            style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
                fontFamily: "McLaren",
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
