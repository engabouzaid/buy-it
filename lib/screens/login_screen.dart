import 'package:cool_outfits/constants.dart';
import 'package:cool_outfits/screens/admin/adminPage.dart';
import 'package:cool_outfits/screens/signup_screen.dart';
import 'package:cool_outfits/screens/user/homePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cool_outfits/widgets/custom_logo.dart';
import 'package:cool_outfits/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:cool_outfits/services/auth.dart';
import 'package:cool_outfits/provider/modalHud.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:cool_outfits/provider/adminMode.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'LoginScreen';
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email, _password;

  final bool isAdmin = false;

  final _auth = Auth();

  final adminPassword = 'admin123456';

  bool keepMeLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kMainColor,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModalHud>(context).isLoading,
        child: Form(
          key: widget.globalKey,
          child: ListView(
            children: [
              CustomLogo(),
              SizedBox(height: height * 0.1),
              CustomTextField(
                onClick: (value) {
                  _email = value;
                },
                hint: 'Enter your email',
                icon: Icons.email,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Row(
                  children: [
                    Theme(
                      data: ThemeData(unselectedWidgetColor: Colors.white),
                      child: Checkbox(
                        checkColor: kSecondaryColor,
                        activeColor: kMainColor,
                        value: keepMeLoggedIn,
                        onChanged: (value) {
                          setState(() {
                            keepMeLoggedIn = value;
                          });
                        },
                      ),
                    ),
                    Text(
                      'Remember me',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
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
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      if (keepMeLoggedIn == true) {
                        keepUserLoggedUn();
                      }
                      _validate(context);
                    },
                  ),
                ),
              ),
              SizedBox(height: height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account? ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SignupScreen.id);
                    },
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.01),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Provider.of<AdminMode>(context, listen: false)
                          .changeIsAdmin(true);
                    },
                    child: Text(
                      'I\'m an admin',
                      style: TextStyle(
                        color: Provider.of<AdminMode>(context).isAdmin
                            ? kMainColor
                            : kSecondaryColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Provider.of<AdminMode>(context, listen: false)
                          .changeIsAdmin(false);
                    },
                    child: Text(
                      'I\'m a user',
                      style: TextStyle(
                        color: Provider.of<AdminMode>(context).isAdmin
                            ? kSecondaryColor
                            : kMainColor,
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

  void _validate(BuildContext context) async {
    final modalhud = Provider.of<ModalHud>(context, listen: false);
    modalhud.changeIsLoading(true);
    if (widget.globalKey.currentState.validate()) {
      widget.globalKey.currentState.save();
      if (Provider.of<AdminMode>(context, listen: false).isAdmin) {
        if (_password == adminPassword) {
          try {
            await _auth.signIn(_email, _password);
            Navigator.pushNamed(context, AdminPage.id);
          } catch (e) {
            modalhud.changeIsLoading(false);
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text(e.message)));
          }
        } else {
          modalhud.changeIsLoading(false);
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text('Something went wrong!')));
        }
      } else {
        try {
          await _auth.signIn(_email, _password);
          Navigator.pushNamed(context, HomePage.id);
        } catch (e) {
          modalhud.changeIsLoading(false);
          Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.message)));
        }
      }
    }
    modalhud.changeIsLoading(false);
  }

  void keepUserLoggedUn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(kKeepMeLoggedIn, keepMeLoggedIn);
  }
}
