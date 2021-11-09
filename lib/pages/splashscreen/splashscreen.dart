import 'dart:io';

import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: const Text('SEA OIL EXAM'),
      ),
    );
  }
}

class ErrorSplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: InternetAddress.lookup('google.com'),
      builder: (context, AsyncSnapshot snapshot) {
        return const Scaffold(
          body: Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Internet not avaialble',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }
}
