import 'dart:async';
// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html show window;

import 'package:amap_flutter_location/web/amap_js.dart' as AMap;
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:js/js.dart';

/// A web implementation of the AmapFlutterLocation plugin.
class AmapFlutterLocationWeb {
  static void registerWith(Registrar registrar) {
    final MethodChannel channel = MethodChannel(
      'amap_flutter_location',
      const StandardMethodCodec(),
      registrar,
    );

    final pluginInstance = AmapFlutterLocationWeb();
    channel.setMethodCallHandler(pluginInstance.handleMethodCall);
  }

  /// Handles method calls over the MethodChannel of this plugin.
  /// Note: Check the "federated" architecture for a new way of doing this:
  /// https://flutter.dev/go/federated-plugins
  Future<dynamic> handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'getPlatformVersion':
        return getPlatformVersion();
      case 'setLocationOption':
        return setLocationOption();
      case 'setApiKey':
        return setApiKey();
      case 'startLocation':
        return startLocation();
      case 'stopLocation':
        return stopLocation();
      case 'destroy':
        return destroy();
      default:
        throw PlatformException(
          code: 'Unimplemented',
          details:
              'amap_flutter_location for web doesn\'t implement \'${call.method}\'',
        );
    }
  }

  /// Returns a [String] containing the version of the platform.
  Future<String> getPlatformVersion() {
    final version = html.window.navigator.userAgent;
    return Future.value(version);
  }

  setLocationOption() {
    print('web端setLocationOption');
  }

  setApiKey() {
    print(
        'web端在index.html自行加<script type="text/javascript" src="https://webapi.amap.com/maps?v=1.4.15&key=您申请的key值"></script>');
  }

  stopLocation() {
    print('web端stopLocation');
  }

  destroy() {
    print('web端destroy');
  }

  ///开始定位
  Future startLocation() async {
    Completer _completer = Completer();
    AMap.plugin('AMap.Geolocation', allowInterop(() {
      final geolocation =
          AMap.Geolocation(AMap.GeolocationOptions(enableHighAccuracy: true));
      geolocation.getCurrentPosition(allowInterop((status, result) {
        final date = DateTime.now();
        final mapResult = {
          'callbackTime':
              '${date.year}-${date.month < 10 ? '0${date.month}' : date.month}-${date.day < 10 ? '0${date.day}' : date.day} ${date.hour < 10 ? '0${date.hour}' : date.hour}:${date.minute < 10 ? '0${date.minute}' : date.minute}:${date.second < 10 ? '0${date.second}' : date.second}',
          'info': result.info,
          'message': result.message,
          'accuracy': result.accuracy,
          'location_type': result.location_type,
          'latitude': result.position?.lat,
          'longitude': result.position?.lng,
          "country": result.addressComponent?.country,
          "province": result.addressComponent?.province,
          "city": result.addressComponent?.city,
          "district": result.addressComponent?.district,
          "street": result.addressComponent?.street,
          "streetNumber": result.addressComponent?.streetNumber,
          "cityCode": result.addressComponent?.citycode,
          "adCode": result.addressComponent?.adcode,
          "address": result.formattedAddress,
        };
        _completer.complete(mapResult);
      }));
    }));

    return _completer.future;
  }
}
