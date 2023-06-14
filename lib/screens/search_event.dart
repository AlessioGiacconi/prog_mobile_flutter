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
  
  final CollectionReference _eventsCollection = FirebaseFirestore.instance.collection('events');
  final List<Map<String,dynamic>> _eventList = [];


  @override
  void initState(){
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
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            hexStringToColor("#9FCF72"),
            hexStringToColor("#EAFFDD")
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          alignment: Alignment.topCenter,
          child: ListView.builder(
            itemCount: _eventList.length,
            itemBuilder: (context, index) {
              return EventCard(_eventList[index]);
            }
          ),
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
      });
  }
}

