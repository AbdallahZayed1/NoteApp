import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Customfield extends StatelessWidget {
  final String hint ;
  final TextEditingController mycontroller ;
  final String? Function(String?)? validate ;
  const Customfield({super.key, required this.hint, required this.mycontroller,required this.validate});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10,bottom: 10),
      child: TextFormField(
        controller: mycontroller,
        validator: validate,
        decoration: InputDecoration(hintText: hint,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            
          )
        ),
      ),
    );
  }
}