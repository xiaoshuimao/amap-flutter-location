/// js 用法
// AMap.plugin('AMap.Geolocation', function () {
//             var geolocation = new AMap.Geolocation({
//                 enableHighAccuracy: true,//是否使用高精度定位，默认:true
//             });
//             geolocation.getCurrentPosition(function (status, result) {

//                 if (status == 'complete') {
//                    console.log(result)
//                 } else {
//                     console.log('定位失败');
//                 }
//             });
//         });

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
  external Geolocation(GeolocationOptions? options);

  external Function(Function(dynamic status, GeolocationResult result) callback)
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

/// https://lbs.amap.com/api/javascript-api/reference/location#m_GeolocationResult
@JS()
@anonymous
class GeolocationResult {
  external String? get info;
  external int? get accuracy;
  external String? get message;
  external String? get location_type;
  external Position? get position;
  external AddressComponent? get addressComponent;
  external String? get formattedAddress;
}

/// https://lbs.amap.com/api/javascript-api/reference/core#LngLat
///
///
/// ```json
///    {
///     lat: 30.24148,
///     lng: 120.19995
///    }
/// ```
///
///
@JS()
@anonymous
class Position {
  external String get lat;
  external String get lng;
}

///
///
/// ```json
///    {
///
///     country: "中国",
///     province: "浙江省",
///     city: "杭州市",
///     district: "上城区",
///     street: "徐家埠路",
///     streetNumber: "85号",
///     citycode: "0571",
///     adcode: "330102",
///    }
/// ```
///
///
@JS()
@anonymous
class AddressComponent {
  external String get country;
  external String get province;
  external String get city;
  external String get district;
  external String get street;
  external String get streetNumber;
  external String get citycode;
  external String get adcode;
}
