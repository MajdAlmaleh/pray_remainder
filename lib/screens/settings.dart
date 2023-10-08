import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key, required this.onSave});
  final void Function() onSave;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool hour24Format = false;
  int remainingTime = 10;
  int fajrOffset = 5;
  int dhuhrOffset = 5;
  int asrOffset = 3;
  int maghribOffset = 11;
  int ishaOffset = 5;
  void getStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    hour24Format =
        prefs.getBool('format') == null ? false : prefs.getBool('format')!;
    remainingTime =
        prefs.getInt('remain') == null ? 10 : prefs.getInt('remain')!;
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
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getStatus();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                        gradient: DateTime.now().hour >= 19 ||
                                DateTime.now().hour < 5
                            ? const LinearGradient(
                                colors: [Color(0xffffbe16), Color(0xffee7417)])
                            : const LinearGradient(colors: [
                                Color(0xffc3a1b1),
                                Color(0xfffbacb2)
                              ])),
                    child: const Center(
                      child: Text(
                        'Settings',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
                  ),
                  ListTile(
                    title: const Text('24 Hours Format'),
                    trailing: Switch(
                        value: hour24Format,
                        onChanged: (value) async {
                          setState(() {
                            hour24Format = value;
                          });
                        }),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: <Widget>[
                      const Text('Remind Me Before: '),
                      NumberPicker(
                          axis: Axis.horizontal,
                          itemCount: 7,
                          itemHeight: 40,
                          itemWidth: 40,
                          value: remainingTime,
                          minValue: 0,
                          maxValue: 30,
                          onChanged: (value) {
                            setState(() {
                              remainingTime = value;
                            });
                          }),
                      //
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Column(
                    children: <Widget>[
                      const Text('Fajr Offset: '),
                      NumberPicker(
                          axis: Axis.horizontal,
                          itemCount: 7,
                          itemHeight: 40,
                          itemWidth: 40,
                          value: fajrOffset,
                          minValue: -20,
                          maxValue: 20,
                          onChanged: (value) {
                            setState(() {
                              fajrOffset = value;
                            });
                          }),
                      //
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: <Widget>[
                      const Text('Dhuhr Offset: '),
                      NumberPicker(
                          axis: Axis.horizontal,
                          itemCount: 7,
                          itemHeight: 40,
                          itemWidth: 40,
                          value: dhuhrOffset,
                          minValue: -20,
                          maxValue: 20,
                          onChanged: (value) {
                            setState(() {
                              dhuhrOffset = value;
                            });
                          }),
                      //
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: <Widget>[
                      const Text('Asr Offset: '),
                      NumberPicker(
                          axis: Axis.horizontal,
                          itemCount: 7,
                          itemHeight: 40,
                          itemWidth: 40,
                          value: asrOffset,
                          minValue: -20,
                          maxValue: 20,
                          onChanged: (value) {
                            setState(() {
                              asrOffset = value;
                            });
                          }),
                      //
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: <Widget>[
                      const Text('Maghrib Offset: '),
                      NumberPicker(
                          axis: Axis.horizontal,
                          itemCount: 7,
                          itemHeight: 40,
                          itemWidth: 40,
                          value: maghribOffset,
                          minValue: -20,
                          maxValue: 20,
                          onChanged: (value) {
                            setState(() {
                              maghribOffset = value;
                            });
                          }),
                      //
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: <Widget>[
                      const Text('Isha Offset: '),
                      NumberPicker(
                          axis: Axis.horizontal,
                          itemCount: 7,
                          itemHeight: 40,
                          itemWidth: 40,
                          value: ishaOffset,
                          minValue: -20,
                          maxValue: 20,
                          onChanged: (value) {
                            setState(() {
                              ishaOffset = value;
                            });
                          }),
                      //
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setInt('remain', remainingTime);
                  await prefs.setBool('format', hour24Format);
                  await prefs.setInt('fajrOffset', fajrOffset);
                  await prefs.setInt('dhuhrOffset', dhuhrOffset);
                  await prefs.setInt('asrOffset', asrOffset);
                  await prefs.setInt('maghribOffset', maghribOffset);
                  await prefs.setInt('ishaOffset', ishaOffset);

                  widget.onSave();
                },
                child: const Center(child: Text('Save')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
