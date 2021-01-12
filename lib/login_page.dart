import 'package:connect_unifei/tasks_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

var controllerLogin = new TextEditingController();
var controllerPass = new TextEditingController();

class _LoginPageState extends State<LoginPage> {
  bool load = false;

  void navigationToNextPage(login, pass) {}

  Future<void> nextPage(login, pass) async {
    setState(() {
      load = true;
    });
    var res = await _getTasks(login, pass);
    if (res != false) {
      setState(() {
        load = false;
        controllerLogin.clear();
        controllerPass.clear();
      });
      Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) => new TasksPage(response: res),
        ),
      );
    } else {
      setState(() {
        load = false;
        controllerLogin.clear();
        controllerPass.clear();
      });
    }
  }

  Future<dynamic> _getTasks(String login, String pass) async {
    var data = await http.post(
      Uri.encodeFull("https://connect-dj-api.herokuapp.com/api/sigaa/"),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Token b47d540fce67bb7e2fc60fbefe3c3a74aa53932c",
      },
      body: jsonEncode(
        {
          "userlogin": login,
          "userpass": pass,
        },
      ),
    );

    var jsonData = json.decode(utf8.decode(data.bodyBytes));

    return jsonData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: load
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Faça Login",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo[900],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Coloque os detalhes de sua conta do Sigaa",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue[900],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    inputLogin(
                        "Login", TextInputType.number, false, controllerLogin),
                    SizedBox(
                      height: 30,
                    ),
                    inputLogin(
                        "Password", TextInputType.text, true, controllerPass),
                    SizedBox(
                      height: 30,
                    ),
                    buttonLogin("Entrar", nextPage),
                  ],
                ),
              ),
            ),
    );
  }
}

Widget inputLogin(String textHint, TextInputType typeInput, bool textObscure,
    TextEditingController contr) {
  return SizedBox(
    width: 300,
    child: Material(
      elevation: 20,
      borderRadius: BorderRadius.circular(30),
      shadowColor: Colors.blue[50],
      child: TextFormField(
        controller: contr,
        obscureText: textObscure,
        keyboardType: typeInput,
        autofocus: false,
        style: TextStyle(fontSize: 22),
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.white, width: 3.0),
          ),
          hintText: textHint,
          hintStyle: TextStyle(fontSize: 22, color: Colors.grey[350]),
          fillColor: Colors.white,
          filled: true,
          contentPadding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 20.0),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.white, width: 3.0),
          ),
        ),
      ),
    ),
  );
}

Widget buttonLogin(String text, Function func) {
  return SizedBox(
    width: 300,
    child: Container(
      child: RaisedButton(
        onPressed: () {
          func(controllerLogin.text, controllerPass.text);
        },
        elevation: 0,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        color: Colors.transparent,
        padding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 20.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [_getColorFromHex("#445BEB"), Colors.blue[900]],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blueAccent[100],
            blurRadius: 50.0, // has the effect of softening the shadow
            spreadRadius: 1.0, // has the effect of extending the shadow
            offset: Offset(
              10.0, // horizontal, move right 10
              10.0, // vertical, move down 10
            ),
          )
        ],
        borderRadius: BorderRadius.circular(30),
      ),
    ),
  );
}

Color _getColorFromHex(String hexColor) {
  hexColor = hexColor.replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }
  if (hexColor.length == 8) {
    return Color(int.parse("0x$hexColor"));
  }
}
