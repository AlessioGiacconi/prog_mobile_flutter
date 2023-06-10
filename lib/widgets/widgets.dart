import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:prog_mobile_flutter/utils/color_utils.dart';

Image logoWidget(String imageName) {
  return Image.asset(
    imageName,
    fit: BoxFit.fill,
    width: 300,
    height: 240,
  );
}

TextField textfieldWidget(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.black,
    style:
        TextStyle(color: Colors.black.withOpacity(0.8), fontFamily: "McLaren"),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.black87,
      ),
      labelText: text,
      labelStyle: TextStyle(
          color: Colors.black.withOpacity(0.8), fontFamily: "McLaren"),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white.withOpacity(0.8),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

Container loginRegisterButton(
    BuildContext context, bool isLogin, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return hexStringToColor('#288510');
            }
            return hexStringToColor('#1ECA00');
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
      child: Text(
        isLogin ? 'LOGIN' : 'REGISTRATI',
        style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: "McLaren",
            fontSize: 16),
      ),
    ),
  );


}


