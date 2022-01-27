import 'package:flutter/material.dart';

class MaterialCard extends StatelessWidget {
  final String materialName; //MaterialTopic

  const MaterialCard({
    Key? key,
    required this.materialName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
          side: BorderSide(color: Colors.grey.withOpacity(0.2), width: 2)),
      elevation: 1,
      child: SizedBox(
          width: 288,
          height: 88,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      materialName,
                      style: Theme.of(context).textTheme.subtitle1!,
                    ),
                  ],
                ),
                Row(children: const [
                  Icon(Icons.download_sharp,
                      color: Color(0xFF1F3C88), size: 24),
                  SizedBox(width: 4),
                ]),
              ],
            ),
          )),
    );
  }
}
