// ignore_for_file: file_names

import 'package:appadmin/controller/provider/dialogues/showdialogue.dart';
import 'package:flutter/material.dart';

import '../../core/colors.dart';

// ignore: must_be_immutable
class TextFormField1 extends StatelessWidget {
  final String hintText;
  final TextEditingController textController;
  final IconData textIcon;
  TextInputType? input;

  TextFormField1(
      {super.key,
      required this.hintText,
      required this.textController,
      required this.textIcon,
      input});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        controller: textController,
        textAlign: TextAlign.left,
        keyboardType: input,
        validator: (value) =>
            value!.isEmpty ? getError("field Not filled", context) : null,
        style: const TextStyle(fontSize: 11, color: textwhite),
        decoration: InputDecoration(
            filled: true,
            fillColor: textFieldBackground,
            // contentPadding: new EdgeInsets.symmetric(vertical: 0.0),
            // icon: Icon(textIcon,color: Colors.white,),
            prefixIcon: Icon(
              textIcon,
              color: Colors.white,
            ),
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(13))),
      ),
    );
  }
}
