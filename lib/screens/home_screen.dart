import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/controller/city_lists_controller.dart';
import 'package:weather_app/screens/city_lists.dart';
import 'package:weather_app/controller/settings_controller.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/screens/settings.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  late final SettingsController _settingsController;
  late final CityListsController _cityListsController = CityListsController();
  var weather;
  String name = '';

  @override
  void initState() {
    super.initState();
    _settingsController = Get.put(SettingsController());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Weather>(
        future: name == '' ? _cityListsController.loadCity('Ho Chi Minh City') : _cityListsController.loadCity(name),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            weather = (snapshot.data);
            return Scaffold(
                extendBodyBehindAppBar: true,
                appBar: _buildAppBar(),
                body: _buildBody());
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }
          return Container();
        });
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            child: Text(
              weather.location.name,
              textAlign: TextAlign.left,
              style: const TextStyle(
                  fontFamily: 'Basier Circle',
                  fontSize: 30,
                  color: Colors.white),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Text(
              DateFormat.yMMMMd('en_US')
                  .format(DateFormat("yyyy-MM-dd ").parse(weather.location.localTime)),
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontFamily: 'Basier Circle',
                  fontSize: 18,
                  color: Colors.white.withOpacity(0.63)),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        IconButton(
            icon: const Icon(
              Icons.apps,
              size: 35,
            ),
            onPressed : () async {
              name = await Get.to(() => const CityLists());
              setState(() {         
              });
            }),
        IconButton(
            icon: const Icon(
              Icons.settings,
              size: 35,
            ),
            onPressed: () {
              Get.to(() => const SettingsPage());
            }),
      ],
    );
  }

  Widget _buildBody() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors:  [
          const Color(0xFF0083b0).withOpacity(1),
          const Color(0xFF008CB8).withOpacity(1),
          const Color(0xFF00b4db).withOpacity(1),
        ],
      )),
      child: Column(
        children: [
          const SizedBox(
            height: 90,
          ),
          Image.asset(
            'assets/images/sun_cloud.png',
            width: 161,
            height: 122,
          ),
          Text(
            '${weather.current.temp}' + '\u02DA',
            style: const TextStyle(
                fontFamily: 'Basier Circle', fontSize: 40, color: Colors.white),
          ),
          Text(
            '${weather.current.condition.text}',
            style: const TextStyle(
                fontFamily: 'Basier Circle', fontSize: 20, color: Colors.white),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              SizedBox(
                width: (MediaQuery.of(context).size.width - 360) / 2,
              ),
              Obx(
                () => Visibility(
                  visible: _settingsController.displays['minTemp']!.value,
                  child: Container(
                      alignment: Alignment.topLeft,
                      width: 160,
                      height: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                            color: const Color(0xFFEEEDED).withOpacity(0.2),
                            width: 2),
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              const Color(0xFFFFFFFF).withOpacity(0.5),
                              const Color(0xFFEEEDED).withOpacity(0.1)
                            ]),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFFFFFF).withOpacity(0.02),
                            offset: const Offset(-5, -5),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Row(children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              child: Text(
                                'MIN TEMP',
                                style: TextStyle(
                                    fontFamily: 'Basier Circle',
                                    fontSize: 15,
                                    color: Colors.white.withOpacity(0.49)),
                              ),
                            ),
                            SizedBox(
                              child: Text(
                                '${(weather.forecast.forecastdays.first.day.minTemp).toInt()}' +
                                    '\u02DA',
                                style: const TextStyle(
                                    fontFamily: 'Basier Circle',
                                    fontSize: 30,
                                    color: Colors.white),
                              ),
                            ),
                            const SizedBox(
                                child: Text(
                              'Min',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontFamily: 'Basier Circle',
                                  fontSize: 30,
                                  color: Colors.white),
                            )),
                          ],
                        ),
                      ])),
                ),
              ),
              const Spacer(),
              Obx(() => Visibility(
                    visible: _settingsController.displays['maxTemp']!.value,
                    child: Container(
                        width: 160,
                        height: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                              color: const Color(0xFFEEEDED).withOpacity(0.2),
                              width: 2),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                const Color(0xFFFFFFFF).withOpacity(0.5),
                                const Color(0xFFEEEDED).withOpacity(0.1)
                              ]),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFFFFFFF).withOpacity(0.02),
                              offset: const Offset(-5, -5),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Row(children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                child: Text(
                                  'MAX TEMP',
                                  style: TextStyle(
                                      fontFamily: 'Basier Circle',
                                      fontSize: 15,
                                      color: Colors.white.withOpacity(0.49)),
                                ),
                              ),
                              SizedBox(
                                child: Text(
                                  '${(weather.forecast.forecastdays.first.day.maxTemp).toInt()}' +
                                      '\u02DA',
                                  style: const TextStyle(
                                      fontFamily: 'Basier Circle',
                                      fontSize: 30,
                                      color: Colors.white),
                                ),
                              ),
                              const SizedBox(
                                  child: Text(
                                'Max',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontFamily: 'Basier Circle',
                                    fontSize: 30,
                                    color: Colors.white),
                              )),
                            ],
                          ),
                        ])),
                  )),
              SizedBox(
                width: (MediaQuery.of(context).size.width - 360) / 2,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                width: (MediaQuery.of(context).size.width - 360) / 2,
              ),
              Obx(
                (() => Visibility(
                      visible:
                          _settingsController.displays['uvIndicator']!.value,
                      child: Container(
                          width: 160,
                          height: 180,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(
                                color: const Color(0xFFEEEDED).withOpacity(0.2),
                                width: 2),
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  const Color(0xFFFFFFFF).withOpacity(0.5),
                                  const Color(0xFFEEEDED).withOpacity(0.1)
                                ]),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFFFFFFF).withOpacity(0.02),
                                offset: const Offset(-5, -5),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: Row(children: [
                            const SizedBox(
                              width: 10,
                            ),
                            _getUvWidget(),
                          ])),
                    )),
              ),
              const Spacer(),
              SizedBox(
                height: 180,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Obx(
                      (() => Visibility(
                            visible:
                                _settingsController.displays['feltTemp']!.value,
                            child: Container(
                                width: 160,
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  border: Border.all(
                                      color: const Color(0xFFEEEDED).withOpacity(0.2),
                                      width: 2),
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        const Color(0xFFFFFFFF).withOpacity(0.5),
                                        const Color(0xFFEEEDED).withOpacity(0.1)
                                      ]),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          const Color(0xFFFFFFFF).withOpacity(0.02),
                                      offset: const Offset(-5, -5),
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                                child: Row(children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        child: Text(
                                          'FEELS LIKE',
                                          style: TextStyle(
                                              fontFamily: 'Basier Circle',
                                              fontSize: 15,
                                              color: Colors.white
                                                  .withOpacity(0.49)),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      SizedBox(
                                        child: Text(
                                          '${(weather.current.feelsLike).toInt()}' + '\u02DA',
                                          style: const TextStyle(
                                              fontFamily: 'Basier Circle',
                                              fontSize: 30,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ])),
                          )),
                    ),
                    const Spacer(),
                    Obx(
                      () => Visibility(
                        visible: _settingsController.displays['pressure']!.value,
                        child: Container(
                            width: 160,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(
                                  color: const Color(0xFFEEEDED).withOpacity(0.2),
                                  width: 2),
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    const Color(0xFFFFFFFF).withOpacity(0.4),
                                    const Color(0xFFEEEDED).withOpacity(0.1)
                                  ]),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFFFFFFF).withOpacity(0.1),
                                  blurRadius: 1,
                                ),
                              ],
                            ),
                            child: Row(children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    child: Text(
                                      'PRESSURE',
                                      style: TextStyle(
                                          fontFamily: 'Basier Circle',
                                          fontSize: 15,
                                          color:
                                              Colors.white.withOpacity(0.49)),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    child: Text(
                                      '${(weather.current.pressure).toInt()}' + ' hPa',
                                      style: const TextStyle(
                                          fontFamily: 'Basier Circle',
                                          fontSize: 30,
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ])),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: (MediaQuery.of(context).size.width - 360) / 2,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget getUvWidget() {
    if ((weather.current.uv >= 0.0) && (weather.current.uv <= 2.0)) {
      return const Text(
        'Low',
        textAlign: TextAlign.left,
        style: TextStyle(
            fontFamily: 'Basier Circle', fontSize: 30, color: Colors.white),
      );
    } else if ((weather.current.uv >= 3.0) && (weather.current.uv <= 5.0)) {
      return const Text(
        'Moderate',
        textAlign: TextAlign.left,
        style: TextStyle(
            fontFamily: 'Basier Circle', fontSize: 30, color: Colors.white),
      );
    }
    return const Text(
      'High',
      textAlign: TextAlign.left,
      style: TextStyle(
          fontFamily: 'Basier Circle', fontSize: 30, color: Colors.white),
    );
  }

  Widget _getUvWidget() {
    if ((weather.current.uv >= 0.0) && (weather.current.uv <= 2.0)) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            child: Text(
              'Uv Indicator',
              style: TextStyle(
                  fontFamily: 'Basier Circle',
                  fontSize: 15,
                  color: Colors.white.withOpacity(0.49)),
            ),
          ),
          SizedBox(
            child: Text(
              '${(weather.current.uv).toInt()}',
              style: const TextStyle(
                  fontFamily: 'Basier Circle',
                  fontSize: 30,
                  color: Colors.white),
            ),
          ),
          const SizedBox(
              child: Text(
            'Low',
            textAlign: TextAlign.left,
            style: TextStyle(
                fontFamily: 'Basier Circle', fontSize: 30, color: Colors.white),
          )),
          const SizedBox(
            height: 15,
          ),
          const SizedBox(
            child: Text(
              'Low level during \nall the day',
              style: TextStyle(
                  fontFamily: 'Basier Circle',
                  fontSize: 15,
                  color: Colors.white),
            ),
          ),
        ],
      );
    } else if ((weather.current.uv >= 3.0) && (weather.current.uv <= 5.0)) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            child: Text(
              'Uv Indicator',
              style: TextStyle(
                  fontFamily: 'Basier Circle',
                  fontSize: 15,
                  color: Colors.white.withOpacity(0.49)),
            ),
          ),
          SizedBox(
            child: Text(
              '${(weather.current.uv).toInt()}',
              style: const TextStyle(
                  fontFamily: 'Basier Circle',
                  fontSize: 30,
                  color: Colors.white),
            ),
          ),
          const SizedBox(
              child: Text(
            'Moderate',
            textAlign: TextAlign.left,
            style: TextStyle(
                fontFamily: 'Basier Circle', fontSize: 30, color: Colors.white),
          )),
          const SizedBox(
            height: 15,
          ),
          const SizedBox(
            child: Text(
              'Moderate level \nduring all the day',
              style: TextStyle(
                  fontFamily: 'Basier Circle',
                  fontSize: 15,
                  color: Colors.white),
            ),
          ),
        ],
      );
    }
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            child: Text(
              'Uv Indicator',
              style: TextStyle(
                  fontFamily: 'Basier Circle',
                  fontSize: 15,
                  color: Colors.white.withOpacity(0.49)),
            ),
          ),
          SizedBox(
            child: Text(
              '${(weather.current.uv).toInt()}',
              style: const TextStyle(
                  fontFamily: 'Basier Circle',
                  fontSize: 30,
                  color: Colors.white),
            ),
          ),
          const SizedBox(
              child: Text(
            'High',
            textAlign: TextAlign.left,
            style: TextStyle(
                fontFamily: 'Basier Circle', fontSize: 30, color: Colors.white),
          )),
          const SizedBox(
            height: 15,
          ),
          const SizedBox(
            child: Text(
              'High level during \nall the day',
              style: TextStyle(
                  fontFamily: 'Basier Circle',
                  fontSize: 15,
                  color: Colors.white),
            ),
          ),
        ],
      );
  }
}
