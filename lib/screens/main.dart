import 'package:flutter/material.dart';
import 'package:pray_remainder/screens/settings.dart';
import 'package:workmanager/workmanager.dart';
import 'package:http/http.dart ' as http;
import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
//import 'package:geocode/geocode.dart';

const simpleDelayedTask = "be.tramckrijte.workmanagerExample.simpleDelayedTask";

const simplePeriodic1HourTask =
    "be.tramckrijte.workmanagerExample.simplePeriodic1HourTask";
const timeTask = "be.tramckrijte.workmanagerExample.firstTimeTask";

const fajrdelay = 'fajrdelay';
const dhuhrdelay = 'dhuhrdelay';
const asrdelay = 'asrdelay';
const magribdelay = 'magribdelay';
const ishaadelay = 'ishaadelay';
dynamic locationData;

//Address place = Address();

@pragma(
    'vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case timeTask:
        await getStatus();
        await getx();
        if (fajrState) {
          await Workmanager().registerOneOffTask(fajrdelay, fajrdelay,
              initialDelay: Duration(minutes: fajrTimerMin));
        }
        if (dhuhrState) {
          await Workmanager().registerOneOffTask(
            dhuhrdelay,
            dhuhrdelay,
            initialDelay: Duration(minutes: dhuhrTimerMin),
          );
        }
        if (asrState) {
          await Workmanager().registerOneOffTask(
            asrdelay,
            asrdelay,
            initialDelay: Duration(minutes: asrTimerMin),
          );
        }
        if (magribState) {
          await Workmanager().registerOneOffTask(
            magribdelay,
            magribdelay,
            initialDelay: Duration(minutes: maghribTimerMin),
          );
        }
        if (ishaState) {
          await Workmanager().registerOneOffTask(
            ishaadelay,
            ishaadelay,
            initialDelay: Duration(minutes: ishaTimerMin),
          );
        }

        break;
      case fajrdelay:
        FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
            FlutterLocalNotificationsPlugin();
        const AndroidInitializationSettings initializationSettingsAndroid =
            AndroidInitializationSettings('@mipmap/ic_launcher');
        const InitializationSettings initializationSettings =
            InitializationSettings(android: initializationSettingsAndroid);

        flutterLocalNotificationsPlugin.initialize(initializationSettings);

        var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
            '0', 'pray time!',
            channelDescription: 'jjjjjjj',
            importance: Importance.max,
            priority: Priority.high,
            showWhen: true);
        NotificationDetails notificationDetails =
            NotificationDetails(android: androidPlatformChannelSpecifics);
        await flutterLocalNotificationsPlugin.show(
            0, 'Not Much Time Left', null, notificationDetails,
            payload: 'item x');
        break;
      case dhuhrdelay:
        FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
            FlutterLocalNotificationsPlugin();
        const AndroidInitializationSettings initializationSettingsAndroid =
            AndroidInitializationSettings('@mipmap/ic_launcher');
        const InitializationSettings initializationSettings =
            InitializationSettings(android: initializationSettingsAndroid);

        flutterLocalNotificationsPlugin.initialize(initializationSettings);

        var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
            '0', 'pray time!',
            channelDescription: 'jjjjjjj',
            importance: Importance.max,
            priority: Priority.high,
            showWhen: true);
        NotificationDetails notificationDetails =
            NotificationDetails(android: androidPlatformChannelSpecifics);
        await flutterLocalNotificationsPlugin.show(
            0, 'Not Much Time Left', null, notificationDetails,
            payload: 'item x');
        break;
      case asrdelay:
        FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
            FlutterLocalNotificationsPlugin();
        const AndroidInitializationSettings initializationSettingsAndroid =
            AndroidInitializationSettings('@mipmap/ic_launcher');
        const InitializationSettings initializationSettings =
            InitializationSettings(android: initializationSettingsAndroid);

        flutterLocalNotificationsPlugin.initialize(initializationSettings);

        var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
            '0', 'pray time!',
            channelDescription: 'jjjjjjj',
            importance: Importance.max,
            priority: Priority.high,
            showWhen: true);
        NotificationDetails notificationDetails =
            NotificationDetails(android: androidPlatformChannelSpecifics);
        await flutterLocalNotificationsPlugin.show(
            0, 'Not Much Time Left', null, notificationDetails,
            payload: 'item x');
        break;
      case magribdelay:
        FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
            FlutterLocalNotificationsPlugin();
        const AndroidInitializationSettings initializationSettingsAndroid =
            AndroidInitializationSettings('@mipmap/ic_launcher');
        const InitializationSettings initializationSettings =
            InitializationSettings(android: initializationSettingsAndroid);

        flutterLocalNotificationsPlugin.initialize(initializationSettings);

        var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
            '0', 'pray time!',
            channelDescription: 'jjjjjjj',
            importance: Importance.max,
            priority: Priority.high,
            showWhen: true);
        NotificationDetails notificationDetails =
            NotificationDetails(android: androidPlatformChannelSpecifics);
        await flutterLocalNotificationsPlugin.show(
            0, 'Not Much Time Left', null, notificationDetails,
            payload: 'item x');
        break;
      case ishaadelay:
        FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
            FlutterLocalNotificationsPlugin();
        const AndroidInitializationSettings initializationSettingsAndroid =
            AndroidInitializationSettings('@mipmap/ic_launcher');
        const InitializationSettings initializationSettings =
            InitializationSettings(android: initializationSettingsAndroid);

        flutterLocalNotificationsPlugin.initialize(initializationSettings);

        var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
            '0', 'pray time!',
            channelDescription: 'jjjjjjj',
            importance: Importance.max,
            priority: Priority.high,
            showWhen: true);
        NotificationDetails notificationDetails =
            NotificationDetails(android: androidPlatformChannelSpecifics);
        await flutterLocalNotificationsPlugin.show(
            0, 'Not Much Time Left', null, notificationDetails,
            payload: 'item x');
        break;
    }

    return Future.value(true);
  });
}

