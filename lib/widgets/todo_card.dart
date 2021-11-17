import 'package:flutter/material.dart';

class TodoCard extends StatelessWidget {
  final String type;
  final String className;
  final String datetime;

  const TodoCard({
    Key? key,
    required this.type,
    required this.className,
    required this.datetime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      elevation: 1,
      child: SizedBox(
          width: 308,
          height: 96,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      type,
                      style: Theme.of(context).textTheme.subtitle2!,
                    ),
                    Text(
                      className,
                      style: Theme.of(context).textTheme.overline!,
                    ),
                    Text(
                      datetime,
                      style: Theme.of(context).textTheme.overline!,
                    ),
                  ],
                ),
                const Icon(
                  Icons.navigate_next_sharp,
                  size: 32,
                ),
              ],
            ),
          )),
    );
  }
}
