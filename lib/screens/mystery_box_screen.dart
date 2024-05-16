import 'dart:math';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../service/hive_service.dart';
import 'alert/win_alert.dart';
import 'components/app_bar_custom_widget.dart';
import 'components/bottom_bar_widget.dart';
import 'components/flip_card_widget.dart';

int pop = 0;
int coof = 1;
ValueNotifier<int> selectI = ValueNotifier(0);
ValueNotifier<int> stake = ValueNotifier(0);
ValueNotifier<bool> hiddenSymbolsGamePlay = ValueNotifier(false);

class MysteryBoxPage extends StatefulWidget {
  const MysteryBoxPage({super.key});

  @override
  State<MysteryBoxPage> createState() => _MysteryBoxPageState();
}

class _MysteryBoxPageState extends State<MysteryBoxPage> {
  final controller1 = FlipCardController();

  int selectHidden1 = 0;
  int selectHidden2 = 0;
  int selectHidden3 = 0;

  @override
  void initState() {
    coof = 1;
    selectI.value = 0;
    stake.value = 0;
    hiddenSymbolsGamePlay.value = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if ((selectHidden1 != 0 && selectHidden2 != 0 && selectHidden3 != 0) ||
        (pop == 0 && selectHidden1 != 0)) {
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          selectHidden1 = 0;
          selectHidden2 = 0;
          selectHidden3 = 0;
          hiddenSymbolsGamePlay.value = false;
          pop = selectI.value;
        });
      });
    }
    return Scaffold(
      backgroundColor: const Color(0xFF1B1B22),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            const AppBarCustomWidget(
              str: 'Mystery Box',
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 26,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 32.0, right: 32),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xFF2B2C37)),
                        padding: const EdgeInsets.only(
                            top: 14, bottom: 11, left: 38, right: 38),
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            const Text(
                              'Boxes to Open',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              height: 11,
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  itemSymbol(1, 1, const Color(0xFF2FAEDE)),
                                  itemSymbol(2, 2, const Color(0xFFB338FF)),
                                  itemSymbol(3, 3, const Color(0xFFE60BEB)),
                                ]),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 44.0, right: 44.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CardMBox(index: 1),
                              CardMBox(index: 2),
                              CardMBox(index: 3),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CardMBox(index: 4),
                              CardMBox(index: 5),
                              CardMBox(index: 6),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CardMBox(index: 7),
                              CardMBox(index: 8),
                              CardMBox(index: 9),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: BottomBarWidget(
                  play: hiddenSymbolsGamePlay,
                  selectI: selectI,
                  stake: stake,
                )),
          ],
        ),
      ),
    );
  }

  Widget itemSymbol(int i, int ix, Color colorset) {
    return GestureDetector(
      onTap: () {
        if (!hiddenSymbolsGamePlay.value) {
          setState(() {
            selectI.value = i;
            coof = ix;
            pop = i;
          });
        }
      },
      child: Container(
        width: (MediaQuery.of(context).size.width - 2 * (32 + 38) - 6) / 3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: i == selectI.value
                ? [Colors.white, Colors.white.withOpacity(0.2)]
                : [Colors.transparent, Colors.transparent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.only(top: 2, bottom: 2),
        alignment: Alignment.center,
        child: Container(
          width:
              (MediaQuery.of(context).size.width - 2 * (32 + 38) - 6 - 12) / 3,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              color: const Color(0xFF2B2C37)),
          padding: const EdgeInsets.all(6),
          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                width: (MediaQuery.of(context).size.width -
                            2 * (32 + 38) -
                            6 -
                            12) /
                        3 -
                    12,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: colorset,
                ),
                alignment: Alignment.center,
                child: Text(
                  i != 1 ? '$i boxs' : '$i box',
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'x$ix',
                style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    height: 1),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget hiddenItem(int index) {
    return GestureDetector(
        onTap: () async {
          setState(() {});
          await controller1.flipCard();
          if (hiddenSymbolsGamePlay.value) {
            // do som
            if (pop > 0) {
              Random random = Random();
              int randomInt = random.nextInt(9) + 1;
              if (randomInt == selectI.value) {
                await showDialog(
                  useSafeArea: false,
                  context: context,
                  builder: (BuildContext context) {
                    return WinAlert(
                      coof: coof,
                      stake: stake.value,
                    );
                  },
                );
                HiveService.updateUserMoney(
                    HiveService.getUser()!.money + stake.value * coof);
                hiddenSymbolsGamePlay.value = false;
                setState(() {
                  selectHidden3 = 0;
                  selectHidden2 = 0;
                  selectHidden1 = 0;
                  pop = selectI.value;
                });
              } else {
                setState(() {
                  if (selectHidden1 != 0 && selectHidden2 != 0) {
                    selectHidden3 = index;
                  } else if (selectHidden1 != 0) {
                    selectHidden2 = index;
                  } else {
                    selectHidden1 = index;
                  }
                });
                pop -= 1;
              }
            }
          }
        },
        child: Container(
          width: (MediaQuery.of(context).size.width - 80 - 10 * 3) / 3,
          height: (MediaQuery.of(context).size.width - 80 - 10 * 3) / 3,
          decoration: selectHidden1 == index
              ? const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          'assets/image/ms_mystery_box/ms_try_again.png')))
              : selectHidden2 == index
                  ? const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/image/ms_mystery_box/ms_try_again.png')))
                  : selectHidden3 == index
                      ? const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/image/ms_mystery_box/ms_try_again.png')))
                      : const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/image/ms_mystery_box/ms_box.png'))),
          child: FlipCardWidget(
            back: Container(
              width: 30,
              height: 30,
              color: Colors.red,
            ),
            front: Container(
              width: 30,
              height: 30,
              color: Colors.blue,
            ),
            controller: controller1,
          ),
        ));
  }
}

