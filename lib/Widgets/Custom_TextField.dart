
import 'dart:ffi';

import 'package:flutter/material.dart';

class Custom_textField extends StatelessWidget {
   Custom_textField({
    super.key, required this.hintText,required this.oncahanged,this.obscure =false
  });
 String? hintText;
bool? obscure=false;
 Function(String) oncahanged;

  @override
  Widget build(BuildContext context) {
    return TextField(    
      obscureText:obscure! ,  
      onChanged: oncahanged,
      decoration: InputDecoration(
        hintStyle:const TextStyle(color: Colors.white),
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderSide:const BorderSide(
            color: Colors.white
          ),borderRadius: BorderRadius.circular(5),
        ),
        border:OutlineInputBorder(
          borderSide:const BorderSide(
            color: Colors.white
          ) ,
          borderRadius: BorderRadius.circular(5),
        ),  
      ), 
    );
  }
}
