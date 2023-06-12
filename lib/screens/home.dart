import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prog_mobile_flutter/auth/login.dart';
import 'package:prog_mobile_flutter/screens/create_event.dart';
import 'package:prog_mobile_flutter/screens/profile.dart';
import 'package:prog_mobile_flutter/screens/search_event.dart';
import 'package:prog_mobile_flutter/utils/color_utils.dart';
import 'package:prog_mobile_flutter/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: hexStringToColor('#9FCF72'),
        elevation: 0,
        title: Text(
          "Meet&Kick",
          style: TextStyle(color: hexStringToColor('#288510') , fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background_campo.jpg"),
                fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20,50, 20, 20),
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
                  height: 100,
                ),
                elevatedButton('Cerca un evento', Icons.calendar_month_outlined, () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchEventScreen()));
                }),
                const SizedBox(
                  height: 70,
                ),
                elevatedButton('Crea il tuo evento', Icons.add_box_outlined, () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateEventScreen()));
                }),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar:
          BottomNavigationBar(
              backgroundColor: hexStringToColor("#9FCF72"),
              onTap: _onItemTapped,
              items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Il tuo profilo',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.logout),
          label: 'Logout',
        ),
      ]),
    );
  }

  void _onItemTapped(int index){
    if(index == 0){
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
    }
    if(index == 1){
      FirebaseAuth.instance.signOut();
      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
    }
  }


}
