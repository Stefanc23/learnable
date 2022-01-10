import 'package:flutter/material.dart';
import 'package:learnable/screens/createclass.dart';
import 'package:learnable/widgets/custom_text_form_field.dart';

class AddClass extends StatefulWidget {
  final Function() updateUserDetails;

  AddClass({Key? key, required this.updateUserDetails}) : super(key: key);

  @override
  State<AddClass> createState() => _AddClassState();
}

class _AddClassState extends State<AddClass> {
  final TextEditingController classIDController = TextEditingController();

  final TextEditingController inviteCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void _backOnTap() {
      Navigator.pop(context);
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: GestureDetector(
              onTap: _backOnTap, child: const Icon(Icons.arrow_back_sharp)),
          title: const Center(child: Text("Join Class")),
          centerTitle: true,
          actions: [SizedBox(width: 48)],
          elevation: 0,
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Padding(
              padding: EdgeInsets.only(left: 16, top: 16, right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomTextFormField(
                      controller: classIDController, hintText: 'Class ID'),
                  const SizedBox(height: 24),
                  CustomTextFormField(
                      controller: inviteCodeController,
                      hintText: 'Invite Code'),
                  const SizedBox(height: 16),
                ],
              )),
          Padding(
              padding: EdgeInsets.only(left: 16, top: 8, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  OutlinedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateClass(
                                    updateUserDetails:
                                        widget.updateUserDetails)));
                      },
                      child: Text('CREATE CLASS')),
                  SizedBox(width: 16),
                  ElevatedButton(onPressed: () {}, child: Text('JOIN CLASS'))
                ],
              )),
        ])));
  }
}
