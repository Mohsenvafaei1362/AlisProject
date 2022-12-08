import 'package:local_notification_flutter_project/ui/screens/Register/Map/screens/add_point_screen.dart';
import 'package:local_notification_flutter_project/ui/screens/Register/Map/screens/point_detail_screen.dart';
import 'package:local_notification_flutter_project/ui/screens/Register/Map/screens/point_list_screen.dart';
import 'package:flutter/material.dart';
// import 'package:point_app/screens/add_point_screen.dart';
// import 'package:point_app/screens/point_detail_screen.dart';
// import 'package:point_app/screens/point_list_screen.dart';

class Ui_AppRouter {
  static const String pointListRoute = 'point_list';
  static const String addPointRoute = 'add_point';
  static const String pointDetailsRoute = 'point_details';

  static Route<dynamic> onGeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case pointListRoute:
        return MaterialPageRoute(
          builder: (_) => const PointListScreen(),
        );
      case addPointRoute:
        return MaterialPageRoute(
          builder: (_) => const Ui_AddPointScreen(),
        );
      case pointDetailsRoute:
        return MaterialPageRoute(
            builder: (_) => PointDetailsScreen(
                  id: settings.arguments as String,
                ));
      default:
        throw Exception("Page not found");
    }
  }
}
