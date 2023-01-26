
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noite/controllers/auth_controller.dart';
import 'package:noite/pages/auth_page.dart';

import '../pages/home.dart';

class AuthServices extends GetxController{
  //AuthController _authController = Get.put(AuthController());
  static AuthServices get to => Get.find<AuthServices>();

  FirebaseAuth _auth = FirebaseAuth.instance;
  var _firebaseUser = Rxn<User>();
  var userIsAuth = false.obs;
  var isLoading = false.obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    _firebaseUser = Rxn<User>(_auth.currentUser);
    _firebaseUser.bindStream(_auth.authStateChanges());

    ever(_firebaseUser, (User? user) {
      if (user != null){
        userIsAuth.value = true;
      } else {
        userIsAuth.value = false;
      }
    });
  }

  showSnack(String title, String message){
    return Get.snackbar(title, message, backgroundColor: Colors.grey[900], colorText: Colors.white,snackPosition: SnackPosition.BOTTOM);
  }
  User? get user => _firebaseUser.value;


  createUser(String email, String password) async {
    try {
      //isLoading.value = true;
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      //isLoading.value = false;


    } catch(e) {
      showSnack('Não conseguimos criar um cadastro', 'Por favor tente mais tarde');
      //isLoading.value = false;
      //AuthController.to.emailController.clear();
      //AuthController.to.passwordController.clear();
    }
  }

  login (String email, String password) async {
    try{
      //isLoading.value = true;
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      //isLoading.value = false;
    } catch(e){
      showSnack('Não foi possível efetuar o login', 'Por favor tente novamente mais tarde');
      //isLoading.value = false;
    }
  }

  logOut() async {
    //isLoading.value = true;
    await _auth.signOut();
    //isLoading.value = false;
  }
}


class CheckAuth extends StatelessWidget {
  const CheckAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => AuthServices.to.userIsAuth.value ? HomePage() : AuthPage());
  }
}
