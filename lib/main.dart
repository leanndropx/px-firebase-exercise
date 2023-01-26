import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:noite/controllers/auth_controller.dart';
import 'package:noite/pages/auth_page.dart';
import 'package:noite/services/auth.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.lazyPut<AuthServices>(() => AuthServices());
  Get.lazyPut<AuthController>(() => AuthController());
  runApp(const Noite());
}

class Noite extends StatelessWidget {
  const Noite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: CheckAuth(),
    );
  }
}
