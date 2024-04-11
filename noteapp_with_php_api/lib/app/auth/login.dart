import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:noteapp_with_php_api/components/managedata.dart';
import 'package:noteapp_with_php_api/constants/linkapi.dart';
import 'package:noteapp_with_php_api/constants/main.dart';

import '../../components/customtextformfield.dart';
import '../../components/validator.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with ManageData{
  GlobalKey<FormState> formsate = GlobalKey();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool? isloading= false;
 
  login() async {
   
    if (formsate.currentState!.validate()) {
      isloading = true ;
      setState(() {
        
      });
      var response = await postrequest(loginlink, {
          "password": password.text,
          "username": username.text
        });
        isloading = false ;
        setState(() {
          
        });
              if (response["status"] == 'success') {
          print("${response["status"]}");
         sharepref.setString("user_id", response!["data"]["user_id"].toString());
          sharepref.setString("username", response!["data"]["username"]);
           sharepref.setString("email", response!["data"]["email"]);
          return Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
        } else {
         AwesomeDialog(context: context, dialogType: DialogType.error)..show();
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isloading==true ? Center(child: CircularProgressIndicator(),): Container(
        margin: const EdgeInsets.only(top: 80),
        padding: const EdgeInsets.all(40),
        child: ListView(
          children: [
            Form(
                key: formsate,
                child: Column(
                  children: [
                    Image.asset("images/1.png", cacheHeight: 200),
                    const SizedBox(
                      height: 20,
                    ),
                    Customfield(
                      validate: (val) {
                        return validator(val!, 5, 20);
                      },
                      hint: "username",
                      mycontroller: username,
                    ),
                    Customfield(
                      validate: (val) {
                        return validator(val!, 5, 20);
                      },
                      hint: "password",
                      mycontroller: password,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          await login();
                        },
                        child: const Text("Login"),
                        style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.yellow),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed("signup");
                      },
                      child: const Text("Signup",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 20)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //  ElevatedButton(
                    // onPressed: () {
                    //   Navigator.of(context).pushNamed("/home");
                    // },
                    // child: Text("home"),
                    // style: ButtonStyle(
                    //   backgroundColor: MaterialStatePropertyAll(Colors.red),
                    // ))
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
