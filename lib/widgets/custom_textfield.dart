import 'package:flutter/material.dart';
import 'package:cool_outfits/constants.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final Function onClick;
  // ignore: missing_return
  String _errorMessage(String str) {
    switch (hint) {
      case 'Enter your name':
        return 'Name is empty';
      case 'Enter your email':
        return 'Email is empty';
      case 'Enter your password':
        return 'Password is empty';
    }
  }

  CustomTextField({@required this.hint, this.icon, @required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        // ignore: missing_return
        validator: (value) {
          if (value.isEmpty) {
            return _errorMessage(hint);
          }
        },
        onSaved: onClick,
        obscureText: hint == 'Enter your password' ? true : false,
        cursorColor: kMainColor,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: kMainColor,
          ),
          hintText: hint,
          filled: true,
          fillColor: kSecondaryColor,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.white),
          ),
          border: OutlineInputBorder(
            // on error only
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
