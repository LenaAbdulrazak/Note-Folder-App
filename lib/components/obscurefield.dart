// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ObscureTextField extends StatefulWidget {
 final  String hinttext;
  bool obscuretext;
 final TextEditingController controller;
   final String? Function(String?)? validator;
   ObscureTextField({
    Key? key,
    required this.hinttext,
    required this.obscuretext,
    required this.controller,
    required this.validator,
  }) : super(key: key);

  @override
  State<ObscureTextField> createState() => _ObscureTextFieldState();
}

class _ObscureTextFieldState extends State<ObscureTextField> {
  @override
  Widget build(BuildContext context) {
    return   TextFormField(
      
      obscureText: widget.obscuretext,
      validator: widget.validator,
              controller: widget.controller,
                    decoration: InputDecoration(suffixIcon: IconButton(
        icon: widget.obscuretext
            ? const Icon(Icons.visibility_off)
            : const Icon(Icons.visibility),
        onPressed: () {
          widget.obscuretext = !widget.obscuretext;

          setState(() {});
        },
      ),focusedErrorBorder: OutlineInputBorder( borderSide:const BorderSide(color: Color.fromARGB(255, 219, 0, 0) ),borderRadius: BorderRadius.circular(10)),errorBorder: OutlineInputBorder( borderSide:const BorderSide(color: Color.fromARGB(255, 240, 2, 2) ),borderRadius: BorderRadius.circular(10)),hintText: widget.hinttext,focusedBorder: OutlineInputBorder(
                      borderSide:BorderSide(color: Colors.pink.shade700 ),borderRadius: BorderRadius.circular(10)),isDense: true,enabledBorder:OutlineInputBorder(borderRadius: BorderRadius.circular(10)),),
                  );
  }
}
