import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class SyncfusionMap extends StatefulWidget {
  const SyncfusionMap({Key? key}) : super(key: key);

  @override
  State<SyncfusionMap> createState() => _SyncfusionMapState();
}

class _SyncfusionMapState extends State<SyncfusionMap> {
  late MapShapeSource _mapSource;
  late MapZoomPanBehavior _zoomPanBehavior;
  late List<MapLatLng> polyline;
  late List<List<MapLatLng>> polylines;
  var polylinepoint = [];
  var item = [
    'assets/merge_เขตทะเลชายฝั่ง.geojson',
    'assets/ปิดอ่าวตัวก_310560.geojson',
    'assets/buffer05_final.geojson',
    'assets/marine_NPRK_1984.geojson',
    'assets/เขตไหล่ทวีป-เขตเศรษฐกิจจำเพาะ.geojson',
    'assets/เส้นไหล่ทวีป_NEW.geojson'
  ];
  String dropdownValue = 'assets/merge_เขตทะเลชายฝั่ง.geojson';
  @override
  void initState() {
    // polyline = <MapLatLng>[
    //   MapLatLng(13.736717, 100.523186),
    //   MapLatLng(13.0827, 80.2707),
    //   MapLatLng(13.1746, 79.6117),
    //   MapLatLng(13.6373, 79.5037),
    //   MapLatLng(14.4673, 78.8242),
    //   MapLatLng(14.9091, 78.0092),
    //   MapLatLng(16.2160, 77.3566),
    //   MapLatLng(17.1557, 76.8697),
    //   MapLatLng(18.0975, 75.4249),
    //   MapLatLng(18.5204, 73.8567),
    //   MapLatLng(19.0760, 72.8777),
    // ];
    Readjson();
    // polylines = <List<MapLatLng>>[polyline];
    _zoomPanBehavior = MapZoomPanBehavior();
    MapSource(item[0]);

    print(polyline);
    super.initState();
  }

  MapSource(String path) {
    _mapSource = MapShapeSource.asset(
      path,
      shapeDataField: 'STATE_NAME',
    );
  }

  Readjson() async {
        polyline = <MapLatLng>[
      MapLatLng(13.736717, 100.523186),
      MapLatLng(13.0827, 80.2707),
      MapLatLng(13.1746, 79.6117),
      MapLatLng(13.6373, 79.5037),
      MapLatLng(14.4673, 78.8242),
      MapLatLng(14.9091, 78.0092),
      MapLatLng(16.2160, 77.3566),
      MapLatLng(17.1557, 76.8697),
      MapLatLng(18.0975, 75.4249),
      MapLatLng(18.5204, 73.8567),
      MapLatLng(19.0760, 72.8777),
    ];
    // String data = await DefaultAssetBundle.of(context)
    //     .loadString("assets/buffer05_final.geojson");
    // final jsonResult = jsonDecode(data);
    // polylinepoint = jsonResult['features'][0]['geometry']['coordinates'];
    // polylinepoint.map((e) {
    //   polyline.add(MapLatLng(e[1], e[0]));
    // }).toList();
    polylines = <List<MapLatLng>>[polyline];
    print(polyline);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: SfMaps(
              layers: [
                MapTileLayer(
                  initialZoomLevel: 8,
                  initialFocalLatLng: const MapLatLng(13.736717, 100.523186),
                  // initialFocalLatLng:
                      // const MapLatLng(6.613533895516028, 99.26070300550313),

                  urlTemplate:
                      'http://mt0.google.com/vt/lyrs=p&hl=th&x={x}&y={y}&z={z}&s=Ga',
                  zoomPanBehavior: _zoomPanBehavior,
                  sublayers: [
                    MapShapeSublayer(
                      source: _mapSource,
                      color: Colors.transparent,
                      strokeColor: Colors.blue[800],
                      strokeWidth: 1.5,
                    ),
                    MapPolylineLayer(
                      polylines: List<MapPolyline>.generate(
                        polylines.length,
                        (int index) {
                          return MapPolyline(
                            points: polylines[index],
                          );
                        },
                      ).toSet(),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white,
              ),
              width: 300,
              height: 50,
              margin: EdgeInsets.only(top: 40),
              child: DropdownButton<String>(
                isExpanded: true,
                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                    MapSource(dropdownValue);
                    print(dropdownValue);
                  });
                },
                items: item.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
