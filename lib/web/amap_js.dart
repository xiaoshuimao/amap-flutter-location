@JS('AMap')
library amap;

import 'package:js/js.dart';

/// 版本号
external int get v;

/// plugin方法
external Function(dynamic name, void Function() callback) plugin;

///  定位
/// https://lbs.amap.com/api/javascript-api/reference/location#m_AMap.Geolocation
@JS('Geolocation')
class Geolocation {
  external Geolocation();

  external Function(Function(dynamic status, dynamic result) callback)
      getCurrentPosition;
}

@JS()
@anonymous
class GeolocationOptions {
  external factory GeolocationOptions({
    bool? enableHighAccuracy,
    int? timeout,
  });
}
