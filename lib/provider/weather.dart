import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/weathe_model.dart';

import '../api_keys.dart';

class WeatherProvider {
  Future<WeatherModel> getWeather(String city) async {
    final result = await http.Client().get(
        "https://api.openweathermap.org/data/2.5/weather?q=$city&APPID=43ea6baaad7663dc17637e22ee6f78f2");

    if (result.statusCode != 200) {
      throw Exception();
    }
    parsedJson(result.body);
  }

  WeatherModel parsedJson(final response) {
    final jsonDecoded = json.decode(response);
    final jsonData = jsonDecoded['main'];
    return WeatherModel.fromJson(jsonData);
  }
}
