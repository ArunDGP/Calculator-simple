import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final color;
  final textColor;
  final String buttonText;
  final Function() buttonPressed;

  MyButton(this.color, this.textColor, this.buttonText, this.buttonPressed);
  //const MyButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: color,
            child: Center(
                child: Text(
              buttonText,
              style: TextStyle(color: textColor, fontSize: 21),
            )),
          ),
        ),
      ),
    );
  }
}
