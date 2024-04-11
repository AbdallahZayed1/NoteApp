import 'package:flutter/material.dart';
import 'package:noteapp_with_php_api/Notemodel/Notemodel.dart';
import 'package:noteapp_with_php_api/components/card.dart';
import 'package:noteapp_with_php_api/constants/linkapi.dart';
import 'package:noteapp_with_php_api/constants/main.dart';
import 'package:noteapp_with_php_api/components/managedata.dart';

import 'notes/editnotes.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with ManageData {
  getnotes() async {
    var response = await postrequest(
        LinkViewNote, {"user_id": sharepref.getString("user_id")});
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("addnote");
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                sharepref.clear();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("login", (route) => false);
              },
              icon: Icon(
                Icons.logout_rounded,
                color: Colors.red,
              ))
        ],
        centerTitle: true,
        title: Text("hello ${sharepref.get("username")}"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            InkWell(
              onTap: () {},
              child: FutureBuilder(
                future: getnotes(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data["status"] == "fail")
                      return Center(
                          child: Text(
                        "There are no notes to display",
                        style: TextStyle(fontSize: 25),
                      ));

                    return ListView.builder(
                      itemCount: snapshot.data['data'].length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return cardcustom(
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => Editnote(
                                          notes: snapshot.data["data"][index]),
                                    ));
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.orange,
                                  )),
                              IconButton(
                                  onPressed: () async {
                                    var response = await postrequest(
                                        LinkDeleteNote, {
                                      "note_id": snapshot.data["data"][index] ["notos_id"] .toString(),
                                      "file":snapshot.data["data"][index] ["notos_image"] ,
                                    });
                                    if (response["status"] == "success") {
                                      setState(() {});
                                      // Navigator.of(context).pushReplacementNamed("home");
                                    } else {
                                      print(response["status"]);
                                    }
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ))
                            ],
                          ),
                          notemodel:
                              NoteModel.fromJson(snapshot.data["data"][index]),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
