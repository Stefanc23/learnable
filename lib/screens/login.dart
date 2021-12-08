import 'package:flutter/material.dart';
import 'package:learnable/models/api_response.dart';
import 'package:learnable/models/user.dart';
import 'package:learnable/screens/dashboard.dart';
import 'package:learnable/screens/signup.dart';
import 'package:learnable/services/user_service.dart';
import 'package:learnable/widgets/custom_text_form_field.dart';
import 'package:learnable/widgets/primary_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool loading = false;

  void _loginUser() async {
    ApiResponse response =
        await login(_emailController.text, _passwordController.text);
    if (response.error == null) {
      _saveAndRedirectToHome(response.data as User);
    } else {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  void _loginOnPressed() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
        _loginUser();
      });
    }
  }

  void _signupOnPressed() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => Signup()),
    );
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
                        child: Text('Welcome Back',
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: Colors.white)),
                      ),
                      const SizedBox(height: 97),
                      Form(
                        key: _formKey,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CustomTextFormField(
                                controller: _emailController,
                                hintText: 'Email',
                                validator: (val) => val!.isEmpty
                                    ? 'Invalid email address'
                                    : null,
                                keyboardType: TextInputType.emailAddress,
                              ),
                              const SizedBox(height: 32),
                              CustomTextFormField(
                                controller: _passwordController,
                                hintText: 'Password',
                                validator: (val) => val!.length < 6
                                    ? 'Required at least 6 chars'
                                    : null,
                                obscureText: true,
                              ),
                              const SizedBox(height: 24),
                              GestureDetector(
                                  onTap: () {},
                                  child: Text('Forgot password?',
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).primaryColor)))
                            ]),
                      ),
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
                      PrimaryButton(label: 'LOG IN', onPressed: _loginOnPressed)
                    ],
                  ),
                )
              ],
            )));
  }
}
