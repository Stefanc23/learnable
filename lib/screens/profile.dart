import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learnable/models/api_response.dart';
import 'package:learnable/screens/splash_screen.dart';
import 'package:learnable/services/user_service.dart';
import 'package:learnable/widgets/custom_text_form_field.dart';
import 'package:learnable/widgets/loading_overlay.dart';
import 'package:learnable/widgets/primary_button.dart';
import 'package:learnable/widgets/tertiary_button.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  bool loading = false;

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
    void _backOnTap() {
      Navigator.pop(context);
    }

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
              child:
                  GestureDetector(onTap: () {}, child: const Icon(Icons.edit))),
        ],
        elevation: 0,
      ),
      body: Stack(children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 16),
                child: const CircleAvatar(
                  radius: 48,
                  backgroundImage: AssetImage('assets/icons/icon-avatar.png'),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 16, top: 8, right: 16),
                width: double.infinity,
                child: Center(
                    child: Text('Change Photo',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: Colors.black))),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 24, top: 16, right: 24),
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
                          controller: phoneController,
                          hintText: 'Phone Number'),
                      const SizedBox(height: 24),
                      CustomTextFormField(
                          controller: emailController,
                          hintText: 'Date of Birth'),
                      const SizedBox(height: 24),
                      CustomTextFormField(
                          controller: emailController, hintText: 'Gender'),
                    ],
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
