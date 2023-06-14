import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prog_mobile_flutter/widgets/eventCard.dart';

import '../utils/color_utils.dart';

class SearchEventScreen extends StatefulWidget {
  const SearchEventScreen({super.key});

  @override
  State<SearchEventScreen> createState() => _SearchEventScreenState();
}

class _SearchEventScreenState extends State<SearchEventScreen> {
  final CollectionReference _eventsCollection =
      FirebaseFirestore.instance.collection('events');
  final List<Map<String, dynamic>> _eventList = [];
  List<Map<String, dynamic>> _filteredList = [];
  final TextEditingController _searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getEventList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: hexStringToColor('#9FCF72'),
        elevation: 0,
        title: Text(
          "Cerca un evento",
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: _searchTextController,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Filtra in base al Luogo',
                    filled: true,
                    fillColor: hexStringToColor('#EAFFDD'),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black54))),
                onChanged: searchEvent,
              ),
            ),
            Expanded(
              child: _filteredList.isNotEmpty
                  ? ListView.builder(
                      itemCount: _filteredList.length,
                      itemBuilder: (context, index) {
                        return EventCard(_filteredList[index]);
                      })
                  : ListView.builder(
                      itemCount: _eventList.length,
                      itemBuilder: (context, index) {
                        return EventCard(_eventList[index]);
                      }),
            ),
          ],
        ),
      ),
    );
  }

  Future getEventList() async {
    QuerySnapshot querySnapshot = await _eventsCollection.get();
    setState(() {
      querySnapshot.docs.forEach((element) {
        Map<String, dynamic>? event = element.data() as Map<String, dynamic>?;
        _eventList.add(event!);
      });
      //_eventList = List.from(querySnapshot.docs.map((event) => Event.fromSnapshot(event)));
    });
  }

  void searchEvent(String query) {
    final suggestions = _eventList.where((event) {
      final luogoEvento = event['Luogo'].toLowerCase();
      final input = query.toLowerCase();

      return luogoEvento.contains(input);
    }).toList();

    setState(() => _filteredList = suggestions);
  }
}
