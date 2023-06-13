import 'package:flutter/material.dart';

import '../utils/event.dart';

class EventCard extends StatelessWidget {
  final Event _event;

  EventCard(this._event);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom:10.0),
                    child: Text(_event.titolo!, style:  const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'McLaren')),
                  )
                ],
              ),
              Row(
                children: [
                  Text(_event.data!, style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'McLaren')),
                  const Spacer(),
                  Text(_event.ora!, style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'McLaren'))
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}
