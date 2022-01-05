import 'package:flutter/material.dart';
import 'package:learnable/constants.dart';

class ClassCard extends StatelessWidget {
  final String className;
  final String classThumbnail;
  final VoidCallback onTap;
  final bool isLastCard;

  const ClassCard({
    Key? key,
    this.className = 'Class Name',
    this.classThumbnail = '',
    required this.onTap,
    this.isLastCard = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        elevation: 1,
        child: SizedBox(
          width: 128,
          height: 140,
          child: isLastCard
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.add, size: 24),
                    const SizedBox(height: 16),
                    Text('Add Class',
                        style: Theme.of(context).textTheme.subtitle2)
                  ],
                )
              : Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 96,
                      child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: classThumbnail == ''
                              ? Image.asset(
                                  'assets/images/class-thumbnail.png',
                                  fit: BoxFit.fitWidth,
                                  alignment: Alignment.topCenter,
                                )
                              : Image.network(
                                  '$baseURL/$classThumbnail',
                                  fit: BoxFit.fitWidth,
                                  alignment: Alignment.topCenter,
                                )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(className,
                          style: Theme.of(context).textTheme.subtitle2),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