// ignore: prefer_typing_uninitialized_variables
var fajrTimerMin;
// ignore: prefer_typing_uninitialized_variables
var dhuhrTimerMin;
// ignore: prefer_typing_uninitialized_variables
var asrTimerMin;
// ignore: prefer_typing_uninitialized_variables
var maghribTimerMin;
// ignore: prefer_typing_uninitialized_variables
var ishaTimerMin;

bool fajrState = false;
bool? fajrStateStored;

bool dhuhrState = false;
bool? dhuhrStateStored;

bool asrState = true;
bool? asrStateStored;

bool magribState = true;
bool? magribStateStored;

bool ishaState = true;
bool? ishaStateStored;

int remindTime = 10;
bool hour24Format = false;
int fajrOffset = 5;
int dhuhrOffset = 5;
int asrOffset = 3;
int maghribOffset = 11;
int ishaOffset = 5;

Future<void> getStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  remindTime = prefs.getInt('remain') == null ? 10 : prefs.getInt('remain')!;
  hour24Format =
      prefs.getBool('format') == null ? false : prefs.getBool('format')!;
  fajrOffset =
      prefs.getInt('fajrOffset') == null ? 5 : prefs.getInt('fajrOffset')!;
  dhuhrOffset =
      prefs.getInt('dhuhrOffset') == null ? 5 : prefs.getInt('dhuhrOffset')!;
  asrOffset =
      prefs.getInt('asrOffset') == null ? 3 : prefs.getInt('asrOffset')!;
  maghribOffset = prefs.getInt('maghribOffset') == null
      ? 11
      : prefs.getInt('maghribOffset')!;
  ishaOffset =
      prefs.getInt('ishaOffset') == null ? 5 : prefs.getInt('ishaOffset')!;

  fajrStateStored = prefs.getBool('activateFajr');
  fajrStateStored = fajrStateStored ?? false;
  fajrState = fajrStateStored!;

  dhuhrStateStored = prefs.getBool('activateDhuhr');
  dhuhrStateStored = dhuhrStateStored ?? false;
  dhuhrState = dhuhrStateStored!;

  asrStateStored = prefs.getBool('activateAsr');
  asrStateStored = asrStateStored ?? true;
  asrState = asrStateStored!;

  magribStateStored = prefs.getBool('activateMagrib');
  magribStateStored = magribStateStored ?? true;
  magribState = magribStateStored!;

  ishaStateStored = prefs.getBool('activateIsha');
  ishaStateStored = ishaStateStored ?? true;
  ishaState = ishaStateStored!;
}

bool errorLoc = false;
var today = DateTime.now().day;
var now = DateTime.now();
Future<void> getplaces() async {
  city = await x;
}

