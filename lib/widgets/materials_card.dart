import 'dart:io';

import 'package:flutter/material.dart';
import 'package:learnable/models/class_material.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path_provider/path_provider.dart';

class MaterialCard extends StatefulWidget {
  final String userRole;
  final ClassMaterial material;
  final Function(String) onDelete;

  const MaterialCard(
      {Key? key,
      required this.userRole,
      required this.material,
      required this.onDelete})
      : super(key: key);

  @override
  State<MaterialCard> createState() => _MaterialCardState();
}

class _MaterialCardState extends State<MaterialCard> {
  Future<void> _downloadFile() async {
    Directory? dir = await getExternalStorageDirectory();
    File downloadToFile =
        File('${dir!.path}/${widget.material.filePath!.split('/').last}');

    try {
      await firebase_storage.FirebaseStorage.instance
          .ref(widget.material.filePath)
          .writeToFile(downloadToFile);

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Material downloaded.')));
    } on firebase_core.FirebaseException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

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
                      widget.material.title as String,
                      style: Theme.of(context).textTheme.subtitle1!,
                    ),
                  ],
                ),
                Row(children: [
                  GestureDetector(
                    onTap: _downloadFile,
                    child: const Icon(Icons.download_sharp,
                        color: Color(0xFF1F3C88), size: 24),
                  ),
                  const SizedBox(width: 16),
                  if (widget.userRole == 'Instructor')
                    GestureDetector(
                      onTap: () {
                        widget.onDelete('${widget.material.id}');
                      },
                      child:
                          const Icon(Icons.delete, color: Colors.red, size: 24),
                    ),
                ]),
              ],
            ),
          )),
    );
  }
}
