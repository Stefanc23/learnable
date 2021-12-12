import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.25),
        ),
        child: const Center(
          child: CircularProgressIndicator(),
        ));
  }
}
