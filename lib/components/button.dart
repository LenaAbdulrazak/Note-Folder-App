// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MaterialButtoncustom extends StatelessWidget {
  final String title;
  final Function()?onPressed;
  const MaterialButtoncustom({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return    MaterialButton(shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10)),
      onPressed: onPressed,color: Colors.pink.shade700,
      child:  Text(title,
      style: const TextStyle(color: Colors.white,fontSize: 20),),);
  }
}
