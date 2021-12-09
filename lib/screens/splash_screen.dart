import 'package:flutter/material.dart';
import 'package:learnable/constants.dart';
import 'package:learnable/models/api_response.dart';
import 'package:learnable/screens/dashboard.dart';
import 'package:learnable/screens/landing.dart';
import 'package:learnable/services/user_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _loadUserInfo() async {
    await Future.delayed(const Duration(seconds: 2), () async {
      String? token = await getToken();
      if (token == '') {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const Landing()),
            (route) => false);
      } else {
        ApiResponse response = await getUserDetail();
        if (response.error == null) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => Dashboard()),
              (route) => false);
        } else if (response.error == unauthorized) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const Landing()),
              (route) => false);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('$response.error'),
          ));
        }
      }
    });
  }

  @override
  void initState() {
    _loadUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/bg-landing.png'),
                fit: BoxFit.fill)),
        child: Center(
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
        ));
  }
}
