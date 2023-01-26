import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:noite/services/auth.dart';

class AuthController extends GetxController{
  static AuthController get to => Get.find<AuthController>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var title = "Bem-vindo".obs;
  var appBarButton = "Cadastre-se".obs;
  var mainButton = "Entrar".obs;
  var isLogin = true.obs;
  var isLoading1 = false.obs;

  final emailFormatValid = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    
    ever(isLogin, (visible) {
      title.value = visible ? 'Bem-vindo' : 'Crie sua conta';
      appBarButton.value = visible ? 'Cadastre-se' : 'Login';
      mainButton.value = visible ? 'Entrar' : 'Cadastrar';
    });
  }

  login() async{
    isLoading1.value = true;
    await AuthServices.to.login(emailController.text, passwordController.text);
    isLoading1.value = false;
    emailController.clear();
    passwordController.clear();
  }

  register() async {
    isLoading1.value = true;
    await AuthServices.to.createUser(emailController.text, passwordController.text);
    isLoading1.value = false;
    emailController.clear();
    passwordController.clear();
  }

  logout() async {
    isLoading1.value = true;
    await AuthServices.to.logOut();
    isLoading1.value = false;
    emailController.clear();
    passwordController.clear();
  }

  onClickInRegister(){
    isLogin.value = !isLogin.value;
    emailController.clear();
    passwordController.clear();
    formKey = GlobalKey<FormState>();
  }
}
