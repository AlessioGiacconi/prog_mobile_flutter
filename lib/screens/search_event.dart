import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../utils/event.dart';
import '../utils/color_utils.dart';

class SearchEventScreen extends StatefulWidget {
  const SearchEventScreen({super.key});

  @override
  State<SearchEventScreen> createState() => _SearchEventScreenState();
}

class _SearchEventScreenState extends State<SearchEventScreen> {
  
  final CollectionReference _eventsCollection = FirebaseFirestore.instance.collection('events');
  List<Object> _eventList = [];

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
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
              return Text('$index');
            }
          ),
          ),
        ),
    );
  }

  Future getEventList() async {
      QuerySnapshot querySnapshot = await _eventsCollection.get();
      setState(() {
        _eventList = List.from(querySnapshot.docs.map((event) => Event.fromSnapshot(event)));
      });
  }
}