/* late double lng1;
late double lat1; */
//double lng1 = 15;
//double lat1 = 15;
// ignore: prefer_typing_uninitialized_variables
var city;
String? country;
Future<Map<String, dynamic>> get prayTimeData async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  double lat2 = prefs.getDouble('lat')!;
  double lng2 = prefs.getDouble('lng')!;
  // await getplaces();
  // city = place.timezone.toString().split('/')[1];
  // city = city == 'pricing' ? 'Damascus' : city;
  // country = place.countryName ?? 'Syria';
  final url = Uri.tryParse(//city == 'pricing' ? : city
      'http://api.aladhan.com/v1/timings/$today-${now.month}-${now.year}?latitude=$lat2&longitude=$lng2&method=5');

  final monthPrayTimeEncoded = await http.get(url!);
  final monthPrayTime = await json.decode(monthPrayTimeEncoded.body);
  return await monthPrayTime;
}

Future<Map<String, dynamic>> x = prayTimeData;

Map<String, dynamic>? map;

// ignore: prefer_typing_uninitialized_variables
var fajrTimeMinutes;
// ignore: prefer_typing_uninitialized_variables
var fajrTimeHours;
// ignore: prefer_typing_uninitialized_variables
var dhuhrTimeMinutes;
// ignore: prefer_typing_uninitialized_variables
var dhuhrTimeHours;
// ignore: prefer_typing_uninitialized_variables
var asrTimeMinutes;
// ignore: prefer_typing_uninitialized_variables
var asrTimeHours;
// ignore: prefer_typing_uninitialized_variables
var maghribTimeMinutes;
// ignore: prefer_typing_uninitialized_variables
var maghribTimeHours;
// ignore: prefer_typing_uninitialized_variables
var ishaTimeMinutes;
// ignore: prefer_typing_uninitialized_variables
var ishaTimeHours;

