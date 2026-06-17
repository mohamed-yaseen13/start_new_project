import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:map_launcher/map_launcher.dart';

import '../constants/constants.dart';

dynamic openDialogMapsSheet(double lat, double long) async {
  try {
    final coords = Coords(lat, long);
    const title = "Order Address";
    final availableMaps = await MapLauncher.installedMaps;

    showModalBottomSheet(
      context: Constants.globalContext(),
      builder: (BuildContext context) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Wrap(
              children: <Widget>[
                for (var map in availableMaps)
                  ListTile(
                    onTap: () => map.showMarker(coords: coords, title: title),
                    title: Text(map.mapName),
                    leading: SvgPicture.asset(
                      map.icon,
                      height: .10.sh,
                      width: .10.sh,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  } catch (e) {
    return e;
  }
}
