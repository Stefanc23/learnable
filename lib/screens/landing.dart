import 'package:flutter/material.dart';
import 'package:learnable/widgets/primary_button.dart';
import 'package:learnable/widgets/secondary_button.dart';
import 'package:learnable/screens/login.dart';
import 'package:learnable/screens/signup.dart';

class Landing extends StatelessWidget {
  const Landing({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _loginOnPressed() {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const Login()),
      );
    }

    void _signupOnPressed() {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const Signup()),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(children: [
          Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/bg-landing.png'),
                      fit: BoxFit.fill))),
          Center(
            child: Text('Learnable',
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(color: Colors.white, shadows: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      offset: Offset.fromDirection(90, 4),
                      blurRadius: 4)
                ])),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Hero(
                    tag: 'loginButton',
                    child: PrimaryButton(
                        label: 'LOG IN', onPressed: _loginOnPressed),
                  ),
                  const SizedBox(height: 24),
                  Hero(
                    tag: 'signupButton',
                    child: SecondaryButton(
                        label: 'SIGN UP', onPressed: _signupOnPressed),
                  )
                ]),
          )
        ]),
      ),
    );
  }
}
