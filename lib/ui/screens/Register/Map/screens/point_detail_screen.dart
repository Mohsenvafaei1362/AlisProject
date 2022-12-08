import 'package:local_notification_flutter_project/ui/screens/Register/Map/providers/point_provider.dart';
import 'package:local_notification_flutter_project/ui/screens/Register/Map/screens/map_screen.dart';
import 'package:flutter/material.dart';
// import 'package:point_app/screens/map_screen.dart';
import 'package:provider/provider.dart';
// import 'package:point_app/providers/point_provider.dart';
import '../models/point_location_model.dart';

class PointDetailsScreen extends StatelessWidget {
  final String id;
  const PointDetailsScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var point =
        Provider.of<Ui_PointProvider>(context, listen: false).getById(id);
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            child: Image.file(
              point.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(point.location.address),
          const SizedBox(
            height: 10,
          ),
          TextButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => MapScreen(
                        initialLocation: Ui_PointLocationModel(
                            lat: point.location.lat,
                            lon: point.location.lon,
                            address: ""),
                        isSelecting: false,
                      ))),
              child: Text("نمایش روی نقشه"))
        ],
      ),
    );
  }
}
