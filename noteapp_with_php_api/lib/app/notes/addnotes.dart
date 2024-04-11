import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:noteapp_with_php_api/components/managedata.dart';
import 'package:noteapp_with_php_api/components/validator.dart';
import 'package:noteapp_with_php_api/constants/linkapi.dart';
import 'package:noteapp_with_php_api/constants/main.dart';

import '../../components/customtextformfield.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _SignupState();
}

class _SignupState extends State<AddNote> with ManageData {
  GlobalKey<FormState> formsate = GlobalKey();
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  bool isloading = false;
  File? myfile;

  addnote() async {
    if (myfile == null)
      return AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              body: Text("No image uploaded"))
          .show();

    if (formsate.currentState!.validate()) {
      isloading = true;
      setState(() {});
      var response = await postrequestwithfile(
          LinkAddNote,
          {
            "title": title.text,
            "content": content.text,
            "note_user": sharepref.get("user_id"),
          },
          myfile!);
      isloading = false;
      setState(() {});
      if (response["status"] == 'success') {
        print("${response["status"]}");
        return Navigator.of(context).popAndPushNamed("home");
      } else {
        print("${response["status"]}");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Type a note !",
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: isloading == true
          ? Center(child: CircularProgressIndicator())
          : Container(
              margin: EdgeInsets.only(top: 30),
              padding: EdgeInsets.all(30),
              child: ListView(
                children: [
                  Form(
                      key: formsate,
                      child: Column(
                        children: [
                          Image.asset(
                            "images/2.jpeg",
                            height: 200,
                          ),
                          Customfield(
                            validate: (val) {
                              return validator(val!, 5, 30);
                            },
                            hint: "title",
                            mycontroller: title,
                          ),
                          Customfield(
                            validate: (val) {
                              return validator(val!, 5, 80);
                            },
                            hint: "content",
                            mycontroller: content,
                          ),
                          InkWell(
                            onTap: () async {
                              await AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.question,
                                  body: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ElevatedButton(
                                          onPressed: () async {
                                           
                                            // XFile? xfile = await ImagePicker()
                                            //     .pickImage(
                                            //         source: ImageSource.camera);
                                            // Navigator.of(context).pop();
                                            // myfile = File(xfile!.path);

                                            // setState(() {});
                                          },
                                          child:
                                              Icon(Icons.camera_alt_outlined)),
                                      SizedBox(
                                        width: 40,
                                      ),
                                      ElevatedButton(
                                          onPressed: () async {
                                            XFile? xfile = await ImagePicker()
                                                .pickImage(
                                                    source:
                                                        ImageSource.gallery);
                                            Navigator.of(context).pop();
                                            myfile = File(xfile!.path);

                                            setState(() {});
                                          },
                                          child: Icon(
                                              Icons.image_search_outlined)),
                                    ],
                                  )).show();
                            },
                            child: Container(
                                height: 200,
                                width: 300,
                                color: Colors.orangeAccent,
                                child: myfile != null
                                    ? Image.file(
                                        myfile!,
                                        fit: BoxFit.fill,
                                      )
                                    : Center(
                                        child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.image),
                                          Text("add image"),
                                        ],
                                      ))
                                // child: ,
                                ),
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                // var size = await myfile!.length();
                                // print(size);
                                await addnote();
                              },
                              child: Text("AddNote"),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.yellow),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ))
                ],
              ),
            ),
    );
  }
}
