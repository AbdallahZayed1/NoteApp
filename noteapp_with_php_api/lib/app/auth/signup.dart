import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:noteapp_with_php_api/components/managedata.dart';
import 'package:noteapp_with_php_api/components/validator.dart';
import 'package:noteapp_with_php_api/constants/linkapi.dart';

import '../../components/customtextformfield.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> with ManageData {

  GlobalKey<FormState> formsate = GlobalKey();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isloading = false;

  signup() async {
    if (formsate.currentState!.validate() ) {
      isloading = true;
      setState(() {
        
      });
      var response = await postrequest(signuplink, {
        "username": username.text,
        "password": password.text,
        "email": email.text
      });
      isloading = false;
      setState(() {});
      if (response["status"] == 'success') {
        print("${response["status"]}");
        return AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            btnOkOnPress: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("login", (route) => false);
            },
            body: Text("Account created succesfully"),
            btnOkText: "Go to Login page  ")
          ..show();
      } else {
        print("${response["status"]}");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isloading == true
          ? Center(child: CircularProgressIndicator())
          : Container(
              margin: EdgeInsets.only(top: 80),
              padding: EdgeInsets.all(40),
              child: ListView(
                children: [
                  Form(
                      key: formsate,
                      child: Column(
                        children: [
                          Image.asset("images/1.png", cacheHeight: 200),
                          SizedBox(
                            height: 20,
                          ),
                          Customfield(
                            
                            validate: (val) {
                              
                              return validator(val!, 5, 20);
                              
                            },
                            hint: "Username",
                            mycontroller: username,
                          ),
                          Customfield(
                            validate: (val) {
                              return validator(val!, 5, 30);
                            },
                            hint: "email",
                            mycontroller: email,
                          ),
                          Customfield(
                            validate: (val) {
                              return validator(val!, 5, 20);
                            },
                            hint: "password",
                            mycontroller: password,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                await signup();
                              },
                              child: Text("Signup"),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.yellow),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacementNamed("login");
                            },
                            child: Text("Login",
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 20)),
                          )
                        ],
                      ))
                ],
              ),
            ),
    );
  }
}
