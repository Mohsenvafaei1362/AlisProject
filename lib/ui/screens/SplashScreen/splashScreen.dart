import 'package:local_notification_flutter_project/ui/screens/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: 'assets/images/logo2.png',
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      splashIconSize: 200,
      duration: 1000,
      nextScreen:
          // Test(),
          // Directionality(textDirection: TextDirection.rtl,child:Body(),),
          const Directionality(
        textDirection: TextDirection.rtl,
        child: AuthScreen(),
      ),
      splashTransition: SplashTransition.scaleTransition,
      // pageTransitionType: PageTransitionType.scale,
    );
  }
}
