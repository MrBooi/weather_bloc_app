import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_bloc_app/model/weathe_model.dart';

import '../bloc/weather_bloc.dart';

import '../componets/weather/show_weather.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var cityController = TextEditingController();
  WeatherModel weather;

  var weatherBloc;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    weatherBloc = BlocProvider.of<WeatherBloc>(context);
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildLogo(),
          BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is WeatherIsNotSearched)
                return buildTextField();
              else if (state is WeatherIsLoading)
                return Center(
                  child: CupertinoActivityIndicator(),
                );
              else if (state is WeatherIsLoaded) {
                print('------------${state.getWeather}----------------');
                return ShowWeather(state.getWeather, cityController.text);
              } else
                return Center(
                  child: Text(
                    'Error',
                    style: TextStyle(color: Colors.white),
                  ),
                );
            },
          )
        ],
      ),
    );
  }

  Widget buildLogo() {
    return Center(
      child: Container(
        child: Icon(Icons.cloud),
        height: 300,
        width: 300,
      ),
    );
  }

  Widget buildTextField() {
    // var weatherBloc = BlocProvider.of<WeatherBloc>(context);
    return Container(
      padding: EdgeInsets.only(
        left: 32,
        right: 32,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Search Weather",
            style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w500,
                color: Colors.white70),
          ),
          Text(
            "Instanly",
            style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w200,
                color: Colors.white70),
          ),
          SizedBox(
            height: 24,
          ),
          TextFormField(
            controller: cityController,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: Colors.white70,
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                      color: Colors.white70, style: BorderStyle.solid)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide:
                      BorderSide(color: Colors.blue, style: BorderStyle.solid)),
              hintText: "City Name",
              hintStyle: TextStyle(color: Colors.white70),
            ),
            style: TextStyle(color: Colors.white70),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            height: 50,
            child: FlatButton(
              shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              onPressed: () {
                weatherBloc.add(FetchWeather(cityController.text));
              },
              color: Colors.lightBlue,
              child: Text(
                "Search",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
            ),
          )
        ],
      ),
    );
  }
}
