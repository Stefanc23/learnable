import 'package:flutter/material.dart';
import 'package:learnable/screens/login.dart';
import 'package:learnable/widgets/custom_text_form_field.dart';
import 'package:learnable/widgets/primary_button.dart';

class Signup extends StatelessWidget {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Signup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _loginOnPressed() {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Login()),
      );
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                    )),
                Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage('assets/images/bg-auth.png'),
                      fit: BoxFit.fill,
                    ))),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 166,
                        child: Text('Create Account',
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: Colors.white)),
                      ),
                      const SizedBox(height: 73),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CustomTextFormField(
                                controller: fullNameController,
                                hintText: 'Full Name'),
                            const SizedBox(height: 32),
                            CustomTextFormField(
                                controller: emailController, hintText: 'Email'),
                            const SizedBox(height: 32),
                            CustomTextFormField(
                                controller: emailController,
                                hintText: 'Password',
                                obscureText: true),
                          ]),
                      const SizedBox(height: 64),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text('Already have an account? '),
                            GestureDetector(
                                onTap: _loginOnPressed,
                                child: Text('Log in!',
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor)))
                          ]),
                      const SizedBox(height: 16),
                      PrimaryButton(label: 'SIGN UP', onPressed: () {})
                    ],
                  ),
                )
              ],
            )));
  }
}
