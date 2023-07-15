import 'package:dio/dio.dart';
import 'package:weather_app/models/weather.dart';

class Repository{
  static Future<Weather> getCiyWeather(String cityName) async{
    var response = await Dio().get(
        'https://api.weatherapi.com/v1/forecast.json?key=ce0c036fbb464b3493b163120220611&q=$cityName');
    return Weather.fromJSON(response.data);
  }  

  static Future<List<Weather>> getListCityWeather(List<String> cityNames) async {
    List<Weather> listResult = [];
    for (var name in cityNames)
    {
      final weather = await getCiyWeather(name); 
      listResult.add(weather);   
    }
    return listResult;
  }
}