import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

TextField textfieldWidget(
    String text, bool isPasswordType, TextEditingController controller,
    [IconData? icon]) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.black,
    style:
        TextStyle(color: Colors.black.withOpacity(0.8), fontFamily: "McLaren"),
    decoration: InputDecoration(
      prefixIconConstraints: const BoxConstraints(minWidth: 50),
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

TextField createEventTextFieldWidget(
    String text, TextEditingController controller,
    [IconData? icon]) {
  return TextField(
    controller: controller,
    autocorrect: true,
    cursorColor: Colors.black,
    style:
        TextStyle(color: Colors.black.withOpacity(0.8), fontFamily: 'McLaren'),
    decoration: InputDecoration(
      prefixIconConstraints: const BoxConstraints(minWidth: 50),
      prefixIcon: Icon(
        icon,
        color: Colors.black87,
      ),
      labelText: text,
      labelStyle: TextStyle(
          color: Colors.black.withOpacity(0.8), fontFamily: 'McLaren'),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white.withOpacity(0.8),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
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
      onPressed: () async {
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

SizedBox elevatedButton(String btnName, IconData icon, Function onTap) {
  return SizedBox(
    width: 425,
    height: 150,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        backgroundColor: hexStringToColor('#EAFFDD'),
      ),
      onPressed: () {
        onTap();
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 50.0),
          const SizedBox(
            width: 5,
          ),
          Text(
            btnName,
            style: const TextStyle(fontFamily: 'McLaren', fontSize: 30.0),
          ),
        ],
      ),
    ),
  );
}

Container profileTextView(String field, String user) {
  return Container(
    height: 60,
    decoration: BoxDecoration(
        color: Colors.white24,
        border: Border.all(
          color: hexStringToColor('#288510'),
          width: 3,
        ),
        borderRadius: BorderRadius.circular(10.0)),
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          DefaultTextStyle(
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'McLaren',
              color: Colors.black,
            ),
            child: Text(field),
          ),
          FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future:
                FirebaseFirestore.instance.collection('users').doc(user).get(),
            builder: (_, snapshot) {
              if (snapshot.hasError) return Text('Error = ${snapshot.error}');
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading");
              }
              Map<String, dynamic> data = snapshot.data!.data()!;
              return DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 24,
                    fontFamily: 'McLaren',
                    color: Colors.black,
                  ),
                  child: Text(data[field]));
            },
          )
        ],
      ),
    ),
  );
}

class MultiSelect extends StatefulWidget {
  final List<String> items;

  const MultiSelect({super.key, required this.items});

  @override
  State<MultiSelect> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  final List<String> _selectedItems = [];

  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems.add(itemValue);
      } else {
        _selectedItems.remove(itemValue);
      }
    });
  }

  void _cancel() {
    Navigator.pop(context);
  }

  List<String> _submit() {
    Navigator.pop(context, _selectedItems);
    return _selectedItems;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const DefaultTextStyle(
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: 'McLaren',
          color: Colors.black,
        ),
        child: Text('Seleziona i ruoli'),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items
              .map((item) => CheckboxListTile(
                    value: _selectedItems.contains(item),
                    title: Text(item),
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (isChecked) => _itemChange(item, isChecked!),
                  ))
              .toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _cancel,
          child: const Text('Cancella'),
        ),
        ElevatedButton(onPressed: _submit, child: const Text('Conferma')),
      ],
    );
  }
}
