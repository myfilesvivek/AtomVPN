import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:vpn_basic_project/screens/home_screen.dart';
import 'package:vpn_basic_project/utils/app_exports.dart';
import 'package:vpn_basic_project/widgets/custom_image_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     Future.delayed(Duration(milliseconds: 1500),(){
       Get.off(()=> HomeScreen());
     });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        height: 764.h,
        padding: EdgeInsets.symmetric(vertical: 94.h),
        width: double.maxFinite,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomImageView(
              imagePath: 'assets/images/splash_map.png',
              height: 298.h,
              width: double.maxFinite,
              alignment: Alignment.topCenter,
              fit: BoxFit.fill,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomImageView(
                  imagePath: 'assets/images/atm.png',
                  height: 94.h,
                  width: 94.h,
                  radius: BorderRadius.circular(30),
                ),
                SizedBox(
                  height: 42.h,
                ),
                GradientText(
                  "ATOM VPN",
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF2daeee),
                      Color(0xFF005aa9),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  // textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 52.h,
                      letterSpacing: 1.2,
                      fontFamily: 'Nextrue Condensed'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class GradientText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Gradient gradient;

  GradientText(this.text, {required this.gradient, required this.style});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return gradient
            .createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height));
      },
      child: Text(
        text,
        style: style.copyWith(
            color: Colors.white), // Set a base color for the text
      ),
    );
  }
}
