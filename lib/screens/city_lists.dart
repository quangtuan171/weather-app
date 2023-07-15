import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/controller/city_lists_controller.dart';
import 'package:weather_app/models/weather.dart';

class CityLists extends StatefulWidget {
  const CityLists({super.key});

  @override
  State<CityLists> createState() => _CityListsState();
}

class _CityListsState extends State<CityLists> {
  late final CityListsController _cityListsController = CityListsController();
  int i = 0;
  List<String> pool = [
    'Ho Chi Minh City',
    'Ha Noi',
    'Da Nang',
    'London',
    'Paris',
    'Bangkok',
    'Tokyo',
    'Seoul',
    'Berlin',
    'Rome',
    'New York',
    'Ottawa',
    'Moscow'
  ];

  Future<void> _loadAddedCity() async {
    if (pool == []) {
      return;
    }
    for (var item in _cityListsController.cityLists) {
      if (pool[i] == item) {
          pool.removeAt(i);
          await _loadAddedCity();
        }
    }
    _cityListsController.addCity(pool[i]);
    pool.removeAt(i);
    await _cityListsController.loadCityLists();
  }

  @override
  void initState() {
    super.initState();
    _cityListsController.loadCityLists();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: _buildAppBar(),
        body: _buildBody(),
        floatingActionButton: _buildFloatingButton());
  }

  Container _buildFloatingButton() {
    return Container(
      width: 75,
      height: 75,
      margin: const EdgeInsets.fromLTRB(0, 0, 10, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: const Color(0xFFEEEDED).withOpacity(0.2), width: 2),
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFFFFFFFF).withOpacity(0.4),
              const Color(0xFFFFFFFF).withOpacity(0.0)
            ]),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFFFFFF).withOpacity(0.02),
            offset: const Offset(-5, -5),
            blurRadius: 4,
          ),
        ],
      ),
      child: FloatingActionButton(
        onPressed: () {
          _loadAddedCity();
        },
        backgroundColor: Colors.transparent,
        elevation: 0,
        focusElevation: 0,
        child: const Icon(
          Icons.add,
          size: 50,
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: const Padding(
        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
        child: Text(
          'City List',
          textAlign: TextAlign.left,
          style: TextStyle(
              fontFamily: 'Basier Circle', fontSize: 30, color: Colors.white),
        ),
      ),
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
          colors: [
            const Color(0xFF0083b0).withOpacity(1),
            const Color(0xFF008CB8).withOpacity(1),
            const Color(0xFF00b4db).withOpacity(1),
          ],
        )),
        child: Obx(
          () => _cityListsController.loading.value == true
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  itemCount: _cityListsController.listResult.value.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Dismissible(
                      onDismissed: (DismissDirection direction) {
                        _cityListsController.deleteCity(_cityListsController
                            .listResult.value
                            .elementAt(index)
                            .location
                            .name);
                        setState(() {
                          _cityListsController.listResult.value.removeAt(index);
                        });
                      },
                      key: ValueKey<Weather>(_cityListsController
                          .listResult.value
                          .elementAt(index)),
                      child: _buildItems(_cityListsController.listResult.value
                          .elementAt(index)),
                    );
                  }),
        ));
  }

  GestureDetector _buildItems(Weather weather) {
    return GestureDetector(
      onTap: () => Get.back(result: weather.location.name),
      child: Container(
          width: 359,
          height: 131,
          margin: const EdgeInsets.fromLTRB(15, 38, 15, 0),
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border:
                Border.all(color: const Color(0xFFEEEDED).withOpacity(0.2), width: 2),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFFFFFFFF).withOpacity(0.4),
                  const Color(0xFFFFFFFF).withOpacity(0.0)
                ]),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFFFFFF).withOpacity(0.02),
                offset: const Offset(-5, -5),
                blurRadius: 4,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    weather.location.name,
                    style: const TextStyle(
                        fontFamily: 'Basier Circle',
                        fontSize: 30,
                        color: Colors.white),
                  ),
                  const Spacer(),
                  Text(
                    '${weather.current.temp}' + '\u02DA',
                    style: const TextStyle(
                        fontFamily: 'Basier Circle',
                        fontSize: 40,
                        color: Colors.white),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Text(
                  DateFormat("HH:mm").format(DateFormat("yyyy-MM-dd HH:mm").parse(weather.location.localTime)),
                  style: TextStyle(
                      fontFamily: 'Basier Circle',
                      fontSize: 18,
                      color: Colors.white.withOpacity(0.63)),
                ),
              ),
              Row(
                children: [
                  Text(
                    weather.current.condition.text,
                    style: TextStyle(
                        fontFamily: 'Basier Circle',
                        fontSize: 20,
                        color: Colors.white.withOpacity(0.63)),
                  ),
                  const Spacer(),
                  Text(
                    // ignore: prefer_interpolation_to_compose_strings
                    'Max.' +
                        '${(weather.forecast.forecastdays.first.day.maxTemp).toInt()}' +
                        '\u02DA' +
                        ' Min. ' +
                        '${(weather.forecast.forecastdays.first.day.minTemp).toInt()}' +
                        '\u02DA',
                    style: TextStyle(
                        fontFamily: 'Basier Circle',
                        fontSize: 20,
                        color: Colors.white.withOpacity(0.63)),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
