import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/weathe_model.dart';

class WeatherProvider {
  Future<WeatherModel> getWeather(String city) async {
    final result = await http.Client().get('');

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
