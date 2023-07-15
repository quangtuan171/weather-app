class Weather{
  Location location; 
  Current current;
  Forecast forecast;

  Weather(
    {
      required this.location,
      required this.current,
      required this.forecast,
    }
  );

  factory Weather.fromJSON(Map<String, dynamic> parsedJson) {
    return Weather(
      location: Location.fromJSON(parsedJson['location']),
      current: Current.fromJSON(parsedJson['current']),
      forecast: Forecast.fromJSON(parsedJson['forecast']),
);
}
}

class Location {
  String name;
  String localTime;

  Location(
    {
      required this.name,
      required this.localTime
    }
  );

  factory Location.fromJSON(Map<String, dynamic> parsedJson){
    return Location(
      name: parsedJson['name'], 
      localTime: parsedJson['localtime']
      );
  }
}

class Current {
  double temp;
  double pressure;
  double feelsLike;
  double uv; 
  Conditions condition;

  Current(
    {
      required this.temp,
      required this.pressure,
      required this.feelsLike,
      required this.uv,
      required this.condition
    }
  );

  factory Current.fromJSON(Map<String, dynamic> parsedJson){
    return Current(
      temp: parsedJson['temp_c'], 
      pressure: parsedJson['pressure_mb'],
      feelsLike: parsedJson['feelslike_c'],
      uv: parsedJson['uv'],
      condition: Conditions.fromJSON(parsedJson['condition'])
      );
  }

}

class Conditions {
  String text;

  Conditions({required this.text});

  factory Conditions.fromJSON(Map<String, dynamic> parsedJson){
    return Conditions(
      text: parsedJson['text']
      );
  }
}

class Forecast {
  List<Forecastday> forecastdays;
  
  Forecast({required this.forecastdays});

  factory Forecast.fromJSON(Map<String, dynamic> parsedJson){
    return Forecast(
      forecastdays: (parsedJson['forecastday'] as List).map((i) =>Forecastday.fromJSON(i)).toList()
      );
  }

}

class Forecastday {
  Day day;

  Forecastday({required this.day});

  factory Forecastday.fromJSON(Map<String, dynamic> parsedJson){
    return Forecastday(
      day: Day.fromJSON(parsedJson['day'])
      );
  }
}

class Day {
  double minTemp;
  double maxTemp;

  Day(
    {
      required this.minTemp,
      required this.maxTemp
    }
  );

  factory Day.fromJSON(Map<String, dynamic> parsedJson){
    return Day(
      minTemp: parsedJson['mintemp_c'],
      maxTemp: parsedJson['maxtemp_c']
      );
  }
}

