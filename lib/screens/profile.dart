import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:learnable/constants.dart';
import 'package:learnable/models/api_response.dart';
import 'package:learnable/models/user.dart';
import 'package:learnable/screens/splash_screen.dart';
import 'package:learnable/services/user_service.dart';
import 'package:learnable/widgets/custom_text_form_field.dart';
import 'package:learnable/widgets/loading_overlay.dart';
import 'package:learnable/widgets/primary_button.dart';
import 'package:learnable/widgets/tertiary_button.dart';

class Profile extends StatefulWidget {
  final User user;
  final Function(User user) updateUserDetails;
  const Profile({Key? key, required this.user, required this.updateUserDetails})
      : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<Profile> createState() => _ProfileState(user);
}

class _ProfileState extends State<Profile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _dobController;

  User user;
  XFile? imageFile;

  bool loading = false;
  bool editing = false;
  String? selectedDOB;
  String? selectedGender;
  var genders = ['Gender', 'Male', 'Female'];

  _ProfileState(this.user);

  @override
  void initState() {
    _nameController = TextEditingController(text: user.name);
    _emailController = TextEditingController(text: user.email);
    _phoneController = TextEditingController(text: user.phone);
    _dobController = TextEditingController(text: user.dob);
    selectedDOB = user.dob;
    selectedGender = user.gender == '' ? 'Gender' : user.gender;
    super.initState();
  }

  void _backOnTap() {
    Navigator.pop(context);
  }

  void _editOnTap() async {
    if (editing) {
      setState(() {
        loading = !loading;
      });
      ApiResponse response = await updateUser(
          _nameController.text,
          _emailController.text,
          _phoneController.text,
          _dobController.text,
          selectedGender == 'Gender' ? '' : selectedGender as String,
          imageFile);
      setState(() {
        loading = !loading;
      });
      if (response.error == null) {
        widget.updateUserDetails(response.data as User);
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Profile saved.')));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${response.error}')));
      }
    }

    setState(() {
      editing = !editing;
    });
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

  _selectDate(BuildContext context) async {
    if (editing) {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDOB == ''
            ? DateTime.now()
            : DateTime.parse(selectedDOB as String),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
        helpText: 'Select date of birth',
      );
      if (picked != null) {
        setState(() {
          selectedDOB = DateFormat('yyyy-MM-dd').format(picked);
          _dobController = TextEditingController(text: selectedDOB);
        });
      }
    }
  }

  void _logoutUser() async {
    ApiResponse response = await logout();

    if (response.error == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const SplashScreen()),
          (route) => false);
    } else {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  void _logoutOnPressed() {
    setState(() {
      loading = !loading;
      _logoutUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: GestureDetector(
            onTap: _backOnTap,
            child: const Icon(
              Icons.arrow_back_sharp,
            )),
        title: const Center(child: Text("My Profile")),
        actions: [
          Padding(
              padding: const EdgeInsets.only(left: 8, right: 16),
              child: GestureDetector(
                  onTap: _editOnTap,
                  child: Icon(editing ? Icons.check : Icons.edit))),
        ],
        elevation: 0,
      ),
      body: Stack(children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 16),
                child: CircleAvatar(
                  radius: 48,
                  backgroundImage: user.profileImage == '' && imageFile == null
                      ? const AssetImage('assets/icons/icon-avatar.png')
                      : null,
                  child: user.profileImage != '' || imageFile != null
                      ? Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: imageFile != null
                                    ? FileImage(File(imageFile!.path))
                                        as ImageProvider
                                    : NetworkImage(
                                        '$baseURL/${user.profileImage}')),
                          ),
                        )
                      : null,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 16, top: 8, right: 16),
                width: double.infinity,
                child: editing
                    ? GestureDetector(
                        onTap: () {
                          _showChoiceDialog(context);
                        },
                        child: Center(
                            child: Text('Change Photo',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                        color:
                                            Theme.of(context).primaryColor))),
                      )
                    : null,
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 18, top: 16, right: 18),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Card(
                          child: CustomTextFormField(
                              controller: _nameController,
                              hintText: 'Fullname',
                              enabled: editing),
                        ),
                        const SizedBox(height: 24),
                        Card(
                          child: CustomTextFormField(
                              controller: _emailController,
                              hintText: 'Email',
                              enabled: editing),
                        ),
                        const SizedBox(height: 24),
                        Card(
                          child: CustomTextFormField(
                              controller: _phoneController,
                              hintText: 'Phone Number',
                              enabled: editing),
                        ),
                        const SizedBox(height: 24),
                        Card(
                          child: GestureDetector(
                            onTap: () {
                              _selectDate(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                border: editing
                                    ? Border.all(
                                        color: Colors.black, width: 0.75)
                                    : null,
                              ),
                              child: CustomTextFormField(
                                controller: _dobController,
                                hintText: 'Date of Birth',
                                enabled: false,
                                suffixIcon: Icon(Icons.date_range,
                                    color: editing
                                        ? Theme.of(context).primaryColor
                                        : null),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Card(
                          child: SizedBox(
                            width: double.infinity,
                            child: DropdownButtonHideUnderline(
                              child: ButtonTheme(
                                alignedDropdown: true,
                                child: DropdownButton(
                                  style: Theme.of(context).textTheme.bodyText2,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5)),
                                  value: selectedGender,
                                  items: genders.map((String gender) {
                                    return DropdownMenuItem(
                                        value: gender, child: Text(gender));
                                  }).toList(),
                                  onChanged: !editing
                                      ? null
                                      : (String? newValue) {
                                          setState(() {
                                            selectedGender = newValue!;
                                          });
                                        },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      PrimaryButton(label: 'Change Password', onPressed: () {}),
                      const SizedBox(height: 24),
                      TertiaryButton(
                          label: 'LOG OUT', onPressed: _logoutOnPressed)
                    ]),
              )
            ],
          ),
        ),
        if (loading) const LoadingOverlay()
      ]),
    );
  }
}
