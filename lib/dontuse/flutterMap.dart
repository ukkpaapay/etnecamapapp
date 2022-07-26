import 'package:flutter/material.dart';
import 'package:pedantic/pedantic.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_map/flutter_map.dart';
import 'package:geojson/geojson.dart';
import 'package:latlong2/latlong.dart';
import 'package:geopoint/geopoint.dart';

class _RailroadsPageState extends State<RailroadsPage> {
  final lines = <Polyline>[];
  final polygons = <Polygon>[];

  @override
  void initState() {
    processData();
    super.initState();
  }

  Future<void> processData() async {
    final geojson = GeoJson();
    geojson.processedMultiPolygons.listen((GeoJsonMultiPolygon multiPolygon) {
      for (final polygon in multiPolygon.polygons) {
        final geoSerie = GeoSerie(
            type: GeoSerieType.polygon,
            name: polygon.geoSeries[0].name,
            geoPoints: <GeoPoint>[]);
        for (final serie in polygon.geoSeries) {
          if (serie.geoPoints != null) {
            geoSerie.geoPoints.addAll(serie.geoPoints);
          }
        }
        final color =
            Colors.red;
        final poly = Polygon(
            points: geoSerie.toLatLng(ignoreErrors: true), color: color);
        setState(() => polygons.add(poly));
      }
    });
    geojson.endSignal.listen((bool _) => geojson.dispose());
    // The data is from https://datahub.io/core/geo-countries
    final data = await rootBundle.loadString('assets/marine_NPRK_1984.geojson');
    final nameProperty = "ADMIN";
    unawaited(geojson.parse(data, nameProperty: nameProperty, verbose: true));
  }

  // Future<void> processData() async {
  //   // data is from http://www.naturalearthdata.com
  //   final data = await rootBundle.loadString('assets/buffer05_final.geojson');
  //   final geojson = GeoJson();
  //   geojson.processedLines.listen((GeoJsonLine line) {
  //     setState(() => lines.add(Polyline(
  //         strokeWidth: 2.0, color: Colors.red, points: line.geoSerie!.toLatLng())));
  //   });
  //   geojson.endSignal.listen((_) => geojson.dispose());
  //   unawaited(geojson.parse(data, verbose: true));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FlutterMap(
      mapController: MapController(),
      options: MapOptions(
        center: LatLng(13.736717, 100.523186),
        zoom: 8.0,
      ),
      layers: [
        TileLayerOptions(
            urlTemplate:
                'http://mt0.google.com/vt/lyrs=p&hl=th&x={x}&y={y}&z={z}&s=Ga',
            subdomains: ['a', 'b', 'c']),
        PolylineLayerOptions(polylines: lines),
        PolygonLayerOptions(
          polygons: polygons,
        ),
      ],
    ));
  }
}

class RailroadsPage extends StatefulWidget {
  @override
  _RailroadsPageState createState() => _RailroadsPageState();
}
