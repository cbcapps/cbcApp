import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class FlutterMapPuplicJointCustom extends StatelessWidget {
  const FlutterMapPuplicJointCustom({
    super.key,
    this.mapControllerCus,
    this.onTap,
    this.onPositionChanged,
    this.initialZoomCus = 13.0,
    this.isActive = true,
    required this.initialCenterCus,
    required this.markers,
  });

  final MapController? mapControllerCus;
  final void Function(TapPosition, LatLng)? onTap;
  final void Function(MapCamera, bool)? onPositionChanged;
  final LatLng initialCenterCus;
  final List<Marker> markers;
  final bool isActive;
  final double initialZoomCus;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapControllerCus,
      options: MapOptions(
        onTap: onTap,
        initialCenter: initialCenterCus,
        initialZoom: initialZoomCus,
        onPositionChanged: onPositionChanged,
        interactionOptions: InteractionOptions(
          flags: isActive ? InteractiveFlag.all : InteractiveFlag.none,
        ),
      ),
      children: [
        TileLayer(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: const ['a', 'b', 'c'],
        ),
        MarkerLayer(
          markers: markers,
        ),
      ],
    );
  }
}
