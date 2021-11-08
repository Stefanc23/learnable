import 'package:flutter/material.dart';
import 'package:learnable/screens/signup.dart';
import 'package:learnable/widgets/custom_text_form_field.dart';
import 'package:learnable/widgets/primary_button.dart';

class Login extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _signupOnPressed() {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Signup()),
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
                        child: Text('Welcome Back',
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: Colors.white)),
                      ),
                      const SizedBox(height: 97),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CustomTextFormField(
                                controller: emailController, hintText: 'Email'),
                            const SizedBox(height: 32),
                            CustomTextFormField(
                                controller: emailController,
                                hintText: 'Password',
                                obscureText: true),
                            const SizedBox(height: 24),
                            GestureDetector(
                                onTap: () {},
                                child: Text('Forgot password?',
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor)))
                          ]),
                      const SizedBox(height: 64),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text('No account yet? '),
                            GestureDetector(
                                onTap: _signupOnPressed,
                                child: Text('Sign up!',
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor)))
                          ]),
                      const SizedBox(height: 16),
                      PrimaryButton(label: 'LOG IN', onPressed: () {})
                    ],
                  ),
                )
              ],
            )));
  }
}
