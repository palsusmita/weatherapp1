import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weatherapp1/consts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);
  Weather? _weather;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _wf.currentWeatherByCityName("paris").then((w){
      setState(() {
        _weather = w;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildUI(),);
  }
  Widget _buildUI() {
    if(_weather == null){
      return const Center(child: CircularProgressIndicator(),);
    }
    return SizedBox(width: MediaQuery.sizeOf(context).width,height: MediaQuery.sizeOf(context).height,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [_locationHeader(),
          SizedBox(height: MediaQuery.sizeOf(context).height*0.08,),
          _dateTimeInfo(),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.05,),
          _weatherIcon(),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.02,),
          _currentTemp(),
        ],
      ),
    );
  }
  Widget _locationHeader(){
    return Text(_weather?.areaName ?? "",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w500),);
  }
  Widget _dateTimeInfo(){
    DateTime now = _weather!.date!;
    return Column(children:
    [Text(DateFormat("h:mm a").format(now),style: const TextStyle(fontSize: 35,),
    ),
      const SizedBox(height: 10,),
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Text("${DateFormat("d.m.y").format(now)}",style: const TextStyle(fontSize: 35,),
        ),
          Text(DateFormat("EEEE").format(now),style: const TextStyle(fontSize: 35,),)],
      )
    ],);
  }
  Widget _weatherIcon(){
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [Container(
        height: MediaQuery.sizeOf(context).height * 0.20,
        decoration: BoxDecoration(image: DecorationImage(image: NetworkImage("http://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png"),),
      ),
      ),
      Text(_weather?.weatherDescription ?? "",style: TextStyle(color: Colors.black,fontSize: 20),),
      ],
    );
  }
  Widget _currentTemp(){
    return Text("${_weather?.temperature?.celsius?.toStringAsFixed(0)} \u2103",style: TextStyle(color: Colors.black,fontSize: 20),);
  }
}
