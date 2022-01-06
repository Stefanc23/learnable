import 'package:flutter/material.dart';

class AssignCard extends StatelessWidget {
  final String assignName;
  final String duedatetime;

  const AssignCard({
    Key? key,
    required this.assignName,
    required this.duedatetime,
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
                      assignName,
                      style: Theme.of(context).textTheme.subtitle1!,
                    ),
                    Text(
                      duedatetime,
                      style: Theme.of(context).textTheme.caption!,
                    ),
                  ],
                ),
                Row(children: [
                  const Icon(Icons.history_sharp,
                      color: Color(0xFF1F3C88), size: 24),
                  const SizedBox(width: 16),
                  const Icon(Icons.download_sharp,
                      color: Color(0xFF1F3C88), size: 24),
                  const SizedBox(width: 16),
                  const Icon(Icons.upload_sharp,
                      color: Color(0xFF1F3C88), size: 24),
                ]),
              ],
            ),
          )),
    );
  }
}
