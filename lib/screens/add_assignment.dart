import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:learnable/widgets/custom_text_form_field.dart';

class AddAssignment extends StatefulWidget {
  AddAssignment({Key? key}) : super(key: key);

  @override
  State<AddAssignment> createState() => _AddAssignmentState();
}

class _AddAssignmentState extends State<AddAssignment> {
  final TextEditingController titleAssignController = TextEditingController();
  late TextEditingController deadlineController;

  bool editing = false;
  String? selecteddeadline;

  @override
  void initState() {
    deadlineController = TextEditingController();
    selecteddeadline = 'text';
  }

  void _backOnTap() {
    Navigator.pop(context);
  }

  _selectDate(BuildContext context) async {
    if (editing) {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selecteddeadline == ''
            ? DateTime.now()
            : DateTime.parse(selecteddeadline as String),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
        helpText: 'Assignment Deadlin',
      );
      if (picked != null) {
        setState(() {
          selecteddeadline = DateFormat('yyyy-MM-dd').format(picked);
          deadlineController = TextEditingController(text: selecteddeadline);
        });
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
        title: const Center(child: Text("Add New Assignment")),
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
                            controller: titleAssignController,
                            hintText: 'Assignment Title')),
                    const SizedBox(height: 16),
                    Card(
                      child: GestureDetector(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            border: editing
                                ? Border.all(color: Colors.black, width: 0.75)
                                : null,
                          ),
                          child: CustomTextFormField(
                            controller: deadlineController,
                            hintText: 'Assignment Deadline',
                            enabled: false,
                            suffixIcon: Icon(Icons.date_range,
                                color: editing
                                    ? Theme.of(context).primaryColor
                                    : null),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton.icon(
                      onPressed: () {
                        // Respond to button press
                      },
                      icon: Icon(Icons.add, size: 18, color: Color(0xFF000000)),
                      label: Text('Choose File',
                          style: Theme.of(context).textTheme.button),
                    ),
                    const SizedBox(height: 16),
                    Text('File Name',
                        style: Theme.of(context).textTheme.bodyText1),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        OutlinedButton(
                            onPressed: () {}, child: const Text('CLOSE')),
                        const SizedBox(width: 16),
                        ElevatedButton(
                            onPressed: () {}, child: const Text('SUBMIT'))
                      ],
                    )
                  ],
                )),
          ]))
        ],
      ),
    );
  }
}
