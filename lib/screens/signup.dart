import 'package:flutter/material.dart';
import 'package:learnable/models/api_response.dart';
import 'package:learnable/models/user.dart';
import 'package:learnable/screens/dashboard.dart';
import 'package:learnable/screens/login.dart';
import 'package:learnable/services/user_service.dart';
import 'package:learnable/widgets/custom_text_form_field.dart';
import 'package:learnable/widgets/primary_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Signup extends StatefulWidget {
  Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool loading = false;

  void _registerUser() async {
    ApiResponse response = await register(
        fullNameController.text, emailController.text, passwordController.text);
    if (response.error == null) {
      _saveAndRedirectToHome(response.data as User);
    } else {
      setState(() {
        loading = !loading;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  void _loginOnPressed() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  void _signupOnPressed() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = !loading;
        _registerUser();
      });
    }
  }

  void _saveAndRedirectToHome(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('userId', user.id ?? 0);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Dashboard()), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
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
                        width: 180,
                        child: Text('Create Account',
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: Colors.white)),
                      ),
                      const SizedBox(height: 73),
                      Form(
                        key: _formKey,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CustomTextFormField(
                                controller: fullNameController,
                                hintText: 'Full Name',
                                validator: (val) =>
                                    val!.isEmpty ? 'Invalid name' : null,
                              ),
                              const SizedBox(height: 32),
                              CustomTextFormField(
                                  controller: emailController,
                                  validator: (val) => val!.isEmpty
                                      ? 'Invalid email address'
                                      : null,
                                  hintText: 'Email'),
                              const SizedBox(height: 32),
                              CustomTextFormField(
                                  controller: emailController,
                                  hintText: 'Password',
                                  validator: (val) => val!.length < 6
                                      ? 'Required at least 6 chars'
                                      : null,
                                  obscureText: true),
                            ]),
                      ),
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
                      PrimaryButton(
                          label: 'SIGN UP', onPressed: _signupOnPressed)
                    ],
                  ),
                )
              ],
            )));
  }
}
