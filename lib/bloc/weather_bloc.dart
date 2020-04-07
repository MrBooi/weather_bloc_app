import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_bloc_app/model/weathe_model.dart';
import 'package:weather_bloc_app/provider/weather.dart';

class WeatherEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FetchWeather extends WeatherEvent {
  final _city;

  FetchWeather(this._city);

  @override
  // TODO: implement props
  List<Object> get props => [_city];
}

class ResetWeather extends WeatherEvent {}

class WeatherState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class WeatherIsNotSearched extends WeatherState {}

class WeatherIsLoading extends WeatherState {}

class WeatherIsLoaded extends WeatherState {
  final _weather;

  WeatherModel get getWeather => _weather;

  WeatherIsLoaded(this._weather);

  @override
  // TODO: implement props
  List<Object> get props => [_weather];
}

class WeatherIsNotLoaded extends WeatherState {}

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherProvider weatherProvider;

  WeatherBloc(this.weatherProvider);
  @override
  // TODO: implement initialState
  WeatherState get initialState => WeatherIsNotSearched();

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    // TODO: implement mapEventToState
    if (event is FetchWeather) {
      yield WeatherIsLoading();
      try {
        WeatherModel weather = await WeatherProvider().getWeather(event._city);
        yield WeatherIsLoaded(weather);
      } catch (_) {
        yield WeatherIsNotLoaded();
      }
    } else if (event is ResetWeather) {
      yield WeatherIsNotSearched();
    }
  }
}
