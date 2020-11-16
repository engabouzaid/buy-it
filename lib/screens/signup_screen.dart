import 'package:cool_outfits/screens/login_screen.dart';
import 'package:cool_outfits/screens/user/homePage.dart';
import 'package:cool_outfits/widgets/custom_logo.dart';
import 'package:cool_outfits/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:cool_outfits/constants.dart';
import 'package:cool_outfits/services/auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:cool_outfits/provider/modalHud.dart';

class SignupScreen extends StatelessWidget {
  String _email, _password;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  static String id = 'SignupScreen';
  final _auth = Auth();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kMainColor,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModalHud>(context).isLoading,
        child: Form(
          key: _globalKey,
          child: ListView(
            children: [
              CustomLogo(),
              SizedBox(height: height * 0.1),
              CustomTextField(
                onClick: (value) {},
                hint: 'Enter your name',
                icon: Icons.perm_identity,
              ),
              SizedBox(height: height * 0.02),
              CustomTextField(
                onClick: (value) {
                  _email = value;
                },
                hint: 'Enter your email',
                icon: Icons.email,
              ),
              SizedBox(height: height * 0.02),
              CustomTextField(
                onClick: (value) {
                  _password = value;
                },
                hint: 'Enter your password',
                icon: Icons.lock,
              ),
              SizedBox(height: height * 0.05),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 120),
                child: Builder(
                  builder: (context) => FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: Colors.black,
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () async {
                      final modalHud =
                          Provider.of<ModalHud>(context, listen: false);
                      modalHud.changeIsLoading(true);
                      if (_globalKey.currentState.validate()) {
                        _globalKey.currentState.save();
                        try {
                          final authResult =
                              await _auth.signUp(_email.trim(), _password.trim());
                          modalHud.changeIsLoading(false);
                          Navigator.pushNamed(context, HomePage.id);
                        } catch (e) {
                          modalHud.changeIsLoading(false);
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text(e.message),
                          ));
                        }
                      }
                      modalHud.changeIsLoading(false);
                    },
                  ),
                ),
              ),
              SizedBox(height: height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Do have an account? ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, LoginScreen.id);
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
