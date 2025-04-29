import 'package:flutter/material.dart';
//import 'package:flutter_application_1/common/widgets/appbar/app_bar.dart';
import 'package:flutter_application_1/common/widgets/buttons/basic_app_button.dart';
import 'package:flutter_application_1/core/configs/assets/app_images.dart';
import 'package:flutter_application_1/data/models/auth/create_user_req.dart';
import 'package:flutter_application_1/domain/usecases/auth/signup.dart';
import 'package:flutter_application_1/presentation/auth/pages/signin.dart';
import 'package:flutter_application_1/presentation/choose_mode/pages/choose_mode.dart';
import 'package:flutter_application_1/presentation/root/pages/root.dart';
import 'package:flutter_application_1/service_locator.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _SiginText(context),
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_left_outlined),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          },
        ),
        title: Image.asset(
          AppImages.logo_start,
          height: 40,
          width: 40,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 50, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _registerText(),
            const SizedBox(
              height: 40,
            ),
            _fullNamefeild(context),
            const SizedBox(
              height: 20,
            ),
            _emailFeild(context),
            const SizedBox(
              height: 20,
            ),
            _PassFeild(context),
            const SizedBox(
              height: 30,
            ),
            BasicAppButton(
              onPressed: () async {
                var result = await sl<SignupUseCase>().call(
                  CreateUserReq(
                    fullName: _fullName.text.toString(),
                    email: _email.text.toString(),
                    password: _password.text.toString(),
                  ),
                );
                result.fold((l) {
                  var snackbar = SnackBar(
                    content: Text(l),
                    behavior: SnackBarBehavior.floating,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                }, (r) {
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (BuildContext context) => const RootPage()), (route) => false);
                });
              },
              title: 'Create Account',
            )
          ],
        ),
      ),
    );
  }

  Widget _registerText() {
    return const Text(
      'Register',
      style: TextStyle(
        color: Colors.black,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _fullNamefeild(BuildContext context) {
    return TextField(
      controller: _fullName,
      decoration: const InputDecoration(
        hintText: 'Full Name',
      ).applyDefaults(
        Theme.of(context).inputDecorationTheme,
      ),
    );
  }

  Widget _emailFeild(BuildContext context) {
    return TextField(
      controller: _email,
      decoration: const InputDecoration(
        hintText: 'Email',
      ).applyDefaults(
        Theme.of(context).inputDecorationTheme,
      ),
    );
  }

  Widget _PassFeild(BuildContext context) {
    return TextField(
      controller: _password,
      decoration: const InputDecoration(
        hintText: 'Password',
      ).applyDefaults(
        Theme.of(context).inputDecorationTheme,
      ),
    );
  }

  Widget _SiginText(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text(
          'Bạn đã có tài khoản ?',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SigninPage()),
              );
            },
            child: const Text(
              'Sign in',
              style: TextStyle(
                color: Colors.blue,
              ),
            )),
      ]),
    );
  }
}
