import 'dart:async';
// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html show window;

import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

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

  // StreamController<Map<String, Object>> _receiveStream;
  // StreamSubscription<Map<String, Object>> _subscription;
  // static const String _CHANNEL_STREAM_LOCATION = "amap_flutter_location_stream";
  // static const EventChannel _eventChannel =
  //     const EventChannel(_CHANNEL_STREAM_LOCATION);
  String _pluginKey;
  // static Stream<Map<String, Object>> _onLocationChanged = _eventChannel
  //     .receiveBroadcastStream()
  //     .asBroadcastStream()
  //     .map<Map<String, Object>>((element) => element.cast<String, Object>());

  AmapFlutterLocationWeb() {
    _pluginKey = DateTime.now().millisecondsSinceEpoch.toString();
  }

  /// Handles method calls over the MethodChannel of this plugin.
  /// Note: Check the "federated" architecture for a new way of doing this:
  /// https://flutter.dev/go/federated-plugins
  Future<dynamic> handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'getPlatformVersion':
        return getPlatformVersion();
      case 'setApiKey':
        return setApiKey();
      case 'onLocationChanged':
        return onLocationChanged();
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

  setApiKey() {
    print(
        'web端在index.html自行加<script type="text/javascript" src="https://webapi.amap.com/maps?v=1.4.15&key=您申请的key值"></script>');
  }

  onLocationChanged() {
    // if (_receiveStream == null) {
    final receiveStream = StreamController<Map<String, Object>>();
    //   _subscription = _onLocationChanged.listen((Map<String, Object> event) {
    //     if (event != null && event['pluginKey'] == _pluginKey) {
    //       Map<String, Object> newEvent = Map<String, Object>.of(event);
    //       newEvent.remove('pluginKey');
    //       _receiveStream.add(newEvent);
    //     }
    //   });
    // }
    receiveStream.add({'x': 1});
    final x = receiveStream.stream;
    print(x);
    return x;
  }

  ///开始定位
  void startLocation() {}
}
