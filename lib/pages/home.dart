import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noite/services/auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Home Page'),
        actions: [
          TextButton(onPressed: AuthServices.to.logOut, child: Text('Sair'))
        ],
      ),
    );
  }
}