Future<void> getx() async {
  map = await x;
  today = DateTime.now().day;

  final DateTime now = DateTime.now();
  //todo
  var fajrTimeMinutes1 =
      int.parse(map!['data']['timings']['Fajr'].split(':')[1]) + fajrOffset;
  fajrTimeMinutes = fajrTimeMinutes1;
  if (fajrTimeMinutes > 60) {
    fajrTimeMinutes -= 60;
  }
  if (fajrTimeMinutes < 0) {
    fajrTimeMinutes += 60;
  }
  fajrTimeHours = int.parse(map!['data']['timings']['Fajr'].split(':')[0]) +
      fajrTimeMinutes1 ~/ 60;
  //todo

  var fajrTimerHours = fajrTimeHours - now.hour;
  fajrTimerMin = fajrTimeMinutes -
      now.minute +
      (fajrTimerHours < 0 ? (fajrTimerHours += 24) * 60 : fajrTimerHours * 60) -
      remindTime;
  fajrTimerMin = fajrTimerMin < 0 ? fajrTimerMin + 24 * 60 : fajrTimerMin;

  var dhuhrTimeMinutes1 =
      int.parse(map!['data']['timings']['Dhuhr'].split(':')[1]) + dhuhrOffset;
  dhuhrTimeMinutes = dhuhrTimeMinutes1;
  if (dhuhrTimeMinutes > 60) {
    dhuhrTimeMinutes -= 60;
  }
  if (dhuhrTimeMinutes < 0) {
    dhuhrTimeMinutes += 60;
  }

  dhuhrTimeHours = int.parse(map!['data']['timings']['Dhuhr'].split(':')[0]) +
      dhuhrTimeMinutes1 ~/ 60;
  var dhuhrTimerHours = dhuhrTimeHours - now.hour;
  dhuhrTimerMin = dhuhrTimeMinutes -
      now.minute -
      remindTime +
      (dhuhrTimerHours < 0
          ? (dhuhrTimerHours += 24) * 60
          : dhuhrTimerHours * 60);
  dhuhrTimerMin = dhuhrTimerMin < 0 ? dhuhrTimerMin + 24 * 60 : dhuhrTimerMin;

  var asrTimeMinutes1 =
      int.parse(map!['data']['timings']['Asr'].split(':')[1]) + asrOffset;
  asrTimeMinutes = asrTimeMinutes1;
  if (asrTimeMinutes > 60) {
    asrTimeMinutes -= 60;
  }
  if (asrTimeMinutes < 0) {
    asrTimeMinutes += 60;
  }
  asrTimeHours = int.parse(map!['data']['timings']['Asr'].split(':')[0]) +
      asrTimeMinutes1 ~/ 60;

  var asrTimerHours = asrTimeHours - now.hour;
  asrTimerMin = asrTimeMinutes -
      now.minute -
      remindTime +
      (asrTimerHours < 0 ? (asrTimerHours += 24) * 60 : asrTimerHours * 60);
  asrTimerMin = asrTimerMin < 0 ? asrTimerMin + 24 * 60 : asrTimerMin;

  var maghribTimeMinutes1 =
      int.parse(map!['data']['timings']['Maghrib'].split(':')[1]) +
          maghribOffset;
  maghribTimeMinutes = maghribTimeMinutes1;
  if (maghribTimeMinutes > 60) {
    maghribTimeMinutes -= 60;
  }
  if (maghribTimeMinutes < 0) {
    maghribTimeMinutes += 60;
  }
  maghribTimeHours =
      int.parse(map!['data']['timings']['Maghrib'].split(':')[0]) +
          maghribTimeMinutes1 ~/ 60;

  var maghribTimerHours = maghribTimeHours - now.hour;
  maghribTimerMin = maghribTimeMinutes -
      now.minute -
      remindTime +
      (maghribTimerHours < 0
          ? (maghribTimerHours += 24) * 60
          : maghribTimerHours * 60);
  maghribTimerMin =
      maghribTimerMin < 0 ? maghribTimerMin + 24 * 60 : maghribTimerMin;

  var ishaTimeMinutes1 =
      int.parse(map!['data']['timings']['Isha'].split(':')[1]) + ishaOffset;

  ishaTimeMinutes = ishaTimeMinutes1;
  if (ishaTimeMinutes > 60) {
    ishaTimeMinutes -= 60;
  }
  if (ishaTimeMinutes < 0) {
    ishaTimeMinutes += 60;
  }

  ishaTimeHours = int.parse(map!['data']['timings']['Isha'].split(':')[0]) +
      ishaTimeMinutes1 ~/ 60;

  var ishaTimerHours = ishaTimeHours - now.hour;
  ishaTimerMin = ishaTimeMinutes -
      now.minute -
      remindTime +
      (ishaTimerHours < 0 ? (ishaTimerHours += 24) * 60 : ishaTimerHours * 60);
  ishaTimerMin = ishaTimerMin < 0 ? ishaTimerMin + 24 * 60 : ishaTimerMin;

  fakefajrMin = fajrTimeMinutes -
      now.minute +
      (fajrTimerHours < 0 ? (fajrTimerHours += 24) * 60 : fajrTimerHours * 60) -
      remindTime;
  fakefajrMin = fakefajrMin < 0 ? fakefajrMin + 24 * 60 : fakefajrMin;

  fakedhuhrMin = dhuhrTimeMinutes -
      now.minute +
      (dhuhrTimerHours < 0
          ? (dhuhrTimerHours += 24) * 60
          : dhuhrTimerHours * 60);
  fakedhuhrMin = fakedhuhrMin < 0 ? fakedhuhrMin + 24 * 60 : fakedhuhrMin;

  fakeasrMin = asrTimeMinutes -
      now.minute +
      (asrTimerHours < 0 ? (asrTimerHours += 24) * 60 : asrTimerHours * 60);
  fakeasrMin = fakeasrMin < 0 ? fakeasrMin + 24 * 60 : fakeasrMin;

  fakemaghribMin = maghribTimeMinutes -
      now.minute +
      (maghribTimerHours < 0
          ? (maghribTimerHours += 24) * 60
          : maghribTimerHours * 60);
  fakemaghribMin =
      fakemaghribMin < 0 ? fakemaghribMin + 24 * 60 : fakemaghribMin;

  fakeIshaMin = ishaTimeMinutes -
      now.minute +
      (ishaTimerHours < 0 ? (ishaTimerHours += 24) * 60 : ishaTimerHours * 60);
  fakeIshaMin = fakeIshaMin < 0 ? fakeIshaMin + 24 * 60 : fakeIshaMin;

  var myList = [
    fakefajrMin,
    fakedhuhrMin,
    fakeasrMin,
    fakemaghribMin,
    fakeIshaMin,
  ];
  minVal = myList.reduce((curr, next) => curr < next ? curr : next);
  minIndex = myList.indexOf(minVal);
}

// ignore: prefer_typing_uninitialized_variables
var fakefajrMin;
// ignore: prefer_typing_uninitialized_variables
var fakedhuhrMin;
// ignore: prefer_typing_uninitialized_variables
var fakeasrMin;
// ignore: prefer_typing_uninitialized_variables
var fakemaghribMin;
// ignore: prefer_typing_uninitialized_variables
var fakeIshaMin;
int minVal = 123456;
int minIndex = 123456;
List<String> myString = ['Fajr', 'Dhuhr', 'Asr', 'Maghrib', 'Isha'];

