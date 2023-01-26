import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:noite/controllers/auth_controller.dart';
import 'package:noite/services/auth.dart';

class AuthPage extends StatelessWidget {
  AuthPage({Key? key}) : super(key: key);
  //AuthController _authController = Get.put(AuthController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        backgroundColor: Colors.black,
        title: Obx(() => Text(AuthController.to.title.value)),
        actions: [
          TextButton(
              onPressed: AuthController.to.onClickInRegister,
              child: Obx(() => Text(AuthController.to.appBarButton.value,
                  style: TextStyle(color: Colors.white70))))
        ],
      ),
      body: Obx(() => AuthController.to.isLoading1.value ? Center(child: CircularProgressIndicator()) : Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: AuthController.to.formKey,
          child: Column(
            children: [
              TextFormField(
                controller: AuthController.to.emailController,
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Informe seu email';
                  } else {
                    if (RegExp(AuthController.to.emailFormatValid).hasMatch(value!)) {
                      return null;
                    } else {
                      return 'Informe um email valido';
                    }
                  }
                },
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: AuthController.to.passwordController,
                decoration: const InputDecoration(
                    labelText: 'Password', border: OutlineInputBorder()),
                keyboardType: TextInputType.visiblePassword,
                validator: (value) {
                  if (value != null && value.length < 8) {
                    return "Informe uma senha de no mínimo 8 caracteres";
                  } else {
                    if (value == null) {
                      return "Informe uma senha";
                    } else {
                      return null;
                    }
                  }
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if( AuthController.to.formKey.currentState!.validate()) {
                    if(AuthController.to.isLogin.value){
                      AuthController.to.login();
                    } else {
                      AuthController.to.register();
                    }
                  }
                },
                child: Text(AuthController.to.mainButton.value),
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 60),
                    backgroundColor: Colors.black),
              )
            ],
          ),
        ),
      )),
    );
  }
}
