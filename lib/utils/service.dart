import 'dart:io';
import 'dart:ui';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:employee/utils/notifications.dart';
import 'package:employee/utils/server.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';

//  60:45:cb:8e:17:32
Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      // this will be executed when app is in foreground or background in separated isolate
      onStart: onStart,

      // auto start service
      autoStart: true,
      isForegroundMode: true,
    ),
    iosConfiguration: IosConfiguration(
      // auto start service
      autoStart: true,

      // this will be executed when app is in foreground in separated isolate
      onForeground: onStart,

      // you have to enable background fetch capability on xcode project
      onBackground: onIosBackground,
    ),
  );
  service.startService();
}

// to ensure this is executed
// run app from xcode, then from xcode menu, select Simulate Background Fetch
bool onIosBackground(ServiceInstance service) {
  WidgetsFlutterBinding.ensureInitialized();

  return true;
}

onStart(ServiceInstance service) {
  DartPluginRegistrant.ensureInitialized();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  Connectivity().onConnectivityChanged.listen((network) async {
    if (network == ConnectivityResult.wifi) {
      while (Server.host == null) {
        bool found = await Server.scan();
        if (found) {
          connect(service);
        }
        await Future.delayed(const Duration(minutes: 1));
      }
    } else {
      Server.host = null;
    }
  });
}

void connect(ServiceInstance service) async {
  if (Server.host != null) {
    print('connect');
    service.invoke('connectChange', {'value': true});
    SharedPreferences sp = await SharedPreferences.getInstance();
    try {
      WebSocket ws = await WebSocket.connect(Server.getWsUrl('/ws/attend'),
          headers: {'token': sp.getString('token')});

      ws.listen((event) {
        print(event);
      }).onDone(() async {
        print('disconnect');
        await Future.delayed(const Duration(seconds: 10));
        AppNotifications.send('قطع الاتصال', 'قطع الاتصال');
        connect(service);
        service.invoke('connectChange', {'value': false});
      });
      AppNotifications.send('تم الاتصال', 'تم الاتصال');
    } catch (e) {
      await Future.delayed(const Duration(seconds: 5));
      connect(service);
    }
  }
}