class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
    /*  required this.mylat,
    required this.mylng, */
  });
/*   final double mylng;
  final double mylat; */

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  void cancalTasks() async {
    await Workmanager().cancelAll();
  }

// ignore: unused_field
  late Timer _timer;

  @override
  void initState() {
    //  lat1 = widget.mylat;
    //  lng1 = widget.mylng;
    initializeAsyncTasks();
    // lat1 = widget.mylat;
    // lng1 = widget.mylng;
    super.initState();
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  Future<void> initializeAsyncTasks() async {
    // lat1 = widget.mylat;
    //  lng1 = widget.mylng;
    await Workmanager().cancelAll();

    await getplaces();
    await getStatus();
    await getx();
    setState(() {});

    await Workmanager().initialize(
      callbackDispatcher,
      // isInDebugMode: true,
    );

    await Workmanager().registerOneOffTask(
      timeTask,
      timeTask,
    );

    await Workmanager().registerPeriodicTask('firstTimePeriodic', timeTask,
        frequency: const Duration(days: 1));
  }

  Widget getList() {
    getx();
    return FutureBuilder<Map<String, dynamic>>(
      future: x,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var displyedfajr = fajrTimeHours > 12 && !hour24Format
              ? fajrTimeHours - 12
              : fajrTimeHours;

          var displyeddhuhr = dhuhrTimeHours > 12 && !hour24Format
              ? dhuhrTimeHours - 12
              : dhuhrTimeHours;

          var displyedasr = asrTimeHours > 12 && !hour24Format
              ? asrTimeHours - 12
              : asrTimeHours;

          var displyedmagrib = maghribTimeHours > 12 && !hour24Format
              ? maghribTimeHours - 12
              : maghribTimeHours;

          var displyedisha = ishaTimeHours > 12 && !hour24Format
              ? ishaTimeHours - 12
              : ishaTimeHours;

          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ListTile(
                leading: Text('$displyedfajr:$fajrTimeMinutes'),
                title: const Padding(
                  padding: EdgeInsets.only(bottom: 6.3),
                  child: Text('Fajr'),
                ),
                trailing: IconButton(
                    padding: const EdgeInsets.only(bottom: 6.3),
                    onPressed: () async {
                      fajrState = !fajrState;
                      await Workmanager().cancelAll();

                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();

                      await prefs.setBool('activateFajr', fajrState);
                      setState(() {
                        getx();
                      });
                      Workmanager().registerOneOffTask(
                        timeTask,
                        timeTask,
                      );
                      Workmanager().registerPeriodicTask(
                          'firstTimePeriodic', timeTask,
                          frequency: const Duration(days: 1));
                    },
                    icon: fajrState
                        ? const Icon(
                            Icons.notifications_on,
                            color: Colors.blue,
                          )
                        : const Icon(Icons.notifications_off)),
              ),
              ListTile(
                leading: Text('$displyeddhuhr:$dhuhrTimeMinutes'),
                title: const Padding(
                  padding: EdgeInsets.only(bottom: 6.3),
                  child: Text('Dhuhr'),
                ),
                trailing: IconButton(
                    padding: const EdgeInsets.only(bottom: 6.3),
                    onPressed: () async {
                      dhuhrState = !dhuhrState;

                      await Workmanager().cancelAll();
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();

                      await prefs.setBool('activateDhuhr', dhuhrState);
                      setState(() {
                        getx();
                      });
                      Workmanager().registerOneOffTask(
                        timeTask,
                        timeTask,
                      );
                      Workmanager().registerPeriodicTask(
                          'firstTimePeriodic', timeTask,
                          frequency: const Duration(days: 1));
                    },
                    icon: dhuhrState
                        ? const Icon(
                            Icons.notifications_on,
                            color: Colors.blue,
                          )
                        : const Icon(Icons.notifications_off)),
              ),
              ListTile(
                leading: Text('$displyedasr:$asrTimeMinutes'),
                title: const Padding(
                  padding: EdgeInsets.only(bottom: 6.3),
                  child: Text('Asr'),
                ),
                trailing: IconButton(
                    padding: const EdgeInsets.only(bottom: 6.3),
                    onPressed: () async {
                      asrState = !asrState;

                      await Workmanager().cancelAll();
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();

                      await prefs.setBool('activateAsr', asrState);
                      setState(() {
                        getx();
                      });
                      Workmanager().registerOneOffTask(
                        timeTask,
                        timeTask,
                      );
                      Workmanager().registerPeriodicTask(
                          'firstTimePeriodic', timeTask,
                          frequency: const Duration(days: 1));
                    },
                    icon: asrState
                        ? const Icon(
                            Icons.notifications_on,
                            color: Colors.blue,
                          )
                        : const Icon(Icons.notifications_off)),
              ),
              ListTile(
                leading: Text(//todo
                    '$displyedmagrib:$maghribTimeMinutes'),
                title: const Padding(
                  padding: EdgeInsets.only(bottom: 6.3),
                  child: Text('Maghrib'),
                ),
                trailing: IconButton(
                    padding: const EdgeInsets.only(bottom: 6.3),
                    onPressed: () async {
                      magribState = !magribState;

                      await Workmanager().cancelAll();
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();

                      await prefs.setBool('activateMagrib', magribState);
                      setState(() {
                        getx();
                      });
                      Workmanager().registerOneOffTask(
                        timeTask,
                        timeTask,
                      );
                      Workmanager().registerPeriodicTask(
                          'firstTimePeriodic', timeTask,
                          frequency: const Duration(days: 1));
                    },
                    icon: magribState
                        ? const Icon(
                            Icons.notifications_on,
                            color: Colors.blue,
                          )
                        : const Icon(Icons.notifications_off)),
              ),
              ListTile(
                leading: Text('$displyedisha:$ishaTimeMinutes'),
                title: const Padding(
                  padding: EdgeInsets.only(bottom: 6.3),
                  child: Text('Isha'),
                ),
                trailing: IconButton(
                    padding: const EdgeInsets.only(bottom: 6.3),
                    onPressed: () async {
                      ishaState = !ishaState;

                      await Workmanager().cancelAll();
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();

                      await prefs.setBool('activateIsha', ishaState);
                      setState(() {
                        getx();
                      });
                      Workmanager().registerOneOffTask(
                        timeTask,
                        timeTask,
                      );
                      Workmanager().registerPeriodicTask(
                          'firstTimePeriodic', timeTask,
                          frequency: const Duration(days: 1));
                    },
                    icon: ishaState
                        ? const Icon(
                            Icons.notifications_on,
                            color: Colors.blue,
                          )
                        : const Icon(Icons.notifications_off)),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Failed Connecting To Server,Please Try Again Later.'),
          );
        }

        return const SizedBox(
            width: double.infinity,
            child: Center(child: CircularProgressIndicator()));
      },
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void onSave() async {
    await Workmanager().cancelAll();

    await getStatus();
    await getx();
    Workmanager().registerOneOffTask(
      timeTask,
      timeTask,
    );
    Workmanager().registerPeriodicTask('firstTimePeriodic', timeTask,
        frequency: const Duration(days: 1));
    setState(() {});
  }

  String getLeft() {
    int left = (minVal).toInt();
    int hrs = left ~/ 60;
    int mins = left % 60;
    return '$hrs:$mins';
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: Stack(
                children: [
                  Container(
                    child: DateTime.now().hour >= 19 || DateTime.now().hour < 5
                        ? Image.asset(
                            'assets/images/night2.jpeg',
                            fit: BoxFit.fitHeight,
                            width: double.infinity,
                          )
                        : Image.asset(
                            'assets/images/day2.jpeg',
                            fit: BoxFit.fitWidth,
                            width: double.infinity,
                          ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: SizedBox(
                      height: 100,
                      child: Column(
                        children: [
                          if (minIndex != 123456)
                            Text(
                              myString[minIndex],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 24),
                            ),
                          if (minVal != 123456)
                            Text(
                              getLeft(),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 24),
                            ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 22,
                          color: Colors.white,
                        ),
                        city == null
                            ? SizedBox(
                                height: 30,
                                child: errorLoc
                                    ? const Padding(
                                        padding: EdgeInsets.only(top: 10),
                                        child: Text(
                                          'Failed To Get Location,Please Try Again Later.',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )
                                    : const CircularProgressIndicator())
                            : Text(
                                (city['data']['meta']['timezone'])
                                    .toString()
                                    .split('/')[1]
                                    .toString(),
                                style: const TextStyle(
                                    fontSize: 22, color: Colors.white),
                              )
                      ],
                    ),
                  ),
                  Positioned(
                    top: 1,
                    right: 10,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            _scaffoldKey.currentState!.openEndDrawer();
                          },
                          icon: const Icon(
                            Icons.settings,
                            size: 34,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: getList()),
            ),
          ],
        ),
      ),
      endDrawer: SettingsScreen(
        onSave: onSave,
      ),
    );
  }
}
