import 'package:flutter/material.dart';

// ignore: camel_case_types
class Custom_Button extends StatelessWidget {
   Custom_Button({
    super.key, required this.buttontext,required this.onTap
  });
final String buttontext;
VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: TextButton(
        style: TextButton.styleFrom(
      backgroundColor: Colors.white,
      minimumSize:const Size(450, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ) // Set the minimum size (width, height)
        ),
        onPressed: onTap,
        child: Text(buttontext,style:const TextStyle(fontSize: 21),),
      ),
    );

  }
}
