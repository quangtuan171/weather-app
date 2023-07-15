import 'package:get/get.dart';

class SettingsController extends GetxController {
  Map<String, RxBool> displays = {
    'minTemp' : true.obs,
    'maxTemp' : true.obs,
    'uvIndicator' : true.obs,
    'feltTemp' : true.obs,
    'pressure' : true.obs

  };

  void toggleContainer(String key) {
    displays[key]?.value = !(displays[key]!.value);
  }

}