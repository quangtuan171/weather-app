import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/repository.dart';

class CityListsController extends GetxController {
  RxList<Weather> listResult = <Weather> [].obs;
  RxBool loading = false.obs; 
  List<String> cityLists = []; 

  Future<void> addCity(String cityName) async{
    List<Weather> list =  listResult.value;
    cityLists.add(cityName);
    final prefs = await SharedPreferences.getInstance(); 
      await prefs.setStringList('city', cityLists);
    var weather = await Repository.getCiyWeather(cityName);
    list.add(weather); 
    listResult.value = list;
  } 

  Future<void> deleteCity(String cityName) async{
    cityLists.remove(cityName);
    final prefs = await SharedPreferences.getInstance(); 
      await prefs.setStringList('city', cityLists);
  }

  Future<void> loadCityLists () async {
    final prefs = await SharedPreferences.getInstance();
    cityLists = (prefs.getStringList('city') ?? ['Ho Chi Minh City','Ha Noi', 'Da Nang']);
    loading.value = true; 
    listResult.value = await Repository.getListCityWeather(cityLists);
    loading.value = false; 
  }

  Future<Weather> loadCity (String cityName) async {
    return Repository.getCiyWeather(cityName);
  }
}