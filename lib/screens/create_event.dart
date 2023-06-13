import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:prog_mobile_flutter/widgets/widgets.dart';

import '../utils/color_utils.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  var creatore = FirebaseAuth.instance.currentUser!.email;

  final TextEditingController _titoloTextController = TextEditingController();
  final TextEditingController _dataTextController = TextEditingController();
  final TextEditingController _oraTextController = TextEditingController();
  final TextEditingController _luogoTextController = TextEditingController();
  final TextEditingController _ruoliTextController = TextEditingController();
  double _currentSliderValue = 1;
  final TextEditingController _descrizioneTextController = TextEditingController();

  void _showMultiSelect() async {
    final List<String> ruoli = ['Attaccante', 'Difensore', 'Portiere'];

    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(items: ruoli);
      },
    );

    if (results != null) {
      setState(() {
        _ruoliTextController.text = results.join(', ');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: hexStringToColor('#9FCF72'),
          elevation: 0,
          title: Text(
            "Creazione evento",
            style: TextStyle(
                color: hexStringToColor('#288510'),
                fontSize: 24,
                fontWeight: FontWeight.bold),
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
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 40),
              child: Column(
                children: <Widget>[
                  DefaultTextStyle.merge(
                    style: const TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'McLaren'),
                    child: const Center(
                      child: Text(
                        "Crea il tuo evento",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  createEventTextFieldWidget(
                      'Inserisci un Titolo per l\'Evento',
                      _titoloTextController,
                      Icons.title),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    showCursor: true,
                    readOnly: true,
                    controller: _dataTextController,
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.8),
                        fontFamily: "McLaren"),
                    decoration: InputDecoration(
                      prefixIconConstraints: const BoxConstraints(minWidth: 50),
                      prefixIcon: const Icon(
                        Icons.calendar_today_rounded,
                        color: Colors.black87,
                      ),
                      labelText: 'Seleziona Data dell\'Evento',
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
                          _dataTextController.text =
                              DateFormat('dd-MM-yyyy').format(pickedDate);
                        });
                      }
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    showCursor: true,
                    readOnly: true,
                    controller: _oraTextController,
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.8),
                        fontFamily: "McLaren"),
                    decoration: InputDecoration(
                      prefixIconConstraints: const BoxConstraints(minWidth: 50),
                      prefixIcon: const Icon(
                        Icons.access_time_outlined,
                        color: Colors.black87,
                      ),
                      labelText: 'Seleziona Ora dell\'Evento',
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
                      TimeOfDay? pickedTime = await showTimePicker(
                          context: context, initialTime: TimeOfDay.now());
                      if (pickedTime != null) {
                        setState(() {
                          _oraTextController.text = pickedTime.format(context);
                          print(_oraTextController.text);
                        });
                      }
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  createEventTextFieldWidget('Inserisci il Luogo delll\'Evento',
                      _luogoTextController, Icons.place),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    showCursor: true,
                    readOnly: true,
                    controller: _ruoliTextController,
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.8),
                        fontFamily: "McLaren"),
                    decoration: InputDecoration(
                      prefixIconConstraints: const BoxConstraints(minWidth: 50),
                      prefixIcon: const Icon(
                        Icons.accessibility_new_outlined,
                        color: Colors.black87,
                      ),
                      labelText: 'Seleziona i Ruoli di Interesse',
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
                    onTap: _showMultiSelect,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Form(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(3, 7, 3, 3),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                      'Seleziona il numero di persone che cerchi',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontFamily: "McLaren")),
                                  Slider(
                                    value: _currentSliderValue,
                                    onChanged: (newValue) {
                                      setState(() {
                                        _currentSliderValue = newValue;
                                      });
                                    },
                                    min: 1,
                                    max: 9,
                                    divisions: 8,
                                    label: '$_currentSliderValue',
                                    activeColor: hexStringToColor('#9FCF72'),
                                  ),
                                ],
                              ))),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  IntrinsicHeight(
                    child: TextField(
                      controller: _descrizioneTextController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      autocorrect: true,
                      enableSuggestions: true,
                      cursorColor: Colors.black,
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.8),
                          fontFamily: "McLaren"),
                      decoration: InputDecoration(
                        prefixIconConstraints:
                            const BoxConstraints(minWidth: 50),
                        prefixIcon: const Icon(
                          Icons.short_text_outlined,
                          color: Colors.black87,
                        ),
                        labelText:
                            'Inserisci una Descrizione per il tuo Evento',
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
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(90)),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_titoloTextController.text.isNotEmpty &&
                            _dataTextController.text.isNotEmpty &&
                            _oraTextController.text.isNotEmpty &&
                            _luogoTextController.text.isNotEmpty &&
                            _ruoliTextController.text.isNotEmpty &&
                            _descrizioneTextController.text.isNotEmpty) {
                          Map<String, dynamic> eventData = {
                            'Creatore': creatore,
                            'Titolo': _titoloTextController.text,
                            'Data': _dataTextController.text,
                            'Ora': _oraTextController.text,
                            'Luogo': _luogoTextController.text,
                            'Ruoli Richiesti': _ruoliTextController.text,
                            'N° Persone': _currentSliderValue,
                            'Descrizione': _descrizioneTextController.text
                          };
                          FirebaseFirestore.instance
                              .collection('events')
                              .doc(_titoloTextController.text)
                              .set(eventData)
                              .then((value) => Fluttertoast.showToast(
                                  msg: "Nuovo evento registrato",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.black87,
                                  fontSize: 16))
                              .onError((error, stackTrace) =>
                                  Fluttertoast.showToast(
                                      msg: error.toString(),
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      backgroundColor: Colors.green,
                                      textColor: Colors.black87,
                                      fontSize: 16));
                          Navigator.pop(context);
                        } else {
                          Fluttertoast.showToast(
                              msg: "Assicurati di aver compilato tutti i campi",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              backgroundColor: Colors.green,
                              textColor: Colors.black87,
                              fontSize: 16);
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith((states) {
                            if (states.contains(MaterialState.pressed)) {
                              return hexStringToColor('#288510');
                            }
                            return hexStringToColor('#1ECA00');
                          }),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30)))),
                      child: const Text(
                        'CONFERMA',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: "McLaren",
                            fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
