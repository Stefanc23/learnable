import 'package:flutter/material.dart';

class TertiaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const TertiaryButton({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 4)
      ]),
      child: SizedBox(
        height: 48,
        width: double.infinity,
        child: ElevatedButton(
            onPressed: onPressed,
            child: Text(label,
                style: const TextStyle(
                  color: Colors.red,
                )),
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              side: const BorderSide(
                  width: 1, color: Colors.red), //border width and color
              shape: RoundedRectangleBorder(
                  //to set border radius to button
                  borderRadius: BorderRadius.circular(5)),
            )),
      ),
    );
  }
}
