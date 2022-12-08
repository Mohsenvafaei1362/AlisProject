import 'package:local_notification_flutter_project/ui/screens/Register/Map/models/point_location_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  final bool isSelecting;
  final Ui_PointLocationModel initialLocation;

  const MapScreen(
      {Key? key,
      this.initialLocation = const Ui_PointLocationModel(
          lat: 35.61528764264078, lon: 51.41444737376558, address: ""),
      this.isSelecting = false})
      : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _selectedLocation;
  void _getLocationByTap(_, LatLng position) {
    setState(() {
      _selectedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("نقشه"),
        actions: [
          if (widget.isSelecting)
            IconButton(
                onPressed: _selectedLocation == null
                    ? null
                    : () {
                        Navigator.of(context).pop(_selectedLocation);
                      },
                icon: Icon(Icons.check))
        ],
      ),
      body: FlutterMap(
        options: MapOptions(
          center:
              LatLng(widget.initialLocation.lat, widget.initialLocation.lon),
          zoom: 16,
          onTap: widget.isSelecting ? _getLocationByTap : null,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate:
                'https://mt0.google.com/vt/lyrs=m&hl=en&x={x}&y={y}&z={z}',
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayerOptions(
            markers: (_selectedLocation == null && widget.isSelecting)
                ? []
                : [
                    Marker(
                        width: 80,
                        height: 80,
                        point: _selectedLocation ??
                            LatLng(widget.initialLocation.lat,
                                widget.initialLocation.lon),
                        builder: (_) =>
                            Container(child: const Icon(Icons.location_on)))
                  ],
          )
        ],
      ),
    );
  }
}
