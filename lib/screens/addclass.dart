import 'package:flutter/material.dart';
import 'package:learnable/models/api_response.dart';
import 'package:learnable/screens/createclass.dart';
import 'package:learnable/services/classroom_service.dart';
import 'package:learnable/widgets/custom_text_form_field.dart';
import 'package:learnable/widgets/loading_overlay.dart';

class AddClass extends StatefulWidget {
  final Function() updateUserDetails;

  AddClass({Key? key, required this.updateUserDetails}) : super(key: key);

  @override
  State<AddClass> createState() => _AddClassState();
}

class _AddClassState extends State<AddClass> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController classIDController = TextEditingController();
  final TextEditingController inviteCodeController = TextEditingController();

  bool loading = false;

  void _joinOnTap() async {
    setState(() {
      loading = !loading;
    });
    ApiResponse response =
        await joinClass(classIDController.text, inviteCodeController.text);
    setState(() {
      loading = !loading;
    });
    if (response.error == null) {
      widget.updateUserDetails();
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Class joined.')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

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
          actions: const [SizedBox(width: 48)],
          elevation: 0,
        ),
        body: Stack(children: [
          SingleChildScrollView(
              child: Column(children: [
            Padding(
                padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
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
                                  builder: (context) => CreateClass(
                                      updateUserDetails:
                                          widget.updateUserDetails)));
                        },
                        child: const Text('CREATE CLASS')),
                    const SizedBox(width: 16),
                    ElevatedButton(
                        onPressed: _joinOnTap, child: const Text('JOIN CLASS'))
                  ],
                )),
          ])),
          if (loading) const LoadingOverlay()
        ]));
  }
}
