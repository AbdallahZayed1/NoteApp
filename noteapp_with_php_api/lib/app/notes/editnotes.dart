import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:noteapp_with_php_api/components/managedata.dart';
import 'package:noteapp_with_php_api/components/validator.dart';
import 'package:noteapp_with_php_api/constants/linkapi.dart';


import '../../components/customtextformfield.dart';

class Editnote extends StatefulWidget {
  final notes ;
  const Editnote({super.key, required this.notes});

  @override
  State<Editnote> createState() => _SignupState();
}

class _SignupState extends State<Editnote> with ManageData {
    @override
  void initState() {
    title.text = widget.notes["notos_title"];
    content.text = widget.notes["notos_content"];
    super.initState();
  }

  GlobalKey<FormState> formsate = GlobalKey();
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  bool isloading = false;
  File? myfile ;
  editnote() async {
    if (formsate.currentState!.validate()) {
      isloading = true;
      setState(() {});
     if (myfile == null) {
        var response = await postrequest(LinkEditNote, {
        "note_title": title.text,
        "note_content": content.text,
        "note_id": widget.notes["notos_id"].toString(),
        "note_image": widget.notes["notos_image"],
      });
      isloading = false;
      setState(() {});
      if (response["status"] == 'success') {
        print("${response["status"]}");
        return Navigator.of(context).popAndPushNamed("home");
      } else {
        print("${response["status"]}");
      }
     }else{
       var response = await postrequestwithfile(LinkEditNote, {
        "note_image": widget.notes["notos_image"],
        "note_title": title.text,
        "note_content": content.text,
        "note_id": widget.notes["notos_id"].toString(),
      }
      ,myfile!);
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit the note !",style: TextStyle(fontSize: 30),),
      ),
      body: isloading == true
          ? Center(child: CircularProgressIndicator())
          : Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.all(30),
              child: ListView(
                children: [
                  Form(
                      key: formsate,
                      child: Column(
                        children: [
                          Image.asset("images/2.jpeg",height: 200,),
                          Customfield(
                            validate: (val) {
                              return validator(val!, 5, 55);
                            },
                            hint: "title",
                            mycontroller: title,
                          ),
                          Customfield(
                            validate: (val) {
                              return validator(val!, 5, 255);
                            },
                            hint: "content",
                            mycontroller: content,
                          ),SizedBox(height: 20,),
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
                                child: 
                                myfile != null
                                    ? 
                                    Image.file(
                                        myfile!,
                                        fit: BoxFit.fill,
                                      )
                                    : Image.network("$linkimageupload/${widget.notes["notos_image"]}",fit: BoxFit.fill,)
                                
                                ),
                          ),
                          SizedBox(height: 20,),
                          ElevatedButton(
                              onPressed: () async {
                                await editnote();
                              },
                              child: Text("Save changes"),
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
