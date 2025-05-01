import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/configs/assets/app_images.dart';
import 'package:flutter_application_1/presentation/intro/pages/get_started.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    redirect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              padding: EdgeInsets.symmetric(vertical: 80),
              // Hình ảnh đầu tiên
              child: Column(children: [
                Align(alignment: Alignment.center, child: Image.asset(AppImages.logo)),
              ])),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: FittedBox(
                fit: BoxFit.fitWidth, 
                child: Image.asset(AppImages.bottom_logo),
              ),
            ),

        ],
      ),
    );
  }

  Future<void> redirect() async {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const GetStartedPage()));
  }
}
