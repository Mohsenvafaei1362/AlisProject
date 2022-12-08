import 'package:local_notification_flutter_project/ui/screens/Register/Map/helper/location_helper.dart';
import 'package:local_notification_flutter_project/ui/screens/Register/Map/models/point_location_model.dart';
import 'package:local_notification_flutter_project/ui/screens/Register/Map/screens/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
// import 'package:point_app/helper/location_helper.dart';
// import 'package:point_app/models/point_location_model.dart';
// import 'package:point_app/screens/map_screen.dart';
import 'package:latlong2/latlong.dart';

class LocationWidget extends StatefulWidget {
  final Function selectLocation;
  const LocationWidget({Key? key, required this.selectLocation})
      : super(key: key);

  @override
  _LocationWidgetState createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  String locationImage = "";

  void _getLocationImage(double lat, double lon) {
    String _staticImageUrl = Ui_LocationHelper.Ui_LocationImage(lat, lon);
    setState(() {
      locationImage = _staticImageUrl;
    });
  }

  Future<void> _getLocation() async {
    var locationData = await Location().getLocation();

    widget.selectLocation(Ui_PointLocationModel(
        lat: locationData.latitude!,
        lon: locationData.longitude!,
        address: ""));

    _getLocationImage(locationData.latitude!, locationData.longitude!);
  }

  Future<void> _openMap() async {
    var selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => const MapScreen(
          isSelecting: true,
        ),
      ),
    );

    if (selectedLocation == null) return;

    _getLocationImage(selectedLocation.latitude, selectedLocation.longitude);
    widget.selectLocation(Ui_PointLocationModel(
        lat: selectedLocation.latitude,
        lon: selectedLocation.longitude,
        address: ""));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton.icon(
                onPressed: _getLocation,
                icon: const Icon(
                  Icons.location_on,
                  color: Colors.grey,
                ),
                label: Text(
                  "مکان من",
                  style:
                      TextStyle(color: Colors.grey, fontFamily: 'IransansDn'),
                )),
            TextButton.icon(
                onPressed: _openMap,
                icon: const Icon(
                  Icons.map,
                  color: Colors.grey,
                ),
                label: Text(
                  "انتخاب از روی نقشه",
                  style:
                      TextStyle(color: Colors.grey, fontFamily: 'IransansDn'),
                ))
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          decoration: BoxDecoration(
              // border: Border.all(
              //   width: 1,
              //   color: Colors.grey,
              // ),
              ),
          width: 125,
          height: 125,
          child: locationImage.isEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset('assets/images/59941.jpg'))
              : ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    locationImage,
                    fit: BoxFit.cover,
                  ),
                ),
        ),
      ],
    );
  }
}
