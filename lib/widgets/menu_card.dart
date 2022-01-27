import 'package:flutter/material.dart';

class MenuCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const MenuCard(
      {Key? key, required this.icon, required this.label, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        elevation: 1,
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Icon(icon,
                    size: 96, color: Theme.of(context).primaryColor)),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(label, style: Theme.of(context).textTheme.subtitle2),
            ),
          ],
        ),
      ),
    );
  }
}
