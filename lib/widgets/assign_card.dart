import 'package:flutter/material.dart';

class AssignCard extends StatefulWidget {
  final String userRole;
  final String assignName;
  final String duedatetime;

  const AssignCard({
    Key? key,
    required this.userRole,
    required this.assignName,
    required this.duedatetime,
  }) : super(key: key);

  @override
  State<AssignCard> createState() => _AssignCardState();
}

class _AssignCardState extends State<AssignCard> {
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
                      widget.assignName,
                      style: Theme.of(context).textTheme.subtitle1!,
                    ),
                    Text(
                      widget.duedatetime,
                      style: Theme.of(context).textTheme.caption!,
                    ),
                  ],
                ),
                Row(children: [
                  const Icon(Icons.download_sharp,
                      color: Color(0xFF1F3C88), size: 24),
                  const SizedBox(width: 16),
                  widget.userRole == 'Instructor'
                      ? Row(children: const [
                          Icon(Icons.text_snippet,
                              color: Color(0xFF1F3C88), size: 24),
                          SizedBox(width: 16),
                          Icon(Icons.delete, color: Colors.red, size: 24),
                        ])
                      : Row(children: const [
                          Icon(Icons.upload_sharp,
                              color: Color(0xFF1F3C88), size: 24),
                          SizedBox(width: 16),
                          Icon(Icons.history_sharp,
                              color: Color(0xFF1F3C88), size: 24),
                        ]),
                  SizedBox(width: 4),
                ]),
              ],
            ),
          )),
    );
  }
}
