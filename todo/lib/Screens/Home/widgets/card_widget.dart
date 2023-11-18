import 'package:flutter/material.dart';
import 'package:todo/constents/colors.dart';

class CardCategory extends StatelessWidget {
  const CardCategory({super.key, required this.onTap, required this.text});
  final Function() onTap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 50,
      child: InkWell(
        onTap: onTap,
        child: Card(
          color: yellow,
          child: Center(
              child: Text(text,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: light))),
        ),
      ),
    );
  }
}
