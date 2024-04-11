import 'package:flutter/material.dart';
import 'package:noteapp_with_php_api/Notemodel/Notemodel.dart';
import 'package:noteapp_with_php_api/constants/linkapi.dart';

class cardcustom extends StatelessWidget {
final NoteModel notemodel ;
  final Widget trailing;
  const cardcustom(
      {super.key,
      required this.notemodel,
   
      required this.trailing});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Image.network(
                "$linkimageupload/${notemodel.notosImage}",
                height: 100,
                width: 100,
                fit: BoxFit.fill,
              ),
              flex: 1,
            ),
            Expanded(
              flex: 2,
              child: ListTile(
                trailing: trailing,
                title: Text("${notemodel.notosTitle}"),
                subtitle: Text("${notemodel.notosContent}"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
