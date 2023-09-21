// login_view.dart

// ignore_for_file: deprecated_member_use

import 'package:adecco_ahmad_test/colors.dart';
import 'package:adecco_ahmad_test/dimentions.dart';
import 'package:adecco_ahmad_test/login/models/user_model.dart';
import 'package:adecco_ahmad_test/login/viewmodels/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  bool showPassword = false;
  bool isLoading = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool saveLogin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorpalette,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimentions.MAIN_PADDING,
                    vertical: Dimentions.MAIN_PADDING * 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Login",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Text(
                      "please enter your username and password",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(color: AppColors.COLOR_WHITE),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      color: AppColors.COLOR_WHITE,
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(Dimentions.MAIN_RADUIS * 2))),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimentions.MAIN_DIMN),
                    child: Column(
                      children: [
                        const FlutterLogo(
                            size: 175.0, style: FlutterLogoStyle.horizontal),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          controller: usernameController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                              hintText: "hi@example.com",
                              labelText: "Username"),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'enter valid username please';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: Dimentions.MAIN_PADDING),
                        TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                              suffix: InkWell(
                                  onTap: () {
                                    setState(() {
                                      showPassword = !showPassword;
                                    });
                                  },
                                  child: const Icon(
                                    Icons.remove_red_eye,
                                    color: AppColors.COLOR_GRAY,
                                  )),
                              labelText: 'Password',
                              hintText: '******'),
                          obscureText: !showPassword,
                          validator: (value) {
                            if (value == null || value.length < 8) {
                              return 'password have to be 8 characters at least';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: Dimentions.MAIN_PADDING),
                        CheckboxListTile(
                            activeColor: AppColors.colorpalette,
                            title: const Text("Remember me"),
                            value: saveLogin,
                            onChanged: (isChecked) =>
                                setState(() => saveLogin = isChecked!)),
                        const SizedBox(height: Dimentions.MAIN_PADDING),
                        if (isLoading)
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: CircleAvatar(
                              backgroundColor: AppColors.colorpalette,
                              child: Padding(
                                padding:
                                    EdgeInsets.all(Dimentions.MINI_PADDING),
                                child: CircularProgressIndicator(
                                  color: AppColors.COLOR_WHITE,
                                  strokeWidth: 2,
                                ),
                              ),
                            ),
                          ),
                        if (!isLoading)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Consumer(
                              builder: (context, ref, child) {
                                return ElevatedButton.icon(
                                  label: const Text("Login"),
                                  icon: const Icon(Icons.arrow_forward),
                                  onPressed: () async {
                                    if (!_formKey.currentState!.validate()) {
                                      return;
                                    }
                                    setState(() => isLoading = true);

                                    // calling login api to check username and password
                                    // if correct so the loginResponseModel will include a token,
                                    // we will assige the token to loginViewModelProvider to use it for other requests

                                    var userModel = UserModel(
                                        username: usernameController.text,
                                        password: passwordController.text);

                                    /*
                                  LoginResponseModel? loginResponseModel =
                                      await AuthService.loginRequest(
                                          userModel, saveLogin);
                            
                                  if (loginResponseModel?.status == false)
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      elevation: 6.0,
                                      behavior: SnackBarBehavior.floating,
                                      content: Text(
                                        "Something went wrong!",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ));
                                    */

                                    // in our case because we do not have backend now,
                                    // we assume that the correct username and password are
                                    // username: alsaleh.ahmad.a@gmail.com
                                    // password: 12345678

                                    if (userModel.username ==
                                            "alsaleh.ahmad.a@gmail.com" &&
                                        userModel.password == "12345678") {
                                      var mytoken = "your_token";
                                      var prefs =
                                          await SharedPreferences.getInstance();
                                      prefs.setString("token", mytoken);

                                      ref.read(loginViewModelProvider).token =
                                          mytoken;
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        elevation: 6.0,
                                        behavior: SnackBarBehavior.floating,
                                        content: Text(
                                          "Something went wrong!",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ));
                                    }

                                    // we will remove loading
                                    setState(() => isLoading = false);
                                  },
                                );
                              },
                            ),
                          ),
                        const SizedBox(height: Dimentions.MAIN_PADDING),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
