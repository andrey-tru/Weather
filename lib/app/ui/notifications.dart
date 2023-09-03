import 'package:flutter/material.dart';
import 'package:weather/app/app.dart';

class Notifications {
  static void showSnackBar(BuildContext context, ErrorModel error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: SingleChildScrollView(
          child: Text('Error: ${error.errorMessage}, Message:${error.message}'),
        ),
      ),
    );
  }
}
