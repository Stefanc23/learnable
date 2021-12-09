import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learnable/main.dart';
import 'package:learnable/screens/dashboard.dart';
import 'package:learnable/widgets/custom_text_form_field.dart';
import 'package:learnable/widgets/primary_button.dart';
import 'package:learnable/widgets/tertiary_button.dart';

class Profile extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _backOnTap() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Dashboard()));
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: GestureDetector(
            onTap: _backOnTap,
            child: Icon(
              Icons.arrow_back_sharp,
            )),
        title: Center(child: Text("My Profile")),
        actions: [
          Padding(
              padding: EdgeInsets.only(left: 8, right: 16),
              child:
                  GestureDetector(onTap: () {}, child: const Icon(Icons.edit))),
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 16),
              child: CircleAvatar(
                radius: 48,
                backgroundImage: AssetImage('assets/icons/icon-avatar.png'),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 16, top: 8, right: 16),
              width: double.infinity,
              child: Center(
                  child: Text('Change Photo',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: Colors.black))),
            ),
            Padding(
                padding: EdgeInsets.only(left: 24, top: 16, right: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomTextFormField(
                        controller: nameController, hintText: 'Fullname'),
                    const SizedBox(height: 24),
                    CustomTextFormField(
                        controller: emailController, hintText: 'Email'),
                    const SizedBox(height: 24),
                    CustomTextFormField(
                        controller: phoneController, hintText: 'Phone Number'),
                    const SizedBox(height: 24),
                    CustomTextFormField(
                        controller: emailController, hintText: 'Date of Birth'),
                    const SizedBox(height: 24),
                    CustomTextFormField(
                        controller: emailController, hintText: 'Gender'),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    PrimaryButton(label: 'Change Password', onPressed: () {}),
                    const SizedBox(height: 24),
                    TertiaryButton(label: 'LOG OUT', onPressed: () {})
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
