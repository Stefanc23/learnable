import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ClassCard extends StatefulWidget {
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
  State<ClassCard> createState() => _ClassCardState();
}

class _ClassCardState extends State<ClassCard> {
  String thumbnailImageUrl = '';

  void _getThumbnailImageUrl() async {
    String url = await firebase_storage.FirebaseStorage.instance
        .ref(widget.classThumbnail)
        .getDownloadURL();
    setState(() {
      thumbnailImageUrl = url;
    });
  }

  @override
  void initState() {
    if (widget.classThumbnail != '') _getThumbnailImageUrl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        elevation: 1,
        child: SizedBox(
          width: 128,
          height: 140,
          child: widget.isLastCard
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
                          child: thumbnailImageUrl == ''
                              ? Image.asset(
                                  'assets/images/class-thumbnail.png',
                                  fit: BoxFit.fitWidth,
                                  alignment: Alignment.topCenter,
                                )
                              : Image.network(
                                  thumbnailImageUrl,
                                  fit: BoxFit.cover,
                                  alignment: Alignment.topCenter,
                                )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(widget.className,
                          style: Theme.of(context).textTheme.subtitle2),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
