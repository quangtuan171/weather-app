import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather_app/controller/settings_controller.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late final SettingsController _settingsController;
  @override
  void initState() {
    super.initState();
    _settingsController = Get.find();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  Widget _buildBody() {
    return Container(
        width: double.infinity,
        height: double.infinity,
        // ignore: prefer_const_constructors
        decoration: BoxDecoration(
          color: const Color(0xFFDDE2E4).withOpacity(1),
        ),
        child: Row(
          children: [
            SizedBox(
              width: (MediaQuery.of(context).size.width - 358) / 2,
            ),
            Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  const Text(
                    'Weather settings',
                    style: TextStyle(
                        fontFamily: 'Basier Circle',
                        fontSize: 30,
                        height: 2,
                        color: Color(0xFF414141)),
                  ),
                  Container(
                    width: 358,
                    height: 426,
                    decoration: BoxDecoration(
                        color: const Color(0xFFEBEBEB).withOpacity(0.9),
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0xFF000000).withOpacity(0.25),
                              offset: const Offset(0, 1),
                              blurRadius: 4)
                        ]),
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 41, vertical: 43),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _customRow('Min. Temp.', 'minTemp'),
                          _customRow('Max. Temp.', 'maxTemp'),
                          _customRow('Uv Indicator', 'uvIndicator'),
                          _customRow('Felt Temp', 'feltTemp'),
                          _customRow('Pressure', 'pressure'),
                          _customRow('Air Quality', 'airQuality'),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }

  Widget _customRow(String label, String key) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
              fontFamily: 'Basier Circle',
              fontSize: 20,
              color: Color(0xFF000000)),
        ),
        const Spacer(),
        CupertinoSwitch(
            value: _settingsController.displays[key]?.value ?? false,
            activeColor: CupertinoColors.activeBlue,
            onChanged: (bool? value) {
              _settingsController.toggleContainer(key);
            })
      ],
    );
  }
}
