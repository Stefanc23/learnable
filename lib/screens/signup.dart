import 'package:flutter/material.dart';
import 'package:learnable/models/api_response.dart';
import 'package:learnable/models/user.dart';
import 'package:learnable/screens/login.dart';
import 'package:learnable/services/user_service.dart';
import 'package:learnable/utils/save_and_redirect_to_dashboard.dart';
import 'package:learnable/widgets/custom_text_form_field.dart';
import 'package:learnable/widgets/loading_overlay.dart';
import 'package:learnable/widgets/primary_button.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool loading = false;

  void _registerUser() async {
    ApiResponse response = await register(_fullNameController.text,
        _emailController.text, _passwordController.text);
    if (response.error == null) {
      saveAndRedirectToDashboard(response.data as User, context);
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
      MaterialPageRoute(builder: (context) => const Login()),
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
                                controller: _fullNameController,
                                hintText: 'Full Name',
                                validator: (val) =>
                                    val!.isEmpty ? 'Invalid name' : null,
                              ),
                              const SizedBox(height: 32),
                              CustomTextFormField(
                                  controller: _emailController,
                                  validator: (val) => val!.isEmpty
                                      ? 'Invalid email address'
                                      : null,
                                  hintText: 'Email'),
                              const SizedBox(height: 32),
                              CustomTextFormField(
                                  controller: _passwordController,
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
                      Hero(
                        tag: 'signupButton',
                        child: PrimaryButton(
                            label: 'SIGN UP', onPressed: _signupOnPressed),
                      )
                    ],
                  ),
                ),
                if (loading) const LoadingOverlay()
              ],
            )));
  }
}
