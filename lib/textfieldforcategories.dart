// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
class Customtextfieldcat extends StatelessWidget {
 final  String hinttext;
 final TextEditingController controller;
   final String? Function(String?)? validator;
  const Customtextfieldcat({
    Key? key,
    required this.hinttext,
    required this.controller,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   TextFormField(
      validator: validator,
              controller: controller,
                    decoration: InputDecoration(focusedErrorBorder: OutlineInputBorder( borderSide:const BorderSide(color: Color.fromARGB(255, 219, 0, 0) ),borderRadius: BorderRadius.circular(10)),errorBorder: OutlineInputBorder( borderSide:const BorderSide(color: Color.fromARGB(255, 240, 2, 2) ),borderRadius: BorderRadius.circular(10)),hintText: hinttext,focusedBorder: OutlineInputBorder(
                      borderSide:BorderSide(color: Colors.pink.shade700 ),borderRadius: BorderRadius.circular(10)),isDense: true,enabledBorder:OutlineInputBorder(borderRadius: BorderRadius.circular(10)),),
                  );
  }
}
