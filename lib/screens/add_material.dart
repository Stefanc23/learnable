import 'dart:io';

import 'package:flutter/material.dart';
import 'package:learnable/models/api_response.dart';
import 'package:learnable/services/material_service.dart';
import 'package:learnable/widgets/custom_text_form_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:learnable/widgets/loading_overlay.dart';

class AddMaterial extends StatefulWidget {
  final String classroomId;
  final dynamic onSubmit;

  const AddMaterial(
      {Key? key, required this.classroomId, required this.onSubmit})
      : super(key: key);

  @override
  State<AddMaterial> createState() => _AddMaterialState();
}

class _AddMaterialState extends State<AddMaterial> {
  final TextEditingController titleMaterialController = TextEditingController();
  PlatformFile? materialFile;
  bool loading = false;

  void _backOnTap() {
    Navigator.pop(context);
  }

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;

      setState(() {
        materialFile = file;
      });
    } else {
      // User canceled the picker
    }
  }

  void _addMaterial() async {
    if (titleMaterialController.text != '' && materialFile != null) {
      setState(() {
        loading = !loading;
      });
      ApiResponse response = await addMaterial(
          widget.classroomId, titleMaterialController.text, materialFile!);
      setState(() {
        loading = !loading;
      });
      if (response.error == null) {
        widget.onSubmit();
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Material added.')));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${response.error}')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: GestureDetector(
            onTap: _backOnTap, child: const Icon(Icons.arrow_back_sharp)),
        title: const Center(child: Text("Add New Material")),
        centerTitle: true,
        actions: const [SizedBox(width: 48)],
        elevation: 0,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
              child: Column(children: [
            Padding(
                padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Card(
                        child: CustomTextFormField(
                            controller: titleMaterialController,
                            hintText: 'Material Title')),
                    const SizedBox(height: 16),
                    OutlinedButton.icon(
                      onPressed: _pickFile,
                      icon: const Icon(Icons.add,
                          size: 18, color: Color(0xFF000000)),
                      label: Text('Choose File',
                          style: Theme.of(context).textTheme.button),
                    ),
                    const SizedBox(height: 16),
                    Text(
                        materialFile == null ? 'File Name' : materialFile!.name,
                        style: Theme.of(context).textTheme.bodyText1),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: _addMaterial,
                            child: const Text('SUBMIT'))
                      ],
                    )
                  ],
                )),
          ])),
          if (loading) const LoadingOverlay()
        ],
      ),
    );
  }
}
