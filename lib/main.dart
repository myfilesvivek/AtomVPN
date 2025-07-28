import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:vpn_basic_project/helpers/prefs.dart';
import 'package:vpn_basic_project/screens/splash_screen.dart';
import 'package:vpn_basic_project/theme/theme_helper.dart';
import 'package:vpn_basic_project/utils/app_exports.dart';




Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

  await Pref.initializeHive();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((val){
    runApp(const MyApp());
  });

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context,orientation,deviceType) {
        return GetMaterialApp(
          title: 'Atom VPN',
          debugShowCheckedModeBanner: false,
          theme: theme,
          home: SplashScreen(),
        );
      }
    );
  }
}
