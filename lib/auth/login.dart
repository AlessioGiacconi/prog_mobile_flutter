import 'package:flutter/material.dart';
import 'package:prog_mobile_flutter/auth/register.dart';
import 'package:prog_mobile_flutter/utils/color_utils.dart';

import '../widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              hexStringToColor("#9FCF72"),
              hexStringToColor("#EAFFDD")
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        20, MediaQuery.of(context).size.height * 0.1, 20, 0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(20)),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: logoWidget(
                                  "assets/images/meetkick-logo.png")),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        DefaultTextStyle.merge(
                          style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'McLaren'),
                          child: const Center(
                            child: Text("Benvenuto su Meet&Kick"),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        textfieldWidget("Inserisci Email", Icons.person_outline,
                            false, _emailTextController),
                        const SizedBox(
                          height: 20,
                        ),
                        textfieldWidget("Inserisci Password",
                            Icons.lock_outlined, true, _passwordTextController),
                        const SizedBox(
                          height: 50,
                        ),
                        loginRegisterButton(context, true, () {}),
                        registerOption()
                      ],
                    )
                )
            )
        )
    );
  }

  Row registerOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Non hai ancora un account?",
            style: TextStyle(color: Colors.black87, fontFamily: "McLaren")),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const RegisterScreen()));
          },
          child: const Text(
            " Registrati!",
            style: TextStyle(
                color: Colors.black87,
                fontFamily: "McLaren",
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}


