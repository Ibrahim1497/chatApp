import 'package:flutter/material.dart';

class CustomBottom extends StatelessWidget {
   CustomBottom({super.key, required this.bottomName, required this.bottomColor,this.onTap});

  final String bottomName;
  final Color bottomColor;
  void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            color: bottomColor,
            borderRadius: BorderRadius.circular(15)
        ),
        child: Center(child: Text(bottomName,
          style: TextStyle(
              color: Colors.blue[900],
              fontSize: 25,
              fontWeight: FontWeight.bold),)),
      ),
    );
  }
}
