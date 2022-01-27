import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learnable/models/api_response.dart';
import 'package:learnable/screens/addclass.dart';
import 'package:learnable/services/classroom_service.dart';
import 'package:learnable/widgets/custom_text_form_field.dart';
import 'package:learnable/widgets/loading_overlay.dart';
import 'package:dotted_border/dotted_border.dart';

class CreateClass extends StatefulWidget {
  final Function() updateUserDetails;
  const CreateClass({Key? key, required this.updateUserDetails})
      : super(key: key);

  @override
  State<CreateClass> createState() => _CreateClassState();
}

class _CreateClassState extends State<CreateClass> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController classNameController = TextEditingController();
  final TextEditingController inviteCodeController = TextEditingController();

  bool loading = false;
  XFile? imageFile;

  void _createOnTap() async {
    setState(() {
      loading = !loading;
    });
    ApiResponse response = await createClass(
        classNameController.text, inviteCodeController.text, imageFile);
    setState(() {
      loading = !loading;
    });
    if (response.error == null) {
      widget.updateUserDetails();
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Class created.')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  void _backOnTap() {
    Navigator.pop(context);
  }

  void _openCamera(BuildContext context) async {
    final XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    setState(() {
      imageFile = pickedFile!;
    });
    Navigator.pop(context);
  }

  void _openGallery(BuildContext context) async {
    final XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      imageFile = pickedFile!;
    });

    Navigator.pop(context);
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Choose option",
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  ListTile(
                    onTap: () {
                      _openGallery(context);
                    },
                    title: Text("Gallery",
                        style:
                            TextStyle(color: Theme.of(context).primaryColor)),
                    leading: Icon(
                      Icons.account_box,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      _openCamera(context);
                    },
                    title: Text("Camera",
                        style:
                            TextStyle(color: Theme.of(context).primaryColor)),
                    leading: Icon(
                      Icons.camera,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: GestureDetector(
              onTap: _backOnTap, child: const Icon(Icons.arrow_back_sharp)),
          title: const Center(child: Text("Create New Class")),
          centerTitle: true,
          actions: const [SizedBox(width: 48)],
          elevation: 0,
        ),
        body: Stack(children: [
          Form(
            key: _formKey,
            child: SingleChildScrollView(
                child: Column(children: [
              Padding(
                  padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFormField(
                          controller: classNameController,
                          hintText: 'Class Name'),
                      const SizedBox(height: 24),
                      CustomTextFormField(
                          controller: inviteCodeController,
                          hintText: 'Invite Code'),
                      const SizedBox(height: 16),
                      const Text('Banner Image (Optional)'), //
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: () {
                          _showChoiceDialog(context);
                        },
                        child: SizedBox(
                          width: double.infinity,
                          height: 150,
                          child: imageFile != null
                              ? Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image:
                                            FileImage(File(imageFile!.path))),
                                  ),
                                )
                              : Stack(children: [
                                  DottedBorder(
                                    borderType: BorderType.RRect,
                                    radius: const Radius.circular(5),
                                    padding: const EdgeInsets.all(6),
                                    dashPattern: [8, 4],
                                    strokeWidth: 3,
                                    color: Theme.of(context).primaryColor,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                      child: SizedBox(
                                        width: double.infinity,
                                        height: double.infinity,
                                        child: Image.asset(
                                          'assets/images/class-thumbnail.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    color: Colors.white.withOpacity(0.6),
                                    child: Center(
                                        child: Text('Choose Image',
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1!
                                                .copyWith(
                                                    color: Theme.of(context)
                                                        .primaryColor))),
                                  )
                                ]),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  )),
              Padding(
                  padding: const EdgeInsets.only(left: 16, top: 8, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      OutlinedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddClass(
                                          updateUserDetails:
                                              widget.updateUserDetails,
                                        )));
                          },
                          child: const Text('JOIN CLASS')),
                      const SizedBox(width: 16),
                      ElevatedButton(
                          onPressed: _createOnTap,
                          child: const Text('CREATE CLASS'))
                    ],
                  )),
            ])),
          ),
          if (loading) const LoadingOverlay()
        ]));
  }
}
