import 'package:flutter/material.dart';
import 'package:prog_mobile_flutter/screens/event_detail.dart';
import 'package:prog_mobile_flutter/utils/color_utils.dart';

class EventCard extends StatelessWidget {
  final Map<String, dynamic> _event;

  const EventCard(this._event, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: GestureDetector(
          onTap: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            EventDetailsScreen(event: _event)))
              },
          child: Card(
            elevation: 5,
            margin: const EdgeInsets.all(5),
            color: hexStringToColor('#EAFFDD'),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Text(_event['Titolo'].toUpperCase(),
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'McLaren')),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Text(_event['Luogo'],
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'McLaren')),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text('Il: ${_event['Data']}  alle: ${_event['Ora']}',
                          style: const TextStyle(
                              fontSize: 16, fontFamily: 'McLaren')),
                    ],
                  ),
                  const Divider(
                      height: 15,
                      indent: 10,
                      endIndent: 10,
                      color: Colors.black38),
                  Row(
                    children: [
                      Text(
                        'Cerchiamo: ${_event['Ruoli Richiesti']}',
                        style: const TextStyle(
                            fontSize: 16, fontFamily: 'McLaren'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
