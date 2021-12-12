import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:learnable/models/user.dart';
import 'package:learnable/screens/dashboard.dart';

void saveAndRedirectToDashboard(User user, BuildContext context) {
  final box = GetStorage();
  box.write('token', user.token ?? '');
  box.write('userId', user.id ?? 0);
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => Dashboard(user: user)),
      (route) => false);
}