class CardMBox extends StatefulWidget {
  final int index;
  const CardMBox({super.key, required this.index});

  @override
  State<CardMBox> createState() => _CardMBoxState();
}

class _CardMBoxState extends State<CardMBox> {
  final controller1 = FlipCardController();

  bool open = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (hiddenSymbolsGamePlay.value) {
          if (pop > 0) {
            if (open) {
              pop += 1;
            } else {
              Random random = Random();
              int randomInt = random.nextInt(9) + 1;
              if (randomInt == selectI.value) {
                await showDialog(
                  useSafeArea: false,
                  context: context,
                  builder: (BuildContext context) {
                    return WinAlert(
                      coof: coof,
                      stake: stake.value,
                    );
                  },
                );
                HiveService.updateUserMoney(
                    HiveService.getUser()!.money + stake.value * coof);
                hiddenSymbolsGamePlay.value = false;
                setState(() {
                  pop = selectI.value + 1;
                });
              } else {
                open = true;
                controller1.flipCard();
              }
            }
          } else {}
          if (pop == 1) {
            Future.delayed(const Duration(milliseconds: 1500), () {
              setState(() {
                hiddenSymbolsGamePlay.value = false;
                pop = selectI.value;
              });
            });
          }
          pop -= 1;
        }
      },
      child: ValueListenableBuilder(
          valueListenable: hiddenSymbolsGamePlay,
          builder: (context, value, child) {
            if (!value) {
              open = false;
              controller1.flipbackCard();
            }
            return FlipCardWidget(
                back: Container(
                    width:
                        (MediaQuery.of(context).size.width - 80 - 10 * 3) / 3,
                    height:
                        (MediaQuery.of(context).size.width - 80 - 10 * 3) / 3,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/image/ms_mystery_box/ms_try_again.png')))),
                front: Container(
                  width: (MediaQuery.of(context).size.width - 80 - 10 * 3) / 3,
                  height: (MediaQuery.of(context).size.width - 80 - 10 * 3) / 3,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/image/ms_mystery_box/ms_box.png'))),
                ),
                controller: controller1);
          }),
    );
  }
}

class PrevPgae extends StatefulWidget {
  final String fdsfds;
  final String dsadas;
  final String azasx;

  PrevPgae({required this.fdsfds, required this.dsadas, required this.azasx});

  @override
  State<PrevPgae> createState() => _PrevPgaeState();
}

class _PrevPgaeState extends State<PrevPgae> {
  late AppsflyerSdk _appsflyerSdk;
  String adId = '';
  String paramsFirst = '';
  String paramsSecond = '';
  Map _deepLinkData = {};
  Map _gcd = {};
  bool _isFirstLaunch = false;
  String _afStatus = '';
  String _campaign = '';
  String _campaignId = '';

  @override
  void initState() {
    super.initState();
    dasfsd();
    fdhgfjg();
  }

  Future<void> dasfsd() async {
    final TrackingStatus status =
        await AppTrackingTransparency.requestTrackingAuthorization();
    print(status);
  }

  Future<void> fsdzsad() async {
    adId = await AppTrackingTransparency.getAdvertisingIdentifier();
  }

  void fdhgfjg() async {
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
      setState(() {
        _deepLinkData = res;
        paramsSecond = res['payload']
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
    });
    _appsflyerSdk.onInstallConversionData((res) {
      print(res);
      setState(() {
        _gcd = res;
        _isFirstLaunch = res['payload']['is_first_launch'];
        _afStatus = res['payload']['af_status'];
        paramsFirst = '&is_first_launch=$_isFirstLaunch&af_status=$_afStatus';
      });
      paramsFirst = '&is_first_launch=$_isFirstLaunch&af_status=$_afStatus';
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
      setState(() {
        _deepLinkData = dp.toJson();
      });
    });

    _appsflyerSdk.startSDK(
      onSuccess: () {
        print("AppsFlyer SDK initialized successfully.");
      },
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: InAppWebView(
          initialUrlRequest: URLRequest(
            url: Uri.parse('${widget.fdsfds}${widget.dsadas}${widget.azasx}'),
          ),
        ),
      ),
    );
  }
}
