import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prog_mobile_flutter/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/color_utils.dart';

class EventDetailsScreen extends StatefulWidget {
  const EventDetailsScreen({super.key, required this.event});

  final Map<String, dynamic> event;

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  String? nome_creatore;
  String? cognome_creatore;
  String? telefono_creatore;

  @override
  void initState() {
    super.initState();
    getInfoCreatore(widget.event['Creatore']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: hexStringToColor('#9FCF72'),
        elevation: 0,
        title: const Text(
          "Dettagli dell'Evento",
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
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
            child: Column(
              children: <Widget>[
                DefaultTextStyle.merge(
                  style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'McLaren'),
                  child: Center(
                    child: Text(widget.event['Titolo'].toUpperCase()),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white54,
                      border: Border.all(
                        color: hexStringToColor('#288510'),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
                    child: Column(
                      children: [
                        eventDetailTextView(
                            'Creato da', '$nome_creatore $cognome_creatore'),
                        const Divider(
                          height: 20,
                          color: Colors.black38,
                          indent: 20,
                          endIndent: 20,
                        ),
                        eventDetailTextView('Il giorno', widget.event['Data']),
                        const Divider(
                          height: 20,
                          color: Colors.black38,
                          indent: 20,
                          endIndent: 20,
                        ),
                        eventDetailTextView('Alle', widget.event['Ora']),
                        const Divider(
                          height: 20,
                          color: Colors.black38,
                          indent: 20,
                          endIndent: 20,
                        ),
                        eventDetailTextView('Dove', widget.event['Luogo']),
                        const Divider(
                          height: 20,
                          color: Colors.black38,
                          indent: 20,
                          endIndent: 20,
                        ),
                        eventDetailTextView(
                            'Cerchiamo', widget.event['Ruoli Richiesti']),
                        const Divider(
                          height: 20,
                          color: Colors.black38,
                          indent: 20,
                          endIndent: 20,
                        ),
                        eventDetailTextView('Ci mancano',
                            '${widget.event['N° Persone'].toInt()} giocatori'),
                        const Divider(
                          height: 20,
                          color: Colors.black38,
                          indent: 20,
                          endIndent: 20,
                        ),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const DefaultTextStyle(
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'McLaren',
                                  color: Colors.black,
                                ),
                                child: Text('Descrizione'),
                              ),
                              IntrinsicHeight(
                                  child: Container(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  child: DefaultTextStyle(
                                    textAlign: TextAlign.justify,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'McLaren',
                                      color: Colors.black,
                                    ),
                                    child: Text(widget.event['Descrizione']),
                                  ),
                                ),
                              ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () async {
                        Uri numTel = Uri.parse('tel:+39$telefono_creatore');
                        if (await launchUrl(numTel)) {
                          //dialer opened
                        } else {
                          //dailer is not opened
                        }
                      },
                      icon:
                          const Icon(Icons.phone_android_sharp, size: 25.0),
                      label: const Text(
                        'CHIAMA',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'McLaren',
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    ElevatedButton.icon(
                      onPressed: () async {
                        Uri whatsappUrl = Uri.parse(
                            "whatsapp://send?phone=$telefono_creatore&text=Ciao%2C%20ho%20visto%20il%20tuo%20annuncio%20e%20vorrei%20partecipare%21");
                        if (await launchUrl(whatsappUrl)) {
                        } else {}
                      },
                      icon: const Icon(Icons.phone_outlined, size: 25.0),
                      label: const Text(
                        'WHATSAPP',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'McLaren',
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getInfoCreatore(String creatore) async {
    DocumentSnapshot<Map<String, dynamic>> docCreatore = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(creatore)
        .get();
    Map<String, dynamic> mapCreatore =
        docCreatore.data() as Map<String, dynamic>;

    setState(() {
      nome_creatore = mapCreatore['Nome'];
      cognome_creatore = mapCreatore['Cognome'];
      telefono_creatore = mapCreatore['Telefono'];

    });
  }
}
