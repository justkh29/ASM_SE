import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/widgets/buttons/basic_app_button.dart';
import 'package:flutter_application_1/core/configs/assets/app_vectors.dart';
import 'package:flutter_application_1/presentation/auth/pages/signup.dart';
import 'package:flutter_application_1/presentation/auth/pages/signin.dart';
import 'package:flutter_application_1/core/configs/theme/app_colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_application_1/presentation/root/pages/root.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 90),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: SvgPicture.asset(AppVectors.account),
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Đổi từ Row sang Column và sắp xếp thứ tự
                  Column(
                    children: [
                      BasicAppButton(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SigninPage()),
                          );
                        },
                        title: 'Sign in',
                      ),
                      const SizedBox(height: 20),
                      BasicAppButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignupPage()),
                          );
                        },
                        title: 'Register',
                      ),
                      const SizedBox(height: 20),
                      BasicAppButton(
                        backgroundColor: Colors.grey[400],
                        foregroundColor: Colors.black,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const RootPage()),
                          );
                        },
                        title: 'Guest',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}