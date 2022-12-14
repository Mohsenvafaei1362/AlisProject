import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:local_notification_flutter_project/test.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/favorit_manager.dart';
import 'package:local_notification_flutter_project/ui/root.dart';
import 'package:local_notification_flutter_project/ui/screens/Register/Map/providers/point_provider.dart';
import 'package:local_notification_flutter_project/ui/theme/theme.dart';
import 'package:provider/provider.dart';

import 'ui/screens/SplashScreen/splashScreen.dart';

main() async {
  // SystemChrome.setSystemUIOverlayStyle(
  //   const SystemUiOverlayStyle(
  //     statusBarColor: Colors.transparent,
  //     statusBarIconBrightness: Brightness.dark,
  //   ),
  // );
  // await favoritmanager.init();
  await Hive.initFlutter();
  await Hive.openBox("points");
  // Bloc.observer = UseBlocObserver();
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = TextStyle(fontFamily: 'Iransans');
    return ChangeNotifierProvider(
        create: (_) => Ui_PointProvider(),
        child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: navigatorKey,
            title: 'Flutter Demo',
            theme: ThemeData(
              hintColor: LightThemeColors.secondaryTextColor,
              inputDecorationTheme: InputDecorationTheme(
                border: const OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: LightThemeColors.primaryTextColors.withOpacity(0.1),
                  ),
                ),
              ),
              scaffoldBackgroundColor: const Color.fromARGB(254, 254, 254, 254),
              textTheme: const TextTheme(
                bodyText2: TextStyle(fontSize: 13, fontFamily: 'IransansDn'),
                bodyText1: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                headline6: TextStyle(
                  fontSize: 16,
                  fontFamily: 'IransansDn',
                  fontWeight: FontWeight.bold,
                ),
                subtitle1: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                subtitle2: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // primaryColor: kPrimaryColor,
              // accentColor: kPrimaryColor,
              appBarTheme: const AppBarTheme(
                  // backgroundColor: Colors.blueAccent[700],
                  ),
              primarySwatch: Colors.blue,
            ),
            // home: SplashScreen(),
            home: Directionality(
              textDirection: TextDirection.rtl,
              child:
                  //
                  // SplashScreen(),
                  // CartScreen()
                  // PaymentReceiptScreen()
                  // ShippingScreen(
                  //     payablePrice: 100, shippingCost: 200, totalPrice: 2000)
                  // Ui_AddPointScreen()
                  // AddPointScreen()
                  // Ui_AddPointScreen()
                  // Congratulation()
                  Splash(),
              // PreviewInfo()
              // HomeScreen_Ui()
              // RootScreen()
              // ComplaintForm()
              // Step123456()
              // Confirmation()
              // MapInfo(),
              // Documents()
              // Confirmation()
              // RootScreen(),
              // HomeScreen1(),
              // AddPointScreen(),
              // Login_(onChanged: (value) {}),
              // Support_Message(),
              // Category(),
              // Body(),
              // StepperPage(),
              // EndFollowUp(),
              // EndRegister()
              // FollowUp(),
              // Body(),
              // Message(),
              // CartProducts(),
              // Wallet(),
              // Settings_Store(),
              // OnlinePayment(),
              // Cart3(),
              // DetailOnline(),
              // Buy(),
              // LoginFour_1(),
              // Test(),
              // MySample()
              // Festival(),
              // NazarSanje(),
              // Operation(),
              // Filter(),
              // Login_Sex(),
              // LoginFour(),
              // LoginFive(),
              // TestLocation(),
              // CodeMoraf(onChanged: ((value) {}))
            )));
  }
}
