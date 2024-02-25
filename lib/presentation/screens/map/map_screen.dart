import 'dart:async';

import 'package:fuiopia/configs/size_config.dart';
import 'package:fuiopia/constants/constants.dart';
import 'package:fuiopia/presentation/widgets/custom_widgets.dart';
import 'package:fuiopia/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition HA_NOI = CameraPosition(
    target: LatLng(21.027763, 105.834160),
    zoom: 14.4746,
  );
  String kGoogleApiKey = "AIzaSyCujk4bJgwEECcDYwX9e0CRiYQFlWzhFU4";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Map")),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: HA_NOI,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          CustomCardWidget(
              margin: EdgeInsets.all(SizeConfig.defaultSize * 1.5),
              height: SizeConfig.defaultSize * 5,
              child: SearchFieldWidget(
                hintText: Translate.of(context).translate("search"),
              )),
        ],
      ),
      bottomNavigationBar: DefaultButton(
        onPressed: () {},
        child: Text(
          Translate.of(context).translate("select"),
          style: FONT_CONST.BOLD_WHITE_18,
        ),
      ),
    );
  }
}
