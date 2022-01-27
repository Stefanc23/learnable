import 'package:flutter/material.dart';
import 'package:learnable/models/api_response.dart';
import 'package:learnable/screens/addclass.dart';
import 'package:learnable/services/classroom_service.dart';
import 'package:learnable/widgets/custom_text_form_field.dart';
import 'package:learnable/widgets/loading_overlay.dart';

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

  void _createOnTap() async {
    setState(() {
      loading = !loading;
    });
    ApiResponse response = await createClass(
        classNameController.text, inviteCodeController.text, null);
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomTextFormField(
                          controller: classNameController,
                          hintText: 'Class Name'),
                      const SizedBox(height: 24),
                      CustomTextFormField(
                          controller: inviteCodeController,
                          hintText: 'Invite Code'),
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
